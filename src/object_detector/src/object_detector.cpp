// The contents of this file are in the public domain. See LICENSE_FOR_EXAMPLE_PROGRAMS.txt
/*

    This is an example showing how you might use dlib to create a reasonably 
    functional command line tool for object detection.  This example assumes 
    you are familiar with the contents of at least the following example 
    programs:
        - fhog_object_detector_ex.cpp
        - compress_stream_ex.cpp




    This program is a command line tool for learning to detect objects in images.  
    Therefore, to create an object detector it requires a set of annotated training 
    images.  To create this annotated data you will need to use the imglab tool 
    included with dlib.  It is located in the tools/imglab folder and can be compiled
    using the following commands.  
        cd tools/imglab
        mkdir build
        cd build
        cmake ..
        cmake --build . --config Release
    Note that you may need to install CMake (www.cmake.org) for this to work.  

    Next, let's assume you have a folder of images called /tmp/images.  These images 
    should contain examples of the objects you want to learn to detect.  You will 
    use the imglab tool to label these objects.  Do this by typing the following
        ./imglab -c mydataset.xml /tmp/images
    This will create a file called mydataset.xml which simply lists the images in 
    /tmp/images.  To annotate them run
        ./imglab mydataset.xml
    A window will appear showing all the images.  You can use the up and down arrow 
    keys to cycle though the images and the mouse to label objects.  In particular, 
    holding the shift key, left clicking, and dragging the mouse will allow you to 
    draw boxes around the objects you wish to detect.  So next, label all the objects 
    with boxes.  Note that it is important to label all the objects since any object 
    not labeled is implicitly assumed to be not an object we should detect.  If there
    are objects you are not sure about you should draw a box around them, then double
    click the box and press i.  This will cross out the box and mark it as "ignore".
    The training code in dlib will then simply ignore detections matching that box.
    

    Once you finish labeling objects go to the file menu, click save, and then close 
    the program. This will save the object boxes back to mydataset.xml.  You can verify 
    this by opening the tool again with
        ./imglab mydataset.xml
    and observing that the boxes are present.

    Returning to the present example program, we can compile it using cmake just as we 
    did with the imglab tool.  Once compiled, we can issue the command 
        ./train_object_detector -tv mydataset.xml
    which will train an object detection model based on our labeled data.  The model 
    will be saved to the file object_detector.svm.  Once this has finished we can use 
    the object detector to locate objects in new images with a command like
        ./train_object_detector some_image.png
    This command will display some_image.png in a window and any detected objects will
    be indicated by a red box.

    Finally, to make running this example easy dlib includes some training data in the
    examples/faces folder.  Therefore, you can test this program out by running the
    following sequence of commands:
      ./train_object_detector -tv examples/faces/training.xml -u1 --flip
      ./train_object_detector --test examples/faces/testing.xml -u1
      ./train_object_detector examples/faces/*.jpg -u1
    That will make a face detector that performs perfectly on the test images listed in
    testing.xml and then it will show you the detections on all the images.
*/

#include <object_detector/object_detector.h>

//#define DEBUG_MODE

