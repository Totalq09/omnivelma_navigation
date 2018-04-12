#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <ignition/math/Vector3.hh>

#include <ros/ros.h>
#include <ros/console.h>
#include <tf2_ros/transform_broadcaster.h>
#include <tf/transform_datatypes.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <geometry_msgs/Quaternion.h>
#include <std_msgs/Float64.h>
#include <nav_msgs/Odometry.h>
#include <boost/lexical_cast.hpp>
#include <tf/transform_listener.h>
#include <tf/transform_broadcaster.h>

#include <mutex>

namespace gazebo
{
  class Human : public ModelPlugin
  {
    public: Human()
            {
            }

    public: void Load(physics::ModelPtr _parent, sdf::ElementPtr _sdf)
            {
              this->model = _parent;

              this->updateConnection = event::Events::ConnectWorldUpdateBegin(std::bind(&Human::OnUpdate, this));
          
              		//inicjalizacja ROSa
              if (!ros::isInitialized())
              {
                int argc = 0;
                char **argv = nullptr;
                ros::init(argc, argv, "human_ros", ros::init_options::NoSigintHandler);
              }

              rosNode.reset(new ros::NodeHandle());

              velocitySubscriber = rosNode->subscribe<geometry_msgs::TwistStamped>("human/velocity", 1, std::bind(&Human::VelocityCallback, this, std::placeholders::_1));
            }

            void OnUpdate()
            {
              std::lock_guard<std::mutex> lock(mux);
            
              math::Pose pose = model -> GetWorldPose();

              geometry_msgs::TransformStamped transMsg;
              transMsg.header.stamp = ros::Time::now();
              transMsg.header.frame_id = "map";
              transMsg.child_frame_id = "human_link";
              transMsg.transform.translation.x = pose.pos.x;
              transMsg.transform.translation.y = pose.pos.y;
              transMsg.transform.translation.z = pose.pos.z;

              transMsg.transform.rotation.x = pose.rot.x;
              transMsg.transform.rotation.y = pose.rot.y;
              transMsg.transform.rotation.z = pose.rot.z;
              transMsg.transform.rotation.w = pose.rot.w;
              framePublisher.sendTransform(transMsg);

              //be sure that z linear speed and x and y angular speed = 0

              tf::Vector3 linearVel(twistMsg.twist.linear.x, 0.0, 0.0);
              linearVel = linearVel.rotate(tf::Vector3(0.0,0.0,1.0), pose.rot.GetYaw());
              tf::Vector3 angularVel(twistMsg.twist.angular.x, twistMsg.twist.angular.y,  twistMsg.twist.angular.z);

              this->model->SetLinearVel(ignition::math::Vector3d(linearVel.x(), linearVel.y(), linearVel.z()));
              this->model->SetAngularVel(ignition::math::Vector3d(angularVel.x(), angularVel.y(), angularVel.z()));
            }

            void VelocityCallback(const geometry_msgs::TwistStampedConstPtr & msg)
            {
              std::lock_guard<std::mutex> lock(mux);
              twistMsg = *msg;
            }

    private:
      physics::ModelPtr model;
      
      event::ConnectionPtr updateConnection;

      std::unique_ptr<ros::NodeHandle> rosNode;

      ros::Subscriber velocitySubscriber;
      
      tf2_ros::TransformBroadcaster framePublisher;

      tf::TransformListener human2mapListener;
      tf::StampedTransform human2mapTransform;

      geometry_msgs::TwistStamped twistMsg;

      std::mutex mux;
  };
GZ_REGISTER_MODEL_PLUGIN(Human)
}