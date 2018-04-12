#include <omnivelma_navigation/kinect_follower.h>

void Follower::initialize()
{
    //ROS_WARN_STREAM("Enter follower initialize");

    kinectTopic = "people_positions_kinect";
    laserTopic = "people_positions_laser";
    kinectRotationTopic = "omnivelma/kinect_rotation";
    robotVelocityTopic = "omnivelma/twist";
    laserEnabled = true;
    pointLifetime = 1.1;
    robotVelocityEpsilon = 0.1;

    try{
        map2cameraListener.waitForTransform("/map", "/camera_link_reoriented", ros::Time(0), ros::Duration(20.0));
        map2cameraListener.lookupTransform("/map", "/camera_link_reoriented",
                        ros::Time(0), map2cameraTransform);                
    }
    catch (tf::TransformException &ex) 
    {
        ROS_ERROR("%s",ex.what());
        ros::Duration(1.0).sleep();
        return;
    }

    peopleKinectSubscriber = nh.subscribe(kinectTopic, 10, &Follower::peopleKinectCallback, this);
    peopleLaserSubscriber = nh.subscribe(laserTopic, 10, &Follower::peopleLaserCallback, this);
    robotVelocitySubscriber = nh.subscribe(robotVelocityTopic, 10, &Follower::robotVelocityCallback, this);

    kinectRotationPublisher = nh.advertise<std_msgs::Float64>(kinectRotationTopic, 10);

    robotVelocityVector = nullptr;
}

void Follower::robotVelocityCallback(const geometry_msgs::TwistStampedConstPtr & input)
{
    if(robotVelocityVector == nullptr)
        robotVelocityVector = new tf::Vector3();

    robotVelocityVector->setX(input->twist.linear.x);
    robotVelocityVector->setY(input->twist.linear.y);
    robotVelocityVector->setZ(input->twist.linear.z);
}

void Follower::peopleKinectCallback(const people_msgs::PeopleConstPtr & input)
{
    std::lock_guard<std::mutex> lock(mux);

    if(input->people.size() <= 0)
        return;
    
    try{
            map2cameraListener.waitForTransform("/map", "/camera_link_reoriented", ros::Time(0), ros::Duration(20.0));
            map2cameraListener.lookupTransform("/map", "/camera_link_reoriented",
                            ros::Time(0), map2cameraTransform);                
        }
    catch (tf::TransformException &ex) 
    {
        ROS_ERROR("%s",ex.what());
        ros::Duration(1.0).sleep();
        return;
    }

    geometry_msgs::Point newPoint;
    newPoint.z = std::numeric_limits<float>::max();

    //I use z for calculated distance

    for(std::vector<people_msgs::Person>::const_iterator iter = input->people.begin(); iter != input->people.end(); iter++)
    {
        double dis = sqrt(pow(iter->position.x - map2cameraTransform.getOrigin().getX(), 2) + pow(iter->position.y - map2cameraTransform.getOrigin().getY(), 2));
        if(dis < newPoint.z)
        {
            newPoint.x = iter->position.x;
            newPoint.y = iter->position.y;
            newPoint.z = dis;
        }
    }

    followedPoint = newPoint;
    followedPointLastSeen = ros::Time::now();
    isFollowedKinect = true;
    isFollowedLaser = false;

    //ROS_WARN_STREAM("FOLLOWING: " + boost::lexical_cast<std::string>(followedPoint.x) + " " + boost::lexical_cast<std::string>(followedPoint.y));
}

