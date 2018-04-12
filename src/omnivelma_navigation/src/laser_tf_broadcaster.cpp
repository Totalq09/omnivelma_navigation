#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <tf/transform_datatypes.h>

int main(int argc, char** argv){
  ros::init(argc, argv, "laser_tf_publisher");
  ros::NodeHandle n;

  ros::Rate r(100);

  tf::TransformBroadcaster broadcaster;

      tf::Quaternion rot = tf::createQuaternionFromRPY(0.0,0.0,-3.141592);
      tf::Quaternion rot2 = tf::createQuaternionFromRPY(0.0,0.0,0.0);

  while(n.ok()){

	 broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(rot, tf::Vector3(0.0, -0.3, 0.176)),
        ros::Time::now(),"omnivelma", "monokl_r_heart"));

	broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(rot2, tf::Vector3(0.0, 0.3, 0.176)),
        ros::Time::now(),"omnivelma", "monokl_l_heart"));

	 broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(tf::Quaternion(0, 0, 0, 1), tf::Vector3(0.0, 0.0, 0.2)),
        ros::Time::now(),"omnivelma", "base_laser"));

	r.sleep();
  }
}
