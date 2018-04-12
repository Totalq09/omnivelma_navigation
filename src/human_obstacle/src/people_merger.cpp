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
#include <people_msgs/PersonStamped.h>
#include <human_obstacle/human_obstacle_structures.h>
#include <geometry_msgs/PoseStamped.h>

std::mutex mux;

people_msgs::People people_list_;
people_msgs::People people_list_original_;
people_msgs::People people_list_kinect_;

double maxLifeTime = 0.1;
ros::Time lastUpdated;
bool isCleared = false;

namespace human_layer
{
    class HumanObserver
    {
        ros::NodeHandle* nh;

        std::mutex m;

        ros::Publisher peoplePositionsPublisher;
        ros::Publisher peoplePositionsInnerPublisher;
        
        ros::Subscriber peopleSubscriber;
        std::vector<people_msgs::PersonStamped> foundPeople;

        double pointMinDiff = 0.2;
        double pointLifetime = 0.55;

        int seq = 0;
        int id = 0;

    public:
        HumanObserver() {};

        void initialize()
        {
            nh = new ros::NodeHandle("~/");

            std::string source("human_layer");
            ros::NodeHandle source_node(*nh, source);

            //get data from detector
            peopleSubscriber = nh->subscribe("/people_detected", 2, &HumanObserver::peopleUpdate, this);

            //sent to kinect rotator - kinect_follower module
            peoplePositionsPublisher = nh->advertise<people_msgs::People>("/people_positions_kinect", 2);

            //check in main
            peoplePositionsInnerPublisher = nh->advertise<people_msgs::People>("/people_kinect", 2);
        }

        void update()
        {
            std::lock_guard<std::mutex> lock(m);

            if(foundPeople.size() == 0)
                return;

            int id;

            people_msgs::People poses;
            poses.header.stamp = ros::Time::now();
            poses.header.frame_id = "map";

            for(std::vector<people_msgs::PersonStamped>::iterator iter = foundPeople.begin(); iter != foundPeople.end();)
            {
                id =  iter->header.seq;

                if((ros::Time::now() - iter->header.stamp).toSec() > pointLifetime)
                {
                    // I <3 c++
                    iter = foundPeople.erase(iter);

                    continue;
                }  

                people_msgs::Person person;
                person = iter->person;
                person.name = "human" + boost::lexical_cast<std::string>(id);

                poses.people.push_back(person);

                iter++;
            }

            publishPeoplePositions(poses);           
        }

    protected:
        void publishPeoplePositions(people_msgs::People poses)
        {
            peoplePositionsInnerPublisher.publish(poses);
            peoplePositionsPublisher.publish(poses);
        }

        void peopleUpdate (const people_msgs::PeopleConstPtr& input)
        {
            std::lock_guard<std::mutex> lock(m);
            //for now simple one face
            int peopleQuantity = 0;

            try
            {
                peopleQuantity = input->people.size();
            }
            catch(...) 
            { 

            }

            //nie wiem czemu ale w ostatnim elemenie jest jakis smiec, co nie jest zgodne z rostopic echo
            for(int i = 0; i < peopleQuantity; i++)
            {
                people_msgs::PersonStamped newPerson;
                newPerson.person = input->people[i];
                newPerson.header.stamp = ros::Time::now();

                if(foundPeople.size() == 0)
                {
                    newPerson.header.seq = id++;
                    foundPeople.push_back(newPerson);      
                }
                else
                {
                    //check if point exists
                    bool exists = false;
                    for(std::vector<people_msgs::PersonStamped>::iterator iter = foundPeople.begin(); iter != foundPeople.end(); iter++)
                    {
                        if(sqrt(pow((iter->person.position.x - newPerson.person.position.x),2) + pow((iter->person.position.y - newPerson.person.position.y), 2)) < pointMinDiff)
                        {
                            iter->header.stamp = ros::Time::now();
                            exists = true;
                            break;
                        }  
                    }

                    //point not exists, simply add
                    if(exists == false)
                    {
                        newPerson.header.seq = id++;
                        foundPeople.push_back(newPerson);
                    }
                }

                if(id > 65000)
                    id = 0;
            }   
        }
    };
}


void concateLists()
{
    people_list_ = people_list_original_;
    people_list_.header.frame_id = "map";
    people_list_.people.insert(people_list_.people.end(), people_list_kinect_.people.begin(), people_list_kinect_.people.end());
}

void lidarCallback(const people_msgs::PeopleConstPtr & people)
{
    std::lock_guard<std::mutex> lock(mux);

    people_list_original_ = *people;

    concateLists();
}


void kinectCallback(const people_msgs::PeopleConstPtr & people)
{
    std::lock_guard<std::mutex> lock(mux);

    people_list_kinect_ = *people;

    lastUpdated = ros::Time::now();
    isCleared = false;

    concateLists();
}


int main(int argc, char **argv)
{
    ros::init(argc, argv, "people_merger");

    ros::Subscriber lidarPositionSubscriber;
    ros::Subscriber kinectPositionSubscriber;

    ros::NodeHandle nh;
    ros::Publisher p = nh.advertise<people_msgs::People>("/people", 2);

    lidarPositionSubscriber = nh.subscribe<people_msgs::People>("people_lidar", 2, lidarCallback);
    kinectPositionSubscriber = nh.subscribe<people_msgs::People>("people_kinect", 2, kinectCallback);

    human_layer::HumanObserver ho;
    ho.initialize();

    while(ros::ok())
    {
        ros::spinOnce();

        ho.update();

        {
            std::lock_guard<std::mutex> lock(mux);
            p.publish(people_list_);
        }

        ros::Duration(0.15).sleep();
    }

    return 0;
}