#ifndef __HEAD_POSE_ESTIMATION_PROFILE_
#define __HEAD_POSE_ESTIMATION_PROFILE_

#include <opencv2/core/core.hpp>
#include <dlib/opencv.h>
#include <dlib/image_processing.h>
#include <dlib/image_processing/frontal_face_detector.h>

#include <vector>
#include <array>
#include <string>

// Anthropometric for male adult
// Relative position of various facial feature relative to sellion
// Values taken from https://en.wikipedia.org/wiki/Human_head
// X points forward


const static cv::Point3f P3D_SELLION_PROFILE(0., 0.,0.);
//const static cv::Point3f P3D_RIGHT_EYE(-20., -65.5,-5.);
const static cv::Point3f P3D_LEFT_EYE_PROFILE(-20., 65.5,-5.);
const static cv::Point3f P3D_LEFT_EYEBROW_PROFILE(-15.0, 65.5, 20.0);
//const static cv::Point3f P3D_RIGHT_EAR(-100., -77.5,-6.);
//const static cv::Point3f P3D_LEFT_EAR(-100., 77.5,-6.);
const static cv::Point3f P3D_NOSE_PROFILE(21.0, 0., -48.0);
const static cv::Point3f P3D_STOMMION_PROFILE(10.0, 0., -75.0);
const static cv::Point3f P3D_MENTON_PROFILE(0., 0.,-133.0);

static const int MAX_FEATURES_TO_TRACK_PROFILE=31;

// Interesting facial features with their landmark index
enum FACIAL_FEATURE_PROFILE {
    LEFT_EYEBROW_PROFILE=1,
    LEFT_EYE_PROFILE=5,
    NOSE_PROFILE=11,
    MOUTH_UP_PROFILE=19,
    MOUTH_DOWN_PROFILE=25,
    //MOUTH_RIGHT=48,
    //MOUTH_LEFT=54,
    SELLION_PROFILE=19,
    //MOUTH_CENTER_TOP=62,
    //MOUTH_CENTER_BOTTOM=66,
    MENTON_PROFILE=26
};


typedef cv::Matx44d head_pose;

class HeadPoseEstimationProfile {

public:

    HeadPoseEstimationProfile(const std::string& face_detection_model = "shape_predictor_30_profile_face_landmarks.dat", float focalLength=455.);

    /** Returns the 2D position (in image coordinates) of the 68 facial features
     * detected by dlib (or an empty vector if no face is detected).
     */
    std::vector<std::vector<cv::Point>> update(cv::InputArray image);

    head_pose pose(size_t face_idx) const;

    std::vector<head_pose> poses() const;

    /** Returns an augmented image with the detected facial features and head pose drawn in.
     * 
     * Leave either detected_features or detected_poses empty to skip drawing the respective detections.
     */
    cv::Mat drawDetections(const cv::Mat& original_image, const std::vector<std::vector<cv::Point>>& detected_features, const std::vector<head_pose>& detected_poses);

    float focalLength;
    float opticalCenterX;
    float opticalCenterY;

private:

    dlib::cv_image<dlib::bgr_pixel> current_image;

    dlib::frontal_face_detector detector;
    dlib::shape_predictor pose_model;

    std::vector<dlib::rectangle> faces;

    std::vector<dlib::full_object_detection> shapes;


    void drawFeatures(const std::vector<std::vector<cv::Point>>& detected_features, cv::Mat& result) const;

    void drawPose(const head_pose& detected_pose, size_t face_idx, cv::Mat& result) const;

    /** Return the point corresponding to the dictionary marker.
    */
    cv::Point2f coordsOf(size_t face_idx, FACIAL_FEATURE_PROFILE feature) const;

    /** Returns true if the lines intersect (and set r to the intersection
     *  coordinates), false otherwise.
     */
    bool intersection(cv::Point2f o1, cv::Point2f p1,
                      cv::Point2f o2, cv::Point2f p2,
                      cv::Point2f &r) const;

};

#endif // __HEAD_POSE_ESTIMATION_PROFILE_
