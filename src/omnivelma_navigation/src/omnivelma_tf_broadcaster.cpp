#include <ros/ros.h>
#include <cmath>
#include <tf/transform_broadcaster.h>

int main(int argc, char** argv){
  ros::init(argc, argv, "omnivelma_tf_broadcaster");
  ros::NodeHandle n;

  ros::Rate r(100);

  tf::TransformBroadcaster broadcaster;
  tf::Quaternion rot = tf::createQuaternionFromRPY(0.0,0.0, 0.0);

  while(n.ok()){
	 broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(rot, tf::Vector3(0.0, 0, -0.1)),
        ros::Time::now(),"omnivelma", "base_footprint"));

   r.sleep();
  }
}
