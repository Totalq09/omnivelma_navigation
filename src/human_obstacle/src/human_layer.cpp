#include <human_obstacle/human_layer.h>
//#include "human_layer.h"
#include <pluginlib/class_list_macros.h>

PLUGINLIB_EXPORT_CLASS(human_layer::HumanLayer, costmap_2d::Layer)

using costmap_2d::LETHAL_OBSTACLE;
using costmap_2d::NO_INFORMATION;
using costmap_2d::FREE_SPACE;


namespace human_layer
{
    HumanLayer::HumanLayer() {};

    void HumanLayer::onInitialize()
    {
        nh = new ros::NodeHandle("~/" + name_);
        current_ = true;
        default_value_ = NO_INFORMATION;
        enabled_ = true;

        master = layered_costmap_->getCostmap();

        matchSize();

        try{
            map2cameraListener.waitForTransform("/map", "/camera_link", ros::Time(0), ros::Duration(20.0));
            map2cameraListener.lookupTransform("/map", "/camera_link",
                            ros::Time(0), map2cameraTransform);                
        }
        catch (tf::TransformException &ex) 
        {
            ROS_ERROR("%s",ex.what());
            ros::Duration(1.0).sleep();
            return;
        }

        std::string source("human_layer");
        ros::NodeHandle source_node(*nh, source);

        source_node.param("pointMinDiff", pointMinDiff, 0.25);
        source_node.param("pointLifetiem", pointLifetime, 0.5);
        source_node.param("innerRadius", innerRadius, 0.5);
        source_node.param("distanceStep", distanceStep, 0.02);
        source_node.param("radiusInnerStep", radiusInnerStep, 0.02);
        source_node.param("outerRadius", outerRadius, 1.75);
        source_node.param("outerRoundnessA", outerRoundnessA, 2.0);
        source_node.param("outerRoundnessB", outerRoundnessB, 1);
        source_node.param("outerMaxAngle", outerMaxAngle, M_PI);
        source_node.param("radiusOuterStep", radiusOuterStep, 0.01);
        source_node.param("costDeminishSpeed", costDeminishSpeed, 3.5);
        source_node.param("enablePublishingPeoplePositions", enablePublishingPeoplePositions, true);
        source_node.param<std::string>("peoplePositionsTopic", peoplePositionsTopic, "/people_positions_kinect");

        peopleSubscriber = nh->subscribe("/face_detector/faces_cloud_upperbody", 5, &HumanLayer::peopleCloudUpdate, this);

        if(enablePublishingPeoplePositions)
        {
            peoplePositionsPublisher = nh->advertise<people_msgs::People>(peoplePositionsTopic, 10);
            peoplePositionsPublishertToSocialLayer = nh->advertise<people_msgs::People>("/people_facing", 10);
        }
            

        dsrv_ = new dynamic_reconfigure::Server<human_obstacle::human_layerConfig>(*nh);
        dynamic_reconfigure::Server<human_obstacle::human_layerConfig>::CallbackType cb = 
            boost::bind(&HumanLayer::reconfigureCB, this, _1, _2);
        dsrv_->setCallback(cb);
    }

