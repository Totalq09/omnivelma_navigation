
#include <iostream>
#include <fstream>
#include <mutex>
#include <thread>

#include <ros/ros.h>
#include <ros/console.h>
#include <image_transport/image_transport.h>
#include <sensor_msgs/image_encodings.h>
#include <sensor_msgs/PointCloud2.h>
#include <sensor_msgs/Image.h>
#include <cv_bridge/cv_bridge.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <tf/transform_listener.h>
#include <visualization_msgs/MarkerArray.h>
#include <geometry_msgs/PoseStamped.h>
#include <limits>
#include <people_msgs/People.h>

#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>
#include <image_transport/subscriber_filter.h>

#include <dlib/svm_threaded.h>
#include <dlib/string.h>
#include <dlib/gui_widgets.h>
#include <dlib/image_processing.h>
#include <dlib/data_io.h>
#include <dlib/cmd_line_parser.h>
#include <dlib/opencv/cv_image.h>

using namespace std;
using namespace dlib;

static const std::string OPENCV_WINDOW = "Image window";
static const std::string DEBUG_WINDOW = "Debug window";

//KINECT FOCAL LENGTH
double focalLength = 525;

class ObjectDetector
{
private:

  ros::NodeHandle nh_;
  image_transport::ImageTransport it_;
  image_transport::SubscriberFilter image_sub_;
  image_transport::SubscriberFilter depth_sub_;
  image_transport::Publisher image_pub_;

  typedef message_filters::sync_policies::ApproximateTime
  <sensor_msgs::Image, sensor_msgs::Image> MySyncPolicy;

  message_filters::Synchronizer<MySyncPolicy> sync;

  ros::Publisher vis_pub;
  ros::Subscriber robotPos;

  ros::Publisher peoplePosePublisher;

  cv_bridge::CvImagePtr cv_ptr = nullptr;
  cv_bridge::CvImagePtr debug_cv_ptr = nullptr;
  cv_bridge::CvImagePtr cv_depth_ptr = nullptr;

  double scale = 2.0;
  double zoom = 2.0;

  cv::Size initialSize;

  std::mutex mux;
  std::mutex robotmux;

  //dlib

  command_line_parser parser;

  unsigned long upsample_amount;
  typedef scan_fhog_pyramid<pyramid_down<8> > image_scanner_type; 

  object_detector<image_scanner_type> detector_nose;
  object_detector<image_scanner_type> detector_side;
  object_detector<image_scanner_type> detector_back;
  object_detector<image_scanner_type> detector_front;

  std::string pathToNoseSVM;
  std::string pathToSideSVM;
  std::string pathToBackSVM;
  std::string pathToFrontSVM;

  tf::TransformListener map2cameraListener;
  tf::StampedTransform map2cameraTransform;

  geometry_msgs::Point robotPosition;

  std::vector<rectangle> rects_nose;
  std::vector<rectangle> rects_side;
  std::vector<rectangle> rects_back;
  std::vector<rectangle> rects_front;

  std::vector<tf::Vector3> points_front;
  std::vector<tf::Vector3> points_nose;
  std::vector<tf::Vector3> points_side;
  std::vector<tf::Vector3> points_back;

  int seq = 0;
  double humanVectorValue = 1.35;

public:

  ObjectDetector(int argc, char** argv);
  ~ObjectDetector();

  void detectPeople();
  void calculatePeopleVectors();

protected:

  /*void imageCb(const sensor_msgs::ImageConstPtr& msg);
  void depthCb(const sensor_msgs::ImageConstPtr& msg);*/
  //synchronized rgb and depth image
  void imagesCb(const sensor_msgs::ImageConstPtr& rgb_image, const sensor_msgs::ImageConstPtr& depth_image);
  void robotCb(const geometry_msgs::PoseStampedConstPtr& msg);
};
