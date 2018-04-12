#include <opencv2/opencv.hpp>

#include <iostream>
#include <iomanip>
#include <mutex>
#include <thread>

#include <boost/program_options.hpp>

#include "../tools/LinearMath/Matrix3x3.h"

#include "./head_pose_estimation.hpp"

#include <ros/ros.h>
#include <ros/console.h>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/image_encodings.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui.hpp>

#define STR_EXPAND(tok) #tok
#define STR(tok) STR_EXPAND(tok)

using namespace std;
using namespace cv;
namespace po = boost::program_options;

inline double todeg(double rad) {
    return rad * 180 / M_PI;
}

std::mutex mux;

class ImageConverter
{
private:
    cv_bridge::CvImagePtr cv_ptr;
    Mat *frame;
    ros::NodeHandle nh_;
    image_transport::ImageTransport it_;
    image_transport::Subscriber image_sub_;

public:
    ImageConverter(Mat *frame) : it_(nh_)
    {
        image_sub_ = it_.subscribe("/camera/rgb/image_raw", 1, &ImageConverter::imageCb, this);
        this->frame = frame;
    }

    ~ImageConverter()
    {
    }

    void imageCb(const sensor_msgs::ImageConstPtr & msg)
    {
        {
            std::lock_guard<std::mutex> lock(mux);

            try
            {
                cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);  
                *frame = cv_ptr->image;
                resize(*frame, *frame,Size(), 1.4, 1.4);
                Rect roi = Rect(frame->size().width/2 - 650/2, frame->size().height/2 - 150/2 , 650, 150);
                *frame = Mat(*frame, roi);
            }

            catch(cv_bridge::Exception & e)
            {
                ROS_ERROR("cv_bridge exception: %s", e.what());
                return;
            }
        }
    }
};


int main(int argc, char **argv)
{
    ros::init(argc, argv, "estimate_head_direction");

    Mat frame;
    ImageConverter converter(&frame);
    bool show_frame = false;

    po::positional_options_description p;
    p.add("image", 1);

    po::options_description desc("Allowed options");
    desc.add_options()
            ("help,h", "produce help message")
            ("version,v", "shows version and exits")
            ("show,s", "display the image with gaze estimation")
            ("model", po::value<string>(), "dlib's trained face model")
            ("image", po::value<string>(), "image to process (png, jpg)")
            ;

    po::variables_map vm;
    po::store(po::command_line_parser(argc, argv)
                        .options(desc)
                        .positional(p)
                        .run(), vm);
    po::notify(vm);

    if (vm.count("help")) 
    {
        cout << argv[0] << " " <<  STR(GAZR_VERSION) << "\n\n" << desc << "\n";
        return 1;
    }

    if (vm.count("version")) 
    {
        cout << argv[0] << " " << STR(GAZR_VERSION) << "\n";
        return 0;
    }

    if (vm.count("show")) 
    {
        show_frame = true;
    }

    if (vm.count("model") == 0) 
    {
        cout << "You must specify the path to a trained dlib's face model\n"
             << "with the option --model." << endl;
        return 1;
    }

    auto estimator = HeadPoseEstimation(vm["model"].as<string>());

    ros::Time lastTime = ros::Time::now();

    ros::spinOnce();

    while(ros::ok()) 
    {
        {
            ros::spinOnce();

            mux.lock();

            if(frame.empty())
            {
                mux.unlock();
                ros::Duration(0.25).sleep();
                continue;
            }

            estimator.focalLength = 85.0 / 22.3 * frame.size().width;

            auto all_features = estimator.update(frame);

            auto poses = estimator.poses();

            int i = 0;
            cout << "{";

            for(auto pose : poses) {

                pose = pose.inv();

                double raw_yaw, raw_pitch, raw_roll;
                tf::Matrix3x3 mrot(
                        pose(0,0), pose(0,1), pose(0,2),
                        pose(1,0), pose(1,1), pose(1,2),
                        pose(2,0), pose(2,1), pose(2,2));
                mrot.getRPY(raw_roll, raw_pitch, raw_yaw);

                raw_roll = raw_roll - M_PI/2;
                raw_yaw = raw_yaw + M_PI/2;

                double yaw, pitch, roll;

                roll = raw_pitch;
                yaw = raw_yaw;
                pitch = -raw_roll;

                cout << "\"face_" << i << "\":";
                cout << setprecision(1) << fixed << "{\"yaw\":" << todeg(yaw) << ", \"pitch\":" << todeg(pitch) << ", \"roll\":" << todeg(roll) << "," << endl;
               // cout << setprecision(4) << fixed << "\"x\":" << pose(0,3) << ", \"y\":" << pose(1,3) << ", \"z\":" << pose(2,3) << "},";
                ros::Time t = ros::Time::now();
                cout << setprecision(2) << fixed << "Update time: " << (t - lastTime).toSec() << endl;
                lastTime = t;

                i++;
            }
            cout << "}\n" << flush;

            if (show_frame) {
                imshow("headpose", estimator.drawDetections(frame, all_features, poses));
                waitKey(1);
            }

            mux.unlock();
        }
      
        ros::Duration(0.1).sleep();
    }

}