ObjectDetector::ObjectDetector(int argc, char** argv) : it_(nh_), image_sub_(it_, "/camera/rgb/image_raw", 1),
    depth_sub_(it_, "/camera/depth/image_raw", 1), sync(MySyncPolicy(10), image_sub_, depth_sub_)
    {
        // Subscrive to input video feed and publish output video feed
        /*image_sub_ = it_.subscribe("/camera/rgb/image_raw", 2,
        &ObjectDetector::imageCb, this);
        depth_sub_ = it_.subscribe("/camera/depth/image_raw", 2, &ObjectDetector::depthCb, this);*/

        sync.registerCallback(boost::bind(&ObjectDetector::imagesCb, this, _1, _2));

        image_pub_ = it_.advertise("/image_converter/output_video", 2);
        vis_pub = nh_.advertise<visualization_msgs::MarkerArray>("face_feature_array", 2);

        robotPos = nh_.subscribe<geometry_msgs::PoseStamped>("omnivelma/pose", 2, &ObjectDetector::robotCb, this);

        peoplePosePublisher = nh_.advertise<people_msgs::People>("people_detected", 2);

        //dlib initializing

        parser.add_option("nose_detector", "Path to svm - previously trained nose detector by train_object_detector",1);
        parser.add_option("side_detector", "Path to svm - previously trained side detector by train_object_detector",1);
        parser.add_option("back_detector", "Path to svm - previously trained back detector by train_object_detector",1);
        parser.add_option("front_detector", "Path to svm - previously trained front detector by train_object_detector",1);

        parser.add_option("u", "Upsample each input image <arg> times. Each upsampling quadruples the number of pixels in the image (default: 0).", 1);

        parser.parse(argc, argv);
        parser.check_option_arg_range("u", 0, 8);

        // Get the upsample option from the user but use 0 if it wasn't given.
        upsample_amount = get_option(parser, "u", 0);
        pathToNoseSVM = get_option(parser, "nose_detector", "null");
        pathToSideSVM = get_option(parser, "side_detector", "null");
        pathToBackSVM = get_option(parser, "back_detector", "null");
        pathToFrontSVM = get_option(parser, "front_detector", "null");

        if(pathToNoseSVM == "null" || pathToSideSVM == "null" || pathToBackSVM == "null" || pathToFrontSVM == "null")
        {
        ROS_ERROR_STREAM("You need to give previously trained object detector as a .svm file (check train_object_detector for details)");
        throw std::runtime_error("You need to give previously trained object detector as a .svm file (check train_object_detector for details)");
        }

        // load a previqrously trained object detector and try it out on some data
        ifstream finNose(pathToNoseSVM, ios::binary);
        if (!finNose)
        {
            ROS_ERROR_STREAM("Can't find a trained nose detector file "+pathToNoseSVM+".svm.\n");
            throw std::runtime_error("Can't find a trained object detector file "+pathToNoseSVM+".svm.");
        }

        ifstream finSide(pathToSideSVM, ios::binary);
        if (!finSide)
        {
            ROS_ERROR_STREAM("Can't find a trained side detector file "+pathToSideSVM+".svm.\n");
            throw std::runtime_error("Can't find a trained object detector file "+pathToSideSVM+".svm.");
        }

        ifstream finBack(pathToBackSVM, ios::binary);
        if (!finBack)
        {
            ROS_ERROR_STREAM("Can't find a trained back detector file "+pathToBackSVM+".svm.\n");
            throw std::runtime_error("Can't find a trained object detector file "+pathToBackSVM+".svm.");
        }

        ifstream finFront(pathToFrontSVM, ios::binary);
        if (!finBack)
        {
            ROS_ERROR_STREAM("Can't find a trained front detector file "+pathToFrontSVM+".svm.\n");
            throw std::runtime_error("Can't find a trained object detector file "+pathToFrontSVM+".svm.");
        }
    
        deserialize(detector_nose, finNose);
        deserialize(detector_side, finSide);
        deserialize(detector_back, finBack);
        deserialize(detector_front, finFront);

        map2cameraListener.waitForTransform("/map", "/camera_link", ros::Time(0), ros::Duration(20.0));
        map2cameraListener.lookupTransform("/map", "/camera_link", ros::Time(0), map2cameraTransform);    

        //dlib INITIALIZED

        robotPosition.x = std::numeric_limits<double>::min();
        robotPosition.y = std::numeric_limits<double>::min();
        robotPosition.z = std::numeric_limits<double>::min();

        #ifdef DEBUG_MODE
        cv::namedWindow(OPENCV_WINDOW);
        cv::namedWindow(DEBUG_WINDOW);
        #endif
    }

    ObjectDetector::~ObjectDetector()
    {
        #ifdef DEBUG_MODE
        cv::destroyWindow(OPENCV_WINDOW);
        cv::destroyWindow(DEBUG_WINDOW);
        #endif
    }

    void ObjectDetector::detectPeople()
    {
        map2cameraListener.waitForTransform("/map", "/camera_link", ros::Time(0), ros::Duration(5.0));
        map2cameraListener.lookupTransform("/map", "/camera_link", ros::Time(0), map2cameraTransform);    

        visualization_msgs::MarkerArray markers;

        visualization_msgs::Marker marker;
        marker.header.frame_id = "map";
        marker.header.stamp = ros::Time();
        marker.ns = "face_feature";
        marker.type = visualization_msgs::Marker::CUBE;
        marker.action = visualization_msgs::Marker::MODIFY;
        marker.pose.orientation.x = 0.0;
        marker.pose.orientation.y = 0.0;
        marker.pose.orientation.z = 0.0;
        marker.pose.orientation.w = 1.0;
        marker.scale.x = 0.1;
        marker.scale.y = 0.1;
        marker.scale.z = 0.1;
        marker.color.a = 1.0; // Don't forget to set the alpha!
        marker.lifetime = ros::Duration(1.1);

        //
        //To get the 3D position use: point.y=(y - centerY) / depthFocalLength; point.x=(x - centerX) / depthFocalLength; point.z=depthvalue_at(y,x);
        //
        
        if(cv_depth_ptr == nullptr || cv_ptr == nullptr || robotPosition.x == std::numeric_limits<double>::min())
        return; 

        array2d<unsigned char> image;

        std::lock_guard<std::mutex> lock(mux);

        try
        {
        assign_image(image, cv_image<unsigned char>(cv_ptr->image));
        for (unsigned long i = 0; i < upsample_amount; ++i)
        {
            pyramid_up(image);
        }

        // Run the detector on images[i] 
        rects_nose = detector_nose(image);
        //cout << "Number of nose detections: " << rects_nose.size() << endl;
        for(int i = 0; i < rects_nose.size(); i++)
        {
            //get points positioned in scaled window
            double x = dlib::center(rects_nose[i]).x();
            double y = dlib::center(rects_nose[i]).y();

            //size of current, scaled window
            cv::Size size = cv_ptr->image.size();

            //convert coords to unscaled, initial window
            x = initialSize.width/2 + (x - initialSize.width/2)/2;
            y = initialSize.height/2 + (y - initialSize.height/2)/2;

            tf::Vector3 pointCamera(double((x-double(initialSize.width/2))/focalLength), double((y-double(initialSize.height/2))/focalLength), cv_depth_ptr->image.at<float>(y,x));
            tf::Vector3 pointTransformed = map2cameraTransform * pointCamera;
            points_nose.push_back(pointTransformed);

            //cout << "x: " << pointTransformed.x() << " y: " << pointTransformed.y() << " z: " << pointTransformed.z() << endl;

            marker.id = i+1;
            marker.pose.position.x = pointTransformed.x();
            marker.pose.position.y = pointTransformed.y();
            marker.pose.position.z = pointTransformed.z();
            marker.color.r = 0.0;
            marker.color.g = 1.0;
            marker.color.b = 0.0;

            markers.markers.push_back(marker);

            #ifdef DEBUG_MODE
            cv::rectangle(debug_cv_ptr->image, cv::Point(x-5, y-5), cv::Point(x+5,y+5),cv::Scalar(128,128,128), 2);
            #endif
        }

        rects_side = detector_side(image);
        //cout << "Number of side detections: "<< rects_side.size() << endl;
        for(int i = 0; i < rects_side.size(); i++)
        {
            //get points positioned in scaled window
            double x = dlib::center(rects_side[i]).x();
            double y = dlib::center(rects_side[i]).y();

            //size of current, scaled window
            cv::Size size = cv_ptr->image.size();

            //convert coords to unscaled, initial window
            x = initialSize.width/2 + (x - initialSize.width/2)/2;
            y = initialSize.height/2 + (y - initialSize.height/2)/2;

            tf::Vector3 pointCamera(double((x-double(initialSize.width/2))/focalLength), double((y-double(initialSize.height/2))/focalLength), cv_depth_ptr->image.at<float>(y,x));
            tf::Vector3 pointTransformed = map2cameraTransform * pointCamera;
            points_side.push_back(pointTransformed);

            //cout << "x: " << pointTransformed.x() << " y: " << pointTransformed.y() << " z: " << pointTransformed.z() << endl;

            marker.id = (i+1)*100;
            marker.pose.position.x = pointTransformed.x();
            marker.pose.position.y = pointTransformed.y();
            marker.pose.position.z = pointTransformed.z();
            marker.color.r = 1.0;
            marker.color.g = 1.0;
            marker.color.b = 0.0;

            markers.markers.push_back(marker);

            #ifdef DEBUG_MODE
            cv::rectangle(debug_cv_ptr->image, cv::Point(x-5, y-5), cv::Point(x+5,y+5),cv::Scalar(128,128,128), 2);
            #endif
        }

        rects_back = detector_back(image);
        //cout << "Number of back detections: "<< rects_back.size() << endl;
        for(int i = 0; i < rects_back.size(); i++)
        {
            //get points positioned in scaled window
            double x = dlib::center(rects_back[i]).x();
            double y = dlib::center(rects_back[i]).y();

            //size of current, scaled window
            cv::Size size = cv_ptr->image.size();

            //convert coords to unscaled, initial window
            x = initialSize.width/2 + (x - initialSize.width/2)/2;
            y = initialSize.height/2 + (y - initialSize.height/2)/2;

            tf::Vector3 pointCamera(double((x-double(initialSize.width/2))/focalLength), double((y-double(initialSize.height/2))/focalLength), cv_depth_ptr->image.at<float>(y,x));
            tf::Vector3 pointTransformed = map2cameraTransform * pointCamera;
            points_back.push_back(pointTransformed);

            //cout << "x: " << pointTransformed.x() << " y: " << pointTransformed.y() << " z: " << pointTransformed.z() << endl;

            marker.id = (i+1)*200;
            marker.pose.position.x = pointTransformed.x();
            marker.pose.position.y = pointTransformed.y();
            marker.pose.position.z = pointTransformed.z();
            marker.color.r = 0.1;
            marker.color.g = 0.5;
            marker.color.b = 0.5;

            markers.markers.push_back(marker);

            #ifdef DEBUG_MODE
            cv::rectangle(debug_cv_ptr->image, cv::Point(x-5, y-5), cv::Point(x+5,y+5),cv::Scalar(128,128,128), 2);
            #endif   
        }

        rects_front = detector_front(image);
        //cout << "Number of front detections: "<< rects_front.size() << endl;
        for(int i = 0; i < rects_front.size(); i++)
        {
            //get points positioned in scaled window
            double x = dlib::center(rects_front[i]).x();
            double y = dlib::center(rects_front[i]).y();

            //size of current, scaled window
            cv::Size size = cv_ptr->image.size();

            //convert coords to unscaled, initial window
            x = initialSize.width/2 + (x - initialSize.width/2)/2;
            y = initialSize.height/2 + (y - initialSize.height/2)/2;

            tf::Vector3 pointCamera(double((x-double(initialSize.width/2))/focalLength), double((y-double(initialSize.height/2))/focalLength), cv_depth_ptr->image.at<float>(y,x));
            tf::Vector3 pointTransformed = map2cameraTransform * pointCamera;
            points_front.push_back(pointTransformed);

            //cout << "x: " << pointTransformed.x() << " y: " << pointTransformed.y() << " z: " << pointTransformed.z() << endl;
            
            marker.id = (i+1)*300;
            marker.pose.position.x = pointTransformed.x();
            marker.pose.position.y = pointTransformed.y();
            marker.pose.position.z = pointTransformed.z();
            marker.color.r = 0.25;
            marker.color.g = 0.25;
            marker.color.b = 0.5;

            markers.markers.push_back(marker);

            #ifdef DEBUG_MODE
            cv::rectangle(debug_cv_ptr->image, cv::Point(x-5, y-5), cv::Point(x+5,y+5),cv::Scalar(128,128,128), 2);
            #endif
        }

        //if(rects_front.size() != 0 || rects_back.size() != 0 || rects_side.size() != 0 || rects_nose.size() != 0)
            //cout << endl;

        #ifdef DEBUG_MODE
        for(int i = 0; i < rects_nose.size(); i++)
        {
            char t[10] = "NOSE";
            cv::rectangle(cv_ptr->image, cv::Point(static_cast<int>(dlib::center(rects_nose[i]).x()-50), static_cast<int>(dlib::center(rects_nose[i]).y()-35)), cv::Point(static_cast<int>(dlib::center(rects_nose[i]).x()+50), static_cast<int>(dlib::center(rects_nose[i]).y()+35)),cv::Scalar(128,128,128), 4, 8, 0);
            cv::putText(cv_ptr->image, t, cv::Point(static_cast<int>(dlib::center(rects_nose[i]).x()-40), static_cast<int>(dlib::center(rects_nose[i]).y()+10)), cv::FONT_HERSHEY_PLAIN, 2, cv::Scalar(128,128,128), 3);
        }

        for(int i = 0; i < rects_side.size(); i++)
        {
            char t[10] = "SIDE";
            cv::rectangle(cv_ptr->image, cv::Point(static_cast<int>(dlib::center(rects_side[i]).x()-50), static_cast<int>(dlib::center(rects_side[i]).y()-35)), cv::Point(static_cast<int>(dlib::center(rects_side[i]).x()+50), static_cast<int>(dlib::center(rects_side[i]).y()+35)),cv::Scalar(128,128,128), 4, 8, 0);
            cv::putText(cv_ptr->image, t, cv::Point(static_cast<int>(dlib::center(rects_side[i]).x()-35), static_cast<int>(dlib::center(rects_side[i]).y()+10)), cv::FONT_HERSHEY_PLAIN, 2, cv::Scalar(128,128,128), 3);
        }

        for(int i = 0; i < rects_back.size(); i++)
        {
            char t[10] = "BACK";
            cv::rectangle(cv_ptr->image, cv::Point(static_cast<int>(dlib::center(rects_back[i]).x()-50), static_cast<int>(dlib::center(rects_back[i]).y()-35)), cv::Point(static_cast<int>(dlib::center(rects_back[i]).x()+50), static_cast<int>(dlib::center(rects_back[i]).y()+35)),cv::Scalar(128,128,128), 4, 8, 0);
            cv::putText(cv_ptr->image, t, cv::Point(static_cast<int>(dlib::center(rects_back[i]).x()-40), static_cast<int>(dlib::center(rects_back[i]).y()+10)), cv::FONT_HERSHEY_PLAIN, 2, cv::Scalar(128,128,128), 3);
        }

        for(int i = 0; i < rects_front.size(); i++)
        {
            char t[10] = "FRONT";
            cv::rectangle(cv_ptr->image, cv::Point(static_cast<int>(dlib::center(rects_front[i]).x()-60), static_cast<int>(dlib::center(rects_front[i]).y()-35)), cv::Point(static_cast<int>(dlib::center(rects_front[i]).x()+60), static_cast<int>(dlib::center(rects_front[i]).y()+35)),cv::Scalar(128,128,128), 4, 8, 0);
            cv::putText(cv_ptr->image, t, cv::Point(static_cast<int>(dlib::center(rects_front[i]).x()-40), static_cast<int>(dlib::center(rects_front[i]).y()+10)), cv::FONT_HERSHEY_PLAIN, 2, cv::Scalar(128,128,128), 3);
        }

        if(debug_cv_ptr != nullptr)
        imshow(DEBUG_WINDOW, debug_cv_ptr->image);
        imshow(OPENCV_WINDOW, cv_ptr->image);
        cv::waitKey(3);
        #endif

        image_pub_.publish(cv_ptr->toImageMsg());
        vis_pub.publish(markers);
        markers.markers.clear();
        }
        catch (exception& e)
        {
            cout << "\nexception thrown!" << endl;
            cout << e.what() << endl;
            return;
        }
    }

    void ObjectDetector::calculatePeopleVectors()
    {
        //when no data about robot position - return
        if(robotPosition.x == std::numeric_limits<double>::min())
        return; 

        people_msgs::People people;
        if(seq > 65000)
        seq = 0;
        people.header.seq = seq++;
        people.header.stamp = ros::Time::now();
        people.header.frame_id = "map";

        int personNumber = 0;

        //when no feature found
        while(points_front.size() != 0 || points_nose.size() != 0 || points_side.size() != 0 || points_back.size() != 0)
        {
            //take point from longest vector
            int longestSize = 0;
            int longestVector = 0;
            /*
            0 - front
            1 - nose
            2 - side
            3 - back
            */        

            longestSize = points_front.size();

            if(points_nose.size() > longestSize)
            {
                longestSize = points_nose.size();
                longestVector = 1;
            }
            if(points_side.size() > longestSize)
            {
                longestSize = points_side.size();
                longestVector = 2;
            }
            if(points_back.size() > longestSize)
            {
                longestSize = points_back.size();
                longestVector = 3;
            }

        /*here I create "psedu structure" -> depends on which points will be available
            the output vector would be calculated differently
            Vector's directions:
            1. front only - vector from human to robot
            2. back only - vector from robot to human
            3. side and nose - vector from side to nose
            4. side and back - vector from back to side
            treated as cascade
            Other combinations are treated as invalid
        */

        //z axis (down-up) is neglegted 

        tf::Vector3* point_front = nullptr;
        tf::Vector3* point_nose = nullptr;
        tf::Vector3* point_side = nullptr;
        tf::Vector3* point_back = nullptr;
        

        switch(longestVector)
        {
            case 0:
            {
                point_front = new tf::Vector3(points_front.back().x(),points_front.back().y(),points_front.back().z());
                points_front.pop_back();

                for(int i = 0; i < points_nose.size(); i++)
                {
                    tf::Vector3 candidate(points_nose[i].x(),points_nose[i].y(),points_nose[i].z());

                    double diff = sqrt(pow(point_front->x() - candidate.x(), 2) + pow(point_front->z() - candidate.z(), 2));
                
                    if(diff < 0.25)
                    {
                    point_nose = new tf::Vector3(candidate.x(), candidate.y(), candidate.z());
                    points_nose.erase(points_nose.begin() + i);
                    break;
                    }
                }

                for(int i = 0; i < points_side.size(); i++)
                {
                    tf::Vector3 candidate(points_side[i].x(),points_side[i].y(),points_side[i].z());

                    double diff = sqrt(pow(point_front->x() - candidate.x(), 2) + pow(point_front->z() - candidate.z(), 2));
                
                    if(diff < 0.25)
                    {
                    point_side = new tf::Vector3(candidate.x(), candidate.y(), candidate.z());
                    points_side.erase(points_side.begin() + i);
                    break;
                    }
                }

                for(int i = 0; i < points_back.size(); i++)
                {
                    tf::Vector3 candidate(points_back[i].x(),points_back[i].y(),points_back[i].z());

                    double diff = sqrt(pow(point_front->x() - candidate.x(), 2) + pow(point_front->z() - candidate.z(), 2));
                
                    if(diff < 0.25)
                    {
                    point_back = new tf::Vector3(candidate.x(), candidate.y(), candidate.z());
                    points_back.erase(points_back.begin() + i);
                    break;
                    }
                }
            }
            break;

            //nose
            case 1:
            {
                point_nose = new tf::Vector3(points_nose.back().x(),points_nose.back().y(),points_nose.back().z());
                points_nose.pop_back();

                for(int i = 0; i < points_front.size(); i++)
                {
                    tf::Vector3 candidate(points_front[i].x(),points_front[i].y(),points_front[i].z());

                    double diff = sqrt(pow(point_nose->x() - candidate.x(), 2) + pow(point_nose->z() - candidate.z(), 2));
                
                    if(diff < 0.25)
                    {
                    point_front = new tf::Vector3(candidate.x(), candidate.y(), candidate.z());
                    points_front.erase(points_front.begin() + i);
                    break;
                    }
                }

                for(int i = 0; i < points_side.size(); i++)
                {
                    tf::Vector3 candidate(points_side[i].x(),points_side[i].y(),points_side[i].z());

                    double diff = sqrt(pow(point_nose->x() - candidate.x(), 2) + pow(point_nose->z() - candidate.z(), 2));
                
                    if(diff < 0.25)
                    {
                    point_side = new tf::Vector3(candidate.x(), candidate.y(), candidate.z());
                    points_side.erase(points_side.begin() + i);
                    break;
                    }
                }

                for(int i = 0; i < points_back.size(); i++)
                {
                    tf::Vector3 candidate(points_back[i].x(),points_back[i].y(),points_back[i].z());

                    double diff = sqrt(pow(point_nose->x() - candidate.x(), 2) + pow(point_nose->z() - candidate.z(), 2));
                
                    if(diff < 0.25)
                    {
                    point_back = new tf::Vector3(candidate.x(), candidate.y(), candidate.z());
                    points_back.erase(points_back.begin() + i);
                    break;
                    }
                }
            }
            break;

            case 2:
            {
                point_side = new tf::Vector3(points_side.back().x(),points_side.back().y(),points_side.back().z());
                points_side.pop_back();

                for(int i = 0; i < points_front.size(); i++)
                {
                    tf::Vector3 candidate(points_front[i].x(),points_front[i].y(),points_front[i].z());

                    double diff = sqrt(pow(point_side->x() - candidate.x(), 2) + pow(point_side->z() - candidate.z(), 2));
                
                    if(diff < 0.25)
                    {
                    point_front = new tf::Vector3(candidate.x(), candidate.y(), candidate.z());
                    points_front.erase(points_front.begin() + i);
                    break;
                    }
                }

                for(int i = 0; i < points_nose.size(); i++)
                {
                    tf::Vector3 candidate(points_nose[i].x(),points_nose[i].y(),points_nose[i].z());

                    double diff = sqrt(pow(point_side->x() - candidate.x(), 2) + pow(point_side->z() - candidate.z(), 2));
                
                    if(diff < 0.25)
                    {
                    point_nose = new tf::Vector3(candidate.x(), candidate.y(), candidate.z());
                    points_nose.erase(points_nose.begin() + i);
                    break;
                    }
                }

                for(int i = 0; i < points_back.size(); i++)
                {
                    tf::Vector3 candidate(points_back[i].x(),points_back[i].y(),points_back[i].z());

                    double diff = sqrt(pow(point_side->x() - candidate.x(), 2) + pow(point_side->z() - candidate.z(), 2));
                
                    if(diff < 0.25)
                    {
                    point_back = new tf::Vector3(candidate.x(), candidate.y(), candidate.z());
                    points_back.erase(points_back.begin() + i);
                    break;
                    }
                }
            }
            break;

            case 3:
            {
                point_back = new tf::Vector3(points_back.back().x(),points_back.back().y(),points_back.back().z());
                points_back.pop_back();

                for(int i = 0; i < points_front.size(); i++)
                {
                    tf::Vector3 candidate(points_front[i].x(),points_front[i].y(),points_front[i].z());

                    double diff = sqrt(pow(point_back->x() - candidate.x(), 2) + pow(point_back->z() - candidate.z(), 2));
                
                    if(diff < 0.25)
                    {
                    point_front = new tf::Vector3(candidate.x(), candidate.y(), candidate.z());
                    points_front.erase(points_front.begin() + i);
                    break;
                    }
                }

                for(int i = 0; i < points_nose.size(); i++)
                {
                    tf::Vector3 candidate(points_nose[i].x(),points_nose[i].y(),points_nose[i].z());

                    double diff = sqrt(pow(point_back->x() - candidate.x(), 2) + pow(point_back->z() - candidate.z(), 2));
                
                    if(diff < 0.25)
                    {
                    point_nose = new tf::Vector3(candidate.x(), candidate.y(), candidate.z());
                    points_nose.erase(points_nose.begin() + i);
                    break;
                    }
                }

                for(int i = 0; i < points_side.size(); i++)
                {
                    tf::Vector3 candidate(points_side[i].x(),points_side[i].y(),points_side[i].z());

                    double diff = sqrt(pow(point_back->x() - candidate.x(), 2) + pow(point_back->z() - candidate.z(), 2));
                
                    if(diff < 0.25)
                    {
                    point_side = new tf::Vector3(candidate.x(), candidate.y(), candidate.z());
                    points_side.erase(points_side.begin() + i);
                    break;
                    }
                }
            }
            break;
        }

        people_msgs::Person person;
        person.name = "human" + boost::lexical_cast<std::string>(personNumber);

        try
            {
                //"pseudo structure" created
                //let's calculate people pose 
                if(point_front != nullptr && point_nose == nullptr && point_side == nullptr)
                {
                    //cout << "x: " << point_front->x() << " y: " << point_front->y() << endl;

                    if(isnan(point_front->x()) || isnan(point_front->y()))
                        continue;

                    person.position.x = point_front->x();
                    person.position.y = point_front->y();
                    person.position.z = point_front->z();

                    tf::Vector3 humanOrientationVector(robotPosition.x - person.position.x, robotPosition.y - person.position.y, 0);
                    humanOrientationVector.normalize();

                    humanOrientationVector.setX(humanOrientationVector.x() * humanVectorValue);
                    humanOrientationVector.setY(humanOrientationVector.y() * humanVectorValue);

                    person.velocity.x = humanOrientationVector.x();
                    person.velocity.y = humanOrientationVector.y();
                    person.velocity.z = humanOrientationVector.z();

                    people.people.push_back(person);
                }
                //works badly
                /*else if(point_front != nullptr && point_nose != nullptr && point_side == nullptr)
                {
                    if(isnan(point_front->x()) || isnan(point_front->y()) || isnan(point_nose->x()) || isnan(point_nose->y()))
                        continue;

                    person.position.x = point_front->x();
                    person.position.y = point_front->y();
                    person.position.z = point_front->z();

                    tf::Vector3 humanOrientationVector(point_front->x() - point_nose->x() , point_front->y() - point_nose->y(), 0);
                    humanOrientationVector.normalize();

                    humanOrientationVector.setX(humanOrientationVector.x() * humanVectorValue);
                    humanOrientationVector.setY(humanOrientationVector.y() * humanVectorValue);

                    person.velocity.x = humanOrientationVector.x();
                    person.velocity.y = humanOrientationVector.y();
                    person.velocity.z = humanOrientationVector.z();

                    people.people.push_back(person);
                }*/
                else if(point_front != nullptr && point_side != nullptr)
                {
                    if(isnan(point_front->x()) || isnan(point_front->y()) || isnan(point_side->x()) || isnan(point_side->y()))
                        continue;

                    person.position.x = point_front->x();
                    person.position.y = point_front->y();
                    person.position.z = point_front->z();

                    //Pushed side point a little in directions along robot-human vector

                    tf::Vector3 robotVector(point_side->x() - robotPosition.x, point_side->y() - robotPosition.y, 0);
                    robotVector.normalize();
                
                    point_side->setX(point_side->x() + robotVector.x() * 0.04);
                    point_side->setY(point_side->y() + robotVector.y() * 0.04);

                    tf::Vector3 humanOrientationVector(point_front->x() - point_side->x() , point_front->y() - point_side->y(), 0);
                    humanOrientationVector.normalize();

                    humanOrientationVector.setX(humanOrientationVector.x() * humanVectorValue);
                    humanOrientationVector.setY(humanOrientationVector.y() * humanVectorValue);

                    person.velocity.x = humanOrientationVector.x();
                    person.velocity.y = humanOrientationVector.y();
                    person.velocity.z = humanOrientationVector.z();

                    people.people.push_back(person);
                }
                else if(point_back != nullptr && point_side == nullptr)
                {
                    if(isnan(point_back->x()) || isnan(point_back->y()))
                        continue;

                    person.position.x = point_back->x();
                    person.position.y = point_back->y();
                    person.position.z = point_back->z();

                    tf::Vector3 humanOrientationVector(person.position.x - robotPosition.x, person.position.y - robotPosition.y, 0);
                    humanOrientationVector.normalize();

                    humanOrientationVector.setX(humanOrientationVector.x() * humanVectorValue);
                    humanOrientationVector.setY(humanOrientationVector.y() * humanVectorValue);

                    person.velocity.x = humanOrientationVector.x();
                    person.velocity.y = humanOrientationVector.y();
                    person.velocity.z = humanOrientationVector.z();

                    people.people.push_back(person);
                }
                else if(point_side != nullptr && point_nose != nullptr)
                {
                    if(isnan(point_side->x()) || isnan(point_side->y()) || isnan(point_nose->x()) || isnan(point_nose->y()))
                        continue;

                    person.position.x = point_nose->x();
                    person.position.y = point_nose->y();
                    person.position.z = point_nose->z();

                    //Pushed side point a little in directions along robot-human vector

                    tf::Vector3 robotVector(point_side->x() - robotPosition.x, point_side->y() - robotPosition.y, 0);
                    robotVector.normalize();
                
                    point_side->setX(point_side->x() + robotVector.x() * 0.04);
                    point_side->setY(point_side->y() + robotVector.y() * 0.04);

                    tf::Vector3 humanOrientationVector(point_nose->x() - point_side->x(), point_nose->y() - point_side->y(), 0);
                    humanOrientationVector.normalize();

                    humanOrientationVector.setX(humanOrientationVector.x() * humanVectorValue);
                    humanOrientationVector.setY(humanOrientationVector.y() * humanVectorValue);

                    person.velocity.x = humanOrientationVector.x();
                    person.velocity.y = humanOrientationVector.y();
                    person.velocity.z = humanOrientationVector.z();

                    people.people.push_back(person);
                }
                else if(point_side != nullptr && point_back != nullptr)
                {
                    if(isnan(point_side->x()) || isnan(point_side->y()) || isnan(point_back->x()) || isnan(point_back->y()))
                        continue;

                    person.position.x = point_side->x();
                    person.position.y = point_side->y();
                    person.position.z = point_side->z();

                    //Pushed side point a little in directions along robot-human vector

                    tf::Vector3 robotVector(point_side->x() - robotPosition.x, point_side->y() - robotPosition.y, 0);
                    robotVector.normalize();
                
                    point_side->setX(point_side->x() + robotVector.x() * 0.055);
                    point_side->setY(point_side->y() + robotVector.y() * 0.055);

                    tf::Vector3 humanOrientationVector(point_side->x() - point_back->x(), point_side->y() - point_back->y(), 0);
                    humanOrientationVector.normalize();

                    humanOrientationVector.setX(humanOrientationVector.x() * humanVectorValue);
                    humanOrientationVector.setY(humanOrientationVector.y() * humanVectorValue);

                    person.velocity.x = humanOrientationVector.x();
                    person.velocity.y = humanOrientationVector.y();
                    person.velocity.z = humanOrientationVector.z();

                    people.people.push_back(person);
                }

                peoplePosePublisher.publish(people);
                ros::spinOnce();
                ros::Duration(0.01).sleep();

                //cleaning
                if(point_front != nullptr)
                    delete point_front;
                if(point_nose != nullptr)
                    delete point_nose;
                if(point_side != nullptr)
                    delete point_side;
                if(point_back != nullptr)
                    delete point_back;
                
            }
            catch(exception& e)
            {
                cout << "\nexception thrown!" << endl;
                cout << e.what() << endl;
                ROS_ERROR_STREAM(e.what());
            }
        }
    }

    /*
    void ObjectDetector::imageCb(const sensor_msgs::ImageConstPtr& msg)
    {
        std::lock_guard<std::mutex> lock(rgbmux);

        try
        {
            cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
            cvtColor(cv_ptr->image, cv_ptr->image, cv::COLOR_RGB2GRAY);
            initialSize = cv_ptr->image.size();
            resize(cv_ptr->image, cv_ptr->image, cv::Size(), zoom, zoom);
            cv::Size size = cv_ptr->image.size();
            cv::Rect roi = cv::Rect(size.width/(scale*2), size.height/(scale*2), size.width/scale, size.height/scale);
            cv_ptr->image = cv::Mat(cv_ptr->image, roi);

        }
        catch (cv_bridge::Exception& e)
        {
            ROS_ERROR("cv_bridge exception: %s", e.what());
            return;
        }
    }

    void ObjectDetector::depthCb(const sensor_msgs::ImageConstPtr& msg)
    {
        std::lock_guard<std::mutex> lock(depthmux);

        try
        {
            cv_depth_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::TYPE_32FC1);
            #ifdef DEBUG_MODE
            debug_cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::TYPE_32FC1);
            double min;
            double max;
            cv::minMaxIdx(debug_cv_ptr->image, &min, &max);
            float scale = 255/(max-min);
            debug_cv_ptr->image.convertTo(debug_cv_ptr->image, CV_8UC1, 255, 0);
            applyColorMap(debug_cv_ptr->image, debug_cv_ptr->image, cv::COLORMAP_AUTUMN);
            #endif
        }
        catch(cv_bridge::Exception& e)
        {
            ROS_ERROR("cv_bridge exception: %s", e.what());
            return;
        }
    }
    */

    void ObjectDetector::imagesCb(const sensor_msgs::ImageConstPtr& rgb_image, const sensor_msgs::ImageConstPtr& depth_image)
    {
        try
        {
            //rgb image callback
            cv_ptr = cv_bridge::toCvCopy(rgb_image, sensor_msgs::image_encodings::BGR8);
            cvtColor(cv_ptr->image, cv_ptr->image, cv::COLOR_RGB2GRAY);
            initialSize = cv_ptr->image.size();
            resize(cv_ptr->image, cv_ptr->image, cv::Size(), zoom, zoom);
            cv::Size size = cv_ptr->image.size();
            cv::Rect roi = cv::Rect(size.width/(scale*2), size.height/(scale*2), size.width/scale, size.height/scale);
            cv_ptr->image = cv::Mat(cv_ptr->image, roi);

            //depth image callback
            cv_depth_ptr = cv_bridge::toCvCopy(depth_image, sensor_msgs::image_encodings::TYPE_32FC1);
        #ifdef DEBUG_MODE
            debug_cv_ptr = cv_bridge::toCvCopy(depth_image, sensor_msgs::image_encodings::TYPE_32FC1);
            double min;
            double max;
            cv::minMaxIdx(debug_cv_ptr->image, &min, &max);
            float scale = 255/(max-min);
            debug_cv_ptr->image.convertTo(debug_cv_ptr->image, CV_8UC1, 255, 0);
            applyColorMap(debug_cv_ptr->image, debug_cv_ptr->image, cv::COLORMAP_AUTUMN);
        #endif
        }
        catch(cv_bridge::Exception& e)
        {
            ROS_ERROR("cv_bridge exception: %s", e.what());
            return;
        }
    }

    void ObjectDetector::robotCb(const geometry_msgs::PoseStampedConstPtr& msg)
    {
        std::lock_guard<std::mutex> lock(robotmux);

        robotPosition.x = msg->pose.position.x;
        robotPosition.y = msg->pose.position.y;
        robotPosition.z = msg->pose.position.z;
    }

// ----------------------------------------------------------------------------------------


int main(int argc, char** argv)
{  
    ros::init(argc, argv, "nose_detector");
    std::shared_ptr<ObjectDetector> detector;

    try{
        detector = make_shared<ObjectDetector>(argc, argv);
    }
    catch (exception& e)
    {
        cout << "\nexception thrown!" << endl;
        cout << e.what() << endl;
        ROS_ERROR_STREAM(e.what());
        return 1;
    }

    while(ros::ok())
    {
        try{
            ros::spinOnce();
            ros::spinOnce();

            ros::Duration(0.01).sleep();
            detector->detectPeople();
            detector->calculatePeopleVectors();

            ros::Duration(0.01).sleep();
        }
        catch (exception& e)
        {
            cout << "\nexception thrown!" << endl;
            cout << e.what() << endl;
            ROS_ERROR_STREAM(e.what());
            return 1;
        }
    }

    return 0;
}

// ----------------------------------------------------------------------------------------

