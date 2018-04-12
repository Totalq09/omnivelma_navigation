#ifndef HUMAN_STRUCTURES_
#define HUMAN_STRUCTURES_

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

namespace human_layer
{
    int nextHumanId = 0;
    
    struct Vector2
    {
        double x;
        double y;

        Vector2(double x, double y)
        {
            this->x = x;
            this->y = y;
        }

        //IN RADS
        static double angleBetween(Vector2 v1, Vector2 v2)
        {
            return double(acos(cos((v1.x * v2.x + v1.y * v2.y) / (sqrt(v1.x * v1.x + v1.y * v1.y) * sqrt(v2.x * v2.x + v2.y * v2.y)))));
        }

        Vector2(){}

        Vector2(const Vector2 & v1)
        {
            x = v1.x;
            y = v1.y;
        }
    };

    struct Vector2Stamped : public Vector2
    {
        ros::Time lastSeen;
        int humanId;

        Vector2Stamped() : Vector2() 
        {
            humanId = nextHumanId++;
            if(nextHumanId >= 10000)
                nextHumanId = 0;
        }

        Vector2Stamped(const Vector2Stamped & v1)
        {
            x = v1.x;
            y = v1.y;
            lastSeen = v1.lastSeen;
            humanId = v1.humanId;
        }

        Vector2Stamped(double x, double y) : Vector2(x,y)
        {
            lastSeen = ros::Time::now();
            humanId = nextHumanId++;
            if(nextHumanId >= 10000)
                nextHumanId = 0;
        }

        Vector2Stamped(Vector2 v1) : Vector2(v1.x, v1.y)
        {
            lastSeen = ros::Time::now();
            humanId = nextHumanId++;
            if(nextHumanId >= 10000)
                nextHumanId = 0;
        }

        void updateLastSeen()
        {
            lastSeen = ros::Time::now();
        }

        void updateLastSeen(ros::Time t)
        {
            lastSeen = t;
        }
    };

    struct HumanFacingArea
    {
        //It's a little strange thing here
        //I have vector of faces - faces
        //I need to remember the Facing Area for all point (faces)
        //this structure do this
        //humanIds must be the same here and there!

        int humanId;
        //2d vector from face toward robot, z data not used
        Vector2 facing;
        Vector2 personPos;

        std::vector<Vector2> points;

        HumanFacingArea() {};
        HumanFacingArea(int id, Vector2 pos, Vector2 facing = Vector2(std::numeric_limits<double>::min(), std::numeric_limits<double>::min()))
        {
            humanId = id;
            this->personPos = pos;
            this->facing = facing;
        }

        HumanFacingArea(const HumanFacingArea & h1)
        {
            humanId = h1.humanId;
            personPos = h1.personPos;
            facing = h1.facing;
            points = h1.points;
        }
    };
}

#endif