    void HumanLayer::peopleCloudUpdate (const sensor_msgs::PointCloudConstPtr& input)
    {
        {
            std::lock_guard<std::mutex> lock(mutex);

            try{
                map2cameraListener.waitForTransform("/map", "/camera_link", ros::Time(0), ros::Duration(3.0));
                map2cameraListener.lookupTransform("/map", "/camera_link",
                                ros::Time(0), map2cameraTransform);                
            }
            catch (tf::TransformException &ex) 
            {
                ROS_ERROR("%s",ex.what());
                ros::Duration(1.0).sleep();
                return;
            }

            //for now simple one face
            int peopleQuantity = 0;

            try
            {
                peopleQuantity = input->points.size();
            }
            catch(...) 
            { 

            }

            //nie wiem czemu ale w ostatnim elemenie jest jakis smiec, co nie jest zgodne z rostopic echo
            for(int i = 0; i < peopleQuantity; i++)
            {
                tf::Vector3 pointCamera(input->points[i].x, input->points[i].y, input->points[i].z);
                tf::Vector3 pointTransformed = map2cameraTransform * pointCamera;
                Vector2Stamped newPoint = Vector2Stamped(pointTransformed.getX(), pointTransformed.getY());
            
                if(foundPeople.size() == 0)
                {
                    foundPeople.push_back(newPoint);
                    HumanFacingArea humanFacingArea(newPoint.humanId, Vector2(newPoint));
                    facingAreas.push_back(humanFacingArea);
                }
                else
                {
                    //check if point exists
                    bool exists = false;
                    for(std::vector<Vector2Stamped>::iterator iter = foundPeople.begin(); iter != foundPeople.end(); iter++)
                    {
                        if(sqrt(pow(((*iter).x - newPoint.x),2) + pow(((*iter).y - newPoint.y), 2)) < pointMinDiff)
                        {
                            (*iter).lastSeen = ros::Time::now();
                            exists = true;
                            break;
                        }  
                    }

                    //point not exists, simply add
                    if(exists == false)
                    {
                        foundPeople.push_back(newPoint);
                        HumanFacingArea humanFacingArea(newPoint.humanId, Vector2(newPoint));
                        facingAreas.push_back(humanFacingArea);
                    }
                }
            }   
        }

        //ros::Duration(0.25).sleep();
    }

    void HumanLayer::matchSize()
    {
        resizeMap(master->getSizeInCellsX(), master->getSizeInCellsY(), master->getResolution(), master->getOriginX(), master->getOriginY());
    }

    //just to fast enable/disable layer
    void HumanLayer::reconfigureCB(human_obstacle::human_layerConfig & config, uint32_t level)
    {
        enabled_ = config.enabled;
        pointMinDiff = config.pointMinDiff;
        pointLifetime = config.pointLifetime;
        innerRadius = config.innerRadius;
        distanceStep = config.distanceStep;
        radiusInnerStep = config.radiusInnerStep;
        outerRadius = config.outerRadius;
        outerRoundnessA = config.outerRoundnessA;
        outerRoundnessB = config.outerRoundnessB;
        outerMaxAngle = config.outerMaxAngle;
        radiusOuterStep = config.radiusOuterStep;
        costDeminishSpeed = config.costDeminishSpeed;
        enablePublishingPeoplePositions = config.enablePublishingPeoplePositions;

        if(enablePublishingPeoplePositions)
            peoplePositionsPublisher = nh->advertise<people_msgs::People>(peoplePositionsTopic, 10);
    }

    void HumanLayer::publishPeoplePositions(people_msgs::People poses)
    {
        //ROS_WARN_STREAM("publish poses: " + peoplePositionsTopic + " " + boost::lexical_cast<std::string>(poses.points.size()));
        if(poses.people.size() > 0)
        {
            peoplePositionsPublishertToSocialLayer.publish(poses);
            peoplePositionsPublisher.publish(poses);
        }
    }
     
