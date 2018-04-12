#ifndef HUMAN_LAYER_H_
#define HUMAN_LAYER_H_

#include <string>
#include <math.h>
#include <thread>
#include <mutex>
#include <vector>
#include <limits> 
#include <math.h>

#include <ros/ros.h>
#include <sensor_msgs/PointCloud.h>
#include <tf/transform_listener.h>

#include <costmap_2d/layer.h>
#include <costmap_2d/layered_costmap.h>
#include <costmap_2d/GenericPluginConfig.h>
#include <dynamic_reconfigure/server.h>
#include <human_obstacle/human_layerConfig.h>
#include <human_obstacle_msgs/people_positions.h>
#include <people_msgs/People.h>
#include <human_obstacle/human_obstacle_structures.h>

const char humanCost = 254;

namespace human_layer
{
    class HumanLayer : public costmap_2d::Layer, public costmap_2d::Costmap2D
    {
    public:
        HumanLayer();

        virtual void onInitialize();
        virtual void updateBounds(double robot_x, double robot_y, double robot_yaw, double * min_x, double * min_y, double * max_x, double* max_y);

        virtual void updateCosts(costmap_2d::Costmap2D & master_grid, int min_i, int min_j, int max_i, int max_j);

        bool isDiscretized()
        {
            return true;
        }

        virtual void matchSize();
    private:
        void reconfigureCB(human_obstacle::human_layerConfig & config, uint32_t level);
        void peopleCloudUpdate (const sensor_msgs::PointCloudConstPtr& input);
        void setHumanCost(int, double, double, double * min_x, double * min_y, double * max_x, double* max_y, double robot_x = 0.0, double robot_y = 0.0);
        void deleteHumanCost(int, double mark_x, double mark_y, double * min_x, double * min_y, double * max_x, double* max_y);
        void setCalculatedCost(double mark_x, double mark_y, double * min_x, double * min_y, double * max_x, double* max_y, int cost);

        void publishPeoplePositions(people_msgs::People poses);

        ros::NodeHandle* nh;

        ros::Publisher peoplePositionsPublisher;
        ros::Publisher peoplePositionsPublishertToSocialLayer;
        
        tf::TransformListener map2cameraListener;
        tf::StampedTransform map2cameraTransform;

        ros::Subscriber peopleSubscriber;
        std::vector<Vector2Stamped> foundPeople;
        std::vector<HumanFacingArea> facingAreas;
        std::mutex mutex;

        double pointMinDiff;// = 0.25;
        double pointLifetime;// = 0.5;

        double innerRadius;// = 0.5;
        
        double distanceStep;// = 0.04;
        double radiusInnerStep;// = 0.02;

        double outerRadius;// = 1.75;
        double outerRoundnessA;// = 10.0;
        //MUST BE ODD
        int outerRoundnessB;// = 1;
        //IN RADS
        double outerMaxAngle;// = M_PI / 4;
        double radiusOuterStep;// = 0.01;

        double costDeminishSpeed;// = 3.5;

        bool enablePublishingPeoplePositions;
        std::string peoplePositionsTopic;

        Costmap2D* master;
        dynamic_reconfigure::Server<human_obstacle::human_layerConfig> * dsrv_;

    };
}

#endif