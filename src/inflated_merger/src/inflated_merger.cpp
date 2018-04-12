#include <inflated_merger/inflated_merger.h>
#include <pluginlib/class_list_macros.h>

PLUGINLIB_EXPORT_CLASS(inflated_merger::InflatedMerger, costmap_2d::Layer)

using costmap_2d::INSCRIBED_INFLATED_OBSTACLE;
using costmap_2d::LETHAL_OBSTACLE;
using costmap_2d::NO_INFORMATION;

namespace inflated_merger
{
    InflatedMerger::InflatedMerger()
    {}

    void InflatedMerger::onInitialize()
    {
        ros::NodeHandle nh("~/" + name_);
        current_ = true;

        dsrv_ = new dynamic_reconfigure::Server<costmap_2d::GenericPluginConfig>(nh);
        dynamic_reconfigure::Server<costmap_2d::GenericPluginConfig>::CallbackType cb = boost::bind(
            &InflatedMerger::reconfigureCB, this, _1, _2);
        dsrv_->setCallback(cb);
    }

    void InflatedMerger::reconfigureCB(costmap_2d::GenericPluginConfig &config, uint32_t level)
    {
        enabled_ = config.enabled;
    }

    void InflatedMerger::updateBounds(double robot_x, double robot_y, double robot_yaw, double* min_x,
                                           double* min_y, double* max_x, double* max_y)
    {
            return;
    }

    void InflatedMerger::updateCosts(costmap_2d::Costmap2D& master_grid, int min_i, int min_j, int max_i,
                                            int max_j)
    {
        if (!enabled_)
            return;

        for (int j = min_j; j < max_j; j+=1)
        {
            int inRow = 0;
            int currentNotInflated = 0;
            bool inSequence = false;
            for (int i = min_i; i < max_i; i++)
            {
                //nie jestesmy w sekwencji, ale zaczyna sie
                if(inSequence == false && master_grid.getCost(i,j) == INSCRIBED_INFLATED_OBSTACLE)
                {
                    inSequence = true;
                    continue;
                }

                //bylismy w sekwencji i ja domykamy
                if(inSequence == true && inRow != 0 && master_grid.getCost(i,j) == INSCRIBED_INFLATED_OBSTACLE)
                {
                    for(int q = 0; q < inRow; q++)
                    {                      
                        //if(inRow > 0)
                        //    ROS_WARN_STREAM("inRow: " + boost::lexical_cast<std::string>(inRow));
                        master_grid.setCost(i-q-1, j, INSCRIBED_INFLATED_OBSTACLE); 
                    }
                    inRow = 0;
                    continue;
                }

                if(inSequence == true && master_grid.getCost(i,j) < INSCRIBED_INFLATED_OBSTACLE )
                {  
                    inRow++;
                    if(inRow > 6)
                    {
                        inRow = 0;
                        inSequence = false;
                    }
                    continue;
                }

                if(inSequence == true && master_grid.getCost(i,j) == INSCRIBED_INFLATED_OBSTACLE)
                {
                    inRow = 0;
                    continue;
                }
            }
        }

        for (int i = min_i; i < max_i; i+=1)
        {
            int inRow = 0;
            int currentNotInflated = 0;
            bool inSequence = false;
            for (int j = min_j; j < max_j; j++)
            {
                //nie jestesmy w sekwencji, ale zaczyna sie
                if(inSequence == false && master_grid.getCost(i,j) == INSCRIBED_INFLATED_OBSTACLE)
                {
                    inSequence = true;
                    continue;
                }

                //bylismy w sekwencji i ja domykamy
                if(inSequence == true && inRow != 0 && master_grid.getCost(i,j) == INSCRIBED_INFLATED_OBSTACLE)
                {
                    for(int q = 0; q < inRow; q++)
                    {                      
                        //if(inRow > 0)
                        //    ROS_WARN_STREAM("inRow: " + boost::lexical_cast<std::string>(inRow));
                        master_grid.setCost(i, j-q-1, INSCRIBED_INFLATED_OBSTACLE); 
                    }
                    inRow = 0;
                    continue;
                }

                if(inSequence == true && master_grid.getCost(i,j) < INSCRIBED_INFLATED_OBSTACLE )
                {  
                    inRow++;
                    if(inRow > 6)
                    {
                        inRow = 0;
                        inSequence = false;
                    }
                    continue;
                }

                if(inSequence == true && master_grid.getCost(i,j) == INSCRIBED_INFLATED_OBSTACLE)
                {
                    inRow = 0;
                    continue;
                }
            }
        }
    }
}