    /*The updateBounds method does not change the costmap just yet. 
    It just defines the area that will need to be updated. 
    We calculate the point we want to change (mark_x_, mark_y_) 
    and then expand the min/max bounds to be sure it includes the new point.*/
    void HumanLayer::updateBounds(double robot_x, double robot_y, double robot_yaw, double * min_x, double * min_y, double * max_x, double* max_y)
    {
        {
            std::lock_guard<std::mutex> lock(mutex);

            //ROS_WARN_STREAM("number of people found by kinect: " + boost::lexical_cast<std::string>(foundPeople.size()));

            if(!enabled_)
                return;

            if(foundPeople.size() == 0)
                return;

            updateOrigin(master->getOriginX(), master->getOriginY());

            unsigned int mx;
            unsigned int my;

            double mark_x;
            double mark_y;
            int id;

            people_msgs::People poses;
            poses.header.stamp = ros::Time::now();
            poses.header.frame_id = "odom";

            for(std::vector<Vector2Stamped>::iterator iter = foundPeople.begin(); iter != foundPeople.end();)
            {
                mark_x = (*iter).x;
                mark_y = (*iter).y;
                id = (*iter).humanId;

                //this part is obviously CPU demand, but the vectors will be surely short (<4 I believe), so there is no a serious problem
                for(std::vector<HumanFacingArea>::iterator areaIter = facingAreas.begin(); areaIter != facingAreas.end(); areaIter++)
                {
                    if((*iter).humanId != (*areaIter).humanId)
                        continue;

                    //else the facing is already set
                    //if((*areaIter).facing.x == std::numeric_limits<double>::min())
                    {
                        for(std::vector<Vector2>::iterator it = (*areaIter).points.begin(); it != (*areaIter).points.end(); it++)
                        {
                            setCalculatedCost(it->x, it->y, min_x, min_y, max_x, max_y, NO_INFORMATION);           
                        }

                        Vector2 newFacing = Vector2(robot_x - (*iter).x,  robot_y - (*iter).y);
                        double length = sqrt(newFacing.x * newFacing.x + newFacing.y * newFacing.y);
                        newFacing.x /= length;
                        newFacing.y /= length;

                        (*areaIter).facing.x = newFacing.x;
                        (*areaIter).facing.y = newFacing.y;
                        //break;
                    }
                }

                if((ros::Time::now() - (*iter).lastSeen).toSec() > pointLifetime)
                {
                    deleteHumanCost(id, mark_x, mark_y, min_x, min_y, max_x, max_y);                 

                    // I <3 c++
                    iter = foundPeople.erase(iter);

                    continue;
                }  
              
                setHumanCost(id, mark_x, mark_y, min_x, min_y, max_x, max_y, robot_x, robot_y);

                if(enablePublishingPeoplePositions)
                {
                    people_msgs::Person person;
                    person.name = "human" + boost::lexical_cast<std::string>(id);

                    geometry_msgs::Point p;
                    p.x = (*iter).x;
                    p.y = (*iter).y;
                    p.z = 1.0;
                    person.position = p;

                    Vector2 newFacing = Vector2(robot_x - (*iter).x,  robot_y - (*iter).y);
                    double length = sqrt(newFacing.x * newFacing.x + newFacing.y * newFacing.y);
                    newFacing.x /= length;
                    newFacing.y /= length;

                    geometry_msgs::Point v;
                    v.x = newFacing.x * 0.1;
                    v.y = newFacing.y * 0.1;
                    v.z = 0.0;     
                    person.velocity = v;

                    poses.people.push_back(person);
                }
 
                iter++;
            }

            if(enablePublishingPeoplePositions)
                publishPeoplePositions(poses);           
        }
    }

