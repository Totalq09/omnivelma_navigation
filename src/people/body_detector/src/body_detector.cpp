#include <iostream>
#include <string>

#include <ros/ros.h>
#include <opencv2/opencv.hpp>
#include <opencv2/core.hpp>
#include <opencv2/highgui.hpp>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/image_encodings.h>

using namespace cv;
using namespace std;

static const std::string OPENCV_WINDOW = "Image window";

//http://wiki.ros.org/cv_bridge/Tutorials/UsingCvBridgeToConvertBetweenROSImagesAndOpenCVImages
class ImageConverter
{
    ros::NodeHandle nh_;
    image_transport::ImageTransport it_;
    image_transport::Subscriber image_sub_;
    image_transport::Publisher image_pub_;

public:
    ImageConverter() : it_(nh_)
    {
        image_sub_ = it_.subscribe("/camera/rgb/image_raw", 1, &ImageConverter::imageCb, this);
        image_pub_ = it_.advertise("/image_converter/output_video", 1);
    }    

    ~ImageConverter()
    {
        cv::destroyWindow(OPENCV_WINDOW);
    }

    void imageCb(const sensor_msgs::ImageConstPtr & msg)
    {
        cv_bridge::CvImagePtr cv_ptr;

        try
        {
            cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
        }
        catch(cv_bridge::Exception & e)
        {
            ROS_ERROR("cv_bridge exception: %s", e.what());
            return;
        }

        tryToFindFace(cv_ptr);

        image_pub_.publish(cv_ptr->toImageMsg());
    }

    void tryToFindFace(cv_bridge::CvImagePtr & cv_ptr)
    {
        Mat image;
        image = cv_ptr->image;

        if(!image.data)
        {
            cout << "No image - convertion may failed " << endl;
            return;
        }

        vector<Rect> found, found_filtered;

        CascadeClassifier casc = CascadeClassifier("/opt/ros/kinetic/share/OpenCV-3.3.1/haarcascades/haarcascade_upperbody.xml");
        //cascade_.detectMultiScale(cv_image_gray_, faces_vec,  1.2, 2, CV_HAAR_DO_CANNY_PRUNING, cv::Size(this_min_face_size, this_min_face_size));
        casc.detectMultiScale(image, found, 2.0, 1.6, 0, Size(30,30));

        /*
        HOGDescriptor hog;
        hog.setSVMDetector(HOGDescriptor::getDefaultPeopleDetector());
        */

        //hog.detectMultiScale(image, found, 0, Size(8,8), Size(32,32), 1.5, 2);
    
        size_t i, j;

        for( i = 0; i < found.size(); i++)
        {
            Rect r = found[i];
            for(j = 0; j < found.size(); j++)
            {
                if(j != i && (r & found[j]) == r)
                    break;
            }
            if(j == found.size())
                found_filtered.push_back(r);
        }

        for(i=0; i < found_filtered.size(); i++)
        {
            Rect r = found_filtered[i];
            r.x += cvRound(r.width*0.1);
            r.width = cvRound(r.width*0.8);
            r.height = cvRound(r.height*0.9);
	        rectangle(image, r.tl(), r.br(), cv::Scalar(0,255,0), 2);
        }
    }
};

int main(int argc, char* argv[])
{
    ros::init(argc, argv, "body_detector");

    ImageConverter ic;

    ros::spin();
    return 0;
    /* 
    string path = "/home/totalq/Pictures/human.png";

    if(argc == 2)
        path = string(argv[1]);

    Mat image;
    image = imread(path, CV_LOAD_IMAGE_COLOR);

    if(!image.data)
    {
        cout << "No image found in file " << path << endl;
        return -1;
    }

    HOGDescriptor hog;
    hog.setSVMDetector(HOGDescriptor::getDefaultPeopleDetector());
    
    namedWindow("Display", WINDOW_AUTOSIZE);

    //while(true)
    {
        vector<Rect> found, found_filtered;
        hog.detectMultiScale(image, found, 0, Size(8,8), Size(32,32), 1.05, 2);
    
        size_t i, j;

        for( i = 0; i < found.size(); i++)
        {
            Rect r = found[i];
            for(j = 0; j < found.size(); j++)
            {
                if(j != i && (r & found[j]) == r)
                    break;
            }
            if(j == found.size())
                found_filtered.push_back(r);
        }

        for(i=0; i < found_filtered.size(); i++)
        {
            Rect r = found_filtered[i];
            r.x += cvRound(r.width*0.1);
            r.width = cvRound(r.width*0.8);
            r.height = cvRound(r.height*0.9);
	        rectangle(image, r.tl(), r.br(), cv::Scalar(0,255,0), 2);
        }
        
    }

    imshow("Display", image);
    waitKey(0);
    return 0;*/
}