#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <tf/transform_datatypes.h>

int main(int argc, char** argv){
  ros::init(argc, argv, "camera_tf_publisher");
  ros::NodeHandle n;

  ros::Rate r(100);

  tf::TransformBroadcaster broadcaster;
  tf::Quaternion rot = tf::createQuaternionFromRPY(-1.570796,0.0,-1.570796);
  tf::Quaternion rot2 = tf::createQuaternionFromRPY(1.570796,2*1.570796,1.570796);

  while(n.ok()){

	/* broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(rot, tf::Vector3(0.25, 0.0, 1.5)),
        ros::Time::now(),"omnivelma", "camera_link")); */  
  broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(rot2, tf::Vector3(0.0, 0.0, 0.0)),
        ros::Time::now(),"camera_link_reoriented", "camera_link"));

	r.sleep();
  }
}
