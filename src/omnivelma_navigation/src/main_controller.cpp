///Written as actionlib callback client

#include <string>
#include <tuple>
#include <boost/lexical_cast.hpp>
#include <stdlib.h> 

#include <ros/ros.h>

#include <actionlib/client/simple_action_client.h>
#include <actionlib/client/terminal_state.h>
#include <move_base_msgs/MoveBaseAction.h>

std::tuple<float, float, float> *coords;

int maxCoords = 3;
int currentCoord = 0;

class MainController
{
private:
    actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> client_;

public:
    MainController(): client_("move_base", true)
    {
        srand(100);
        coords = new std::tuple<float, float, float>[maxCoords];

        coords[0] = std::make_tuple(2.0, -3.0, 1.0);
        coords[1] = std::make_tuple(-3.0, -3.0, 1.0);
        coords[2] = std::make_tuple(0.0, 2.5, 1.0);

        ROS_INFO("Waiting for [move_base] action server to start");
        client_.waitForServer();
        ROS_INFO("[move_base] action server started, ready to send goal");
    }

    void sendNewGoal(move_base_msgs::MoveBaseGoal goal)
    {
        client_.sendGoal(goal, 
            boost::bind(&MainController::doneCb, this, _1, _2),
            actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction>::SimpleActiveCallback(),
            actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction>::SimpleFeedbackCallback()
        );

        ROS_INFO("Main Controller: new goal(%.1f, %.1f) send", goal.target_pose.pose.position.x, goal.target_pose.pose.position.y);
    }

    move_base_msgs::MoveBaseGoal prepareNewGoal()
    {
        move_base_msgs::MoveBaseGoal newGoal;

        newGoal.target_pose.header.frame_id = "map";
        newGoal.target_pose.header.stamp = ros::Time::now();

        newGoal.target_pose.pose.position.x = std::get<0>(coords[currentCoord]);
        newGoal.target_pose.pose.position.y = std::get<1>(coords[currentCoord]);
        newGoal.target_pose.pose.orientation.w = std::get<2>(coords[currentCoord]);

        currentCoord++;

        if(currentCoord >= maxCoords)
            currentCoord = 0;

        return newGoal;
    }

    void doneCb(const actionlib::SimpleClientGoalState & state, const move_base_msgs::MoveBaseResultConstPtr & result)
    {
        ROS_INFO("MainController: Finished current in state [%s]",state.toString().c_str());

        move_base_msgs::MoveBaseGoal newGoal = this->prepareNewGoal();
        this->sendNewGoal(newGoal);
    }
};


int main(int argc, char** argv)
{
    ros::init(argc, argv, "main_controller");
    ros::NodeHandle nh_;

    ros::Duration(8.0).sleep();

    MainController controller;

    move_base_msgs::MoveBaseGoal newGoal = controller.prepareNewGoal();
    controller.sendNewGoal(newGoal);

    ros::spin();

    return 0;
}