    void HumanLayer::setHumanCost(int id, double mark_x, double mark_y, double * min_x, double * min_y, double * max_x, double* max_y, double robot_x, double robot_y)
    {
        for(std::vector<HumanFacingArea>::iterator areaIter = facingAreas.begin(); areaIter != facingAreas.end(); areaIter++)
        {
            if(id != (*areaIter).humanId)
                continue;

            Vector2 initFacing = (*areaIter).facing;
            /*for(double angle = -outerMaxAngle; angle <= outerMaxAngle; angle += radiusOuterStep)
            {
                double outerRad = outerRadius * (1.0 / (outerRoundnessA * pow(pow((angle/(outerMaxAngle)),2),outerRoundnessB) + 1.0));

                //angle between initFacing and standard x-axis
                double dot = 1.0 * initFacing.x;
                double det = 1.0 * initFacing.y;
                double currentAngle = angle + atan2(det, dot);

                Vector2 currentFacingPoint;
                currentFacingPoint.x = (*areaIter).personPos.x + cos(currentAngle) * outerRad;
                currentFacingPoint.y = (*areaIter).personPos.y + sin(currentAngle) * outerRad;

                Vector2 facing;
                facing.x = currentFacingPoint.x - (*areaIter).personPos.x;
                facing.y = currentFacingPoint.y - (*areaIter).personPos.y;

                double length = sqrt(facing.x*facing.x + facing.y*facing.y);
                facing.x /= length;
                facing.y /= length;

                for(double r = distanceStep; r <= outerRad; r += distanceStep)
                {
                    int costParsed = (1.0 / ( 1 + costDeminishSpeed * pow((outerRad-r)/outerRad,6))) * 254;
                    //int costParsed = 254;
                    Vector2 newPoint = Vector2((*areaIter).personPos.x + facing.x * r, (*areaIter).personPos.y + facing.y * r);
                    (*areaIter).points.push_back(newPoint);

                    setCalculatedCost(newPoint.x, newPoint.y, min_x, min_y, max_x, max_y, costParsed);
                }
            }*/

            //circle
            /*for(double r = distanceStep; r <= innerRadius; r += distanceStep)
            {
                for(double angle = 0.0; angle < 2*M_PI; angle += radiusInnerStep)
                { 
                    double x = mark_x + cos(angle) * r;
                    double y = mark_y + sin(angle) * r;

                    setCalculatedCost(x, y, min_x, min_y, max_x, max_y, humanCost);   
                }  
            }*/

            break;
        }
    }

    void HumanLayer::deleteHumanCost(int id, double mark_x, double mark_y, double * min_x, double * min_y, double * max_x, double* max_y)
    {
        //circle
        /*for(double r = distanceStep; r <= innerRadius; r += distanceStep)
        {
            for(double angle = 0.0; angle < 2*M_PI; angle += radiusInnerStep)
            { 
                double x = mark_x + cos(angle) * r;
                double y = mark_y + sin(angle) * r;

                setCalculatedCost(x, y, min_x, min_y, max_x, max_y, NO_INFORMATION);   
            }  
        }*/

        for(std::vector<HumanFacingArea>::iterator areaIter = facingAreas.begin(); areaIter != facingAreas.end(); areaIter++)
        {
            if(id != (*areaIter).humanId)
                continue;

            for(std::vector<Vector2>::iterator it = (*areaIter).points.begin(); it != (*areaIter).points.end(); it++)
            {
                setCalculatedCost(it->x, it->y, min_x, min_y, max_x, max_y, NO_INFORMATION);           
            }

            (*areaIter).points.clear();
            facingAreas.erase(areaIter);

            break;
        }
    }

    void HumanLayer::setCalculatedCost(double mark_x, double mark_y, double * min_x, double * min_y, double * max_x, double* max_y, int cost)
    {
        unsigned int mx;
        unsigned int my;

        //ROS_WARN_STREAM("Points to update x: " + boost::lexical_cast<std::string>(mark_x) + " y: " + boost::lexical_cast<std::string>(mark_y));

        if(worldToMap(mark_x, mark_y, mx, my))
        {
            setCost(mx, my, cost);     
        }

        *min_x = std::min(*min_x, mark_x);
        *min_y = std::min(*min_y, mark_y);
        *max_x = std::max(*max_x, mark_x);
        *max_y = std::max(*max_y, mark_y);
    }

    void HumanLayer::updateCosts(costmap_2d::Costmap2D & master_grid, int min_i, int min_j, int max_i, int max_j)
    {
        if(!enabled_)
            return;

        for(int j = min_j; j < max_j; j++)
        {
            for(int i = min_i; i < max_i; i++)
            {
                int index = getIndex(i,j);
                if (costmap_[index] == NO_INFORMATION)
                continue;

                master_grid.setCost(i, j, costmap_[index]);
            }
        }
    }
}

