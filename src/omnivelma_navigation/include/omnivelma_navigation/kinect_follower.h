#ifndef KINECT_FOLLOWER_
#define KINECT_FOLLOWER_

#include <iostream>
#include <string>
#include <ros/ros.h>
#include <thread>
#include <mutex>
#include <cmath>
#include <ros/console.h>
#include <exception>
#include <limits>

#include <boost/lexical_cast.hpp>

#include <tf/transform_listener.h>
#include <tf/transform_datatypes.h>

#include <geometry_msgs/Point.h>
#include <geometry_msgs/Twist.h>
#include <geometry_msgs/Quaternion.h>
#include <people_msgs/People.h>
#include <people_msgs/Person.h>
#include <std_msgs/Float64.h>

class Follower
{
public:
    void initialize();

    void peopleKinectCallback(const people_msgs::PeopleConstPtr & input);
    void peopleLaserCallback(const people_msgs::PeopleConstPtr & input);

    void robotVelocityCallback(const geometry_msgs::TwistStampedConstPtr & input);
    
    void setKinectRotation();

    ~Follower()
    {
        if(robotVelocityVector != nullptr)
            delete robotVelocityVector;
    }
    
private:

    ros::NodeHandle nh;

    ros::Subscriber peopleKinectSubscriber;
    ros::Subscriber peopleLaserSubscriber;
    ros::Subscriber robotVelocitySubscriber;

    ros::Publisher kinectRotationPublisher;

    std::string kinectTopic;
    std::string laserTopic;
    std::string kinectRotationTopic;
    std::string robotVelocityTopic;
    bool laserEnabled;

    bool isFollowedLaser = false;
    bool isFollowedKinect = false;
    bool inverseSpeed = false;
    geometry_msgs::Point followedPoint;
    ros::Time followedPointLastSeen;
    double pointLifetime;
    double robotVelocityEpsilon;

    tf::TransformListener map2cameraListener;
    tf::StampedTransform map2cameraTransform;

    tf::TransformListener map2omnivelmaListener;
    tf::StampedTransform map2omnivelmaTransform;

    tf::Vector3 *robotVelocityVector;

    

    std::mutex mux;
};

#endif