void Follower::peopleLaserCallback(const people_msgs::PeopleConstPtr & input)
{
    std::lock_guard<std::mutex> lock(mux);

    if(input->people.size() <= 0)
        return;
    
    if(isFollowedKinect)
        return;
    
    try{
            map2omnivelmaListener.waitForTransform("/map", "omnivelma", ros::Time(0), ros::Duration(20.0));
            map2omnivelmaListener.lookupTransform("/map", "omnivelma",
                            ros::Time(0), map2omnivelmaTransform);                
        }
    catch (tf::TransformException &ex) 
    {
        ROS_ERROR("%s",ex.what());
        ros::Duration(1.0).sleep();
        return;
    }

    geometry_msgs::Point newPoint;
    newPoint.z = std::numeric_limits<float>::max();

    //I use z for calculated distance

    for(std::vector<people_msgs::Person>::const_iterator iter = input->people.begin(); iter != input->people.end(); iter++)
    {
        double dis = sqrt(pow(iter->position.x - map2omnivelmaTransform.getOrigin().getX(), 2) + pow(iter->position.y - map2omnivelmaTransform.getOrigin().getY(), 2));
        if(dis < newPoint.z)
        {
            newPoint.x = iter->position.x;
            newPoint.y = iter->position.y;
            newPoint.z = dis;
        }
    }

    followedPoint = newPoint;
    followedPointLastSeen = ros::Time::now();
    isFollowedLaser = true;

    //ROS_WARN_STREAM("FOLLOWING LASER: " + boost::lexical_cast<std::string>(followedPoint.x) + " " + boost::lexical_cast<std::string>(followedPoint.y));
}

void Follower::setKinectRotation()
{
    while(ros::ok())
    {
        ros::Duration(0.05).sleep();
        {
            std::lock_guard<std::mutex> lock(mux);

            if((ros::Time::now() - followedPointLastSeen).toSec() > pointLifetime)
            {
                isFollowedKinect = isFollowedLaser = false;

                if(robotVelocityVector == nullptr)
                    continue;
            }

            try
            {
                map2cameraListener.waitForTransform("/map", "/camera_link_reoriented", ros::Time(0), ros::Duration(20.0));
                map2cameraListener.lookupTransform("/map", "/camera_link_reoriented",
                                ros::Time(0), map2cameraTransform);                
            }
            catch (tf::TransformException &ex) 
            {
                ROS_ERROR("%s",ex.what());
                ros::Duration(1.0).sleep();
                return;
            }

            if(isFollowedKinect || isFollowedLaser)
            {
                tf::Vector3 camera2human;

                if(sqrt(followedPoint.x * followedPoint.x + followedPoint.y * followedPoint.y) < 0.2)
                    continue;

                camera2human.setX(followedPoint.x - map2cameraTransform.getOrigin().getX());
                camera2human.setY(followedPoint.y - map2cameraTransform.getOrigin().getY());
                camera2human.setZ(0.0);

                camera2human.normalize();

                tf::Vector3 x_axis(1.0,0.0,0.0);

                float dot = x_axis.dot(camera2human);
                float det = x_axis.getX() * camera2human.getY() - x_axis.getY() * camera2human.getX();

                float angleBetween = atan2(det, dot);

                if(sqrt(angleBetween*angleBetween) < 0.025)
                    continue;

                std_msgs::Float64 msg;
                msg.data = angleBetween;

                kinectRotationPublisher.publish(msg);
            }
            else
            {  
                if(sqrt(pow(robotVelocityVector->getX(),2) + pow(robotVelocityVector->getY(),2)) < robotVelocityEpsilon)
                    continue;

                tf::Vector3 camera2Vel;

                camera2Vel.setX(robotVelocityVector->getX());
                camera2Vel.setY(robotVelocityVector->getY());
                camera2Vel.setZ(0.0);

                camera2Vel.normalize();

                tf::Vector3 x_axis(1.0,0.0,0.0);

                float dot = x_axis.dot(camera2Vel);
                float det = x_axis.getX() * camera2Vel.getY() - x_axis.getY() * camera2Vel.getX();

                float angleBetween = atan2(det, dot);

                if(sqrt(angleBetween*angleBetween) < 0.025)
                    continue;

                std_msgs::Float64 msg;
                msg.data = angleBetween;

                kinectRotationPublisher.publish(msg);
            }   
        }
    }
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "laser_tf_publisher");

    Follower follower;

    follower.initialize();

    std::thread t(&Follower::setKinectRotation, &follower);
    t.detach();

    ros::spin();
    return 0;
}

