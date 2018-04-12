#include <SFML/Graphics.hpp>

#include <image_transport/image_transport.h>
#include <sensor_msgs/image_encodings.h>
#include <sensor_msgs/Image.h>
#include <cv_bridge/cv_bridge.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <geometry_msgs/TwistStamped.h>

#include <mutex>
#include <thread>
#include <stdexcept>
#include <iostream>
#include <string>
#include <limits.h>
#include <unistd.h>

#include "font.hpp"

ros::Duration duration(0.01);

const unsigned WINDOW_WIDTH = 640;
const unsigned WINDOW_HEIGHT = 480;

class CameraCapturer
{
private:
    ros::NodeHandle nh_;
    image_transport::ImageTransport it_;
    image_transport::Subscriber image_sub_;

    cv_bridge::CvImagePtr cv_ptr = nullptr;

    std::mutex mux;

public:
    CameraCapturer() : it_(nh_)
    {
        image_sub_ = it_.subscribe("fps_camera/image_raw", 1, &CameraCapturer::callback, this);
    }

    void callback(const sensor_msgs::ImageConstPtr & msg)
    {
        std::lock_guard<std::mutex> lock(mux);

        try
        {
            cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
        }
        catch(cv_bridge::Exception &e)
        {
            ROS_ERROR("cv_bridge exception: %s", e.what());
            return;
        }
    }

    cv::Mat getImage()
    {
        std::lock_guard<std::mutex> lock(mux);
        
        if(cv_ptr == nullptr)
            throw std::runtime_error("CV image not available");
        else
            return cv_ptr->image;
    }
};

class HumanMover
{
private: 
    sf::RenderWindow* window;

    sf::Texture arrowTexture;
    sf::Texture arrowClickedTexture;

    /*
        0 - left 
        1 - up
        2 - right
        3 - down
    */

    sf::Sprite arrowsSprite[4];

    sf::Font font;
    sf::Text speedFactorText;

    bool isForwardPressedPreviously = false;
    bool isBackwardPressedPreviously = false;
    bool isLeftwardPressedPreviously = false;
    bool isRightwardPressedPreviously = false;

    bool isForwardPressedCurrently = false;
    bool isBackwardPressedCurrently = false;
    bool isLeftwardPressedCurrently = false;
    bool isRightwardPressedCurrently = false;

    bool isSpeedPressed = false;

    bool isInputChanged = false;

    bool isArrowsLoadedCorrectly = false;

    double speedFactor = 1.0;

    geometry_msgs::TwistStamped twist;

    ros::Publisher* publisher;

protected:

    void getInput()
    {
        sf::Event event;
        while(window->pollEvent(event))
        {
            if(event.type == sf::Event::Closed)
                window->close();

            if(event.type == sf::Event::KeyPressed)
            {
                if(event.key.code == sf::Keyboard::Left)
                {
                    arrowsSprite[0].setTexture(arrowClickedTexture);
                    isLeftwardPressedCurrently = true;
                }
                if(event.key.code == sf::Keyboard::Up)
                {
                    arrowsSprite[1].setTexture(arrowClickedTexture);
                    isForwardPressedCurrently = true;
                }
                if(event.key.code == sf::Keyboard::Right)
                {
                    arrowsSprite[2].setTexture(arrowClickedTexture);
                    isRightwardPressedCurrently = true;
                }
                if(event.key.code == sf::Keyboard::Down)
                {
                    arrowsSprite[3].setTexture(arrowClickedTexture);
                    isBackwardPressedCurrently = true;
                }

                if(event.key.code == sf::Keyboard::Add)
                {
                    speedFactor *= 2;
                    if(speedFactor >= 1.0)
                        speedFactor = 1.0;
                    isSpeedPressed = true;
                }   

                if(event.key.code == sf::Keyboard::Subtract)
                {
                    speedFactor /= 2;
                    if(speedFactor <= 0.25)
                        speedFactor = 0.25;
                    isSpeedPressed = true;
                }   
            }

            if(event.type == sf::Event::KeyReleased)
            {
                if(event.key.code == sf::Keyboard::Left)
                {
                    arrowsSprite[0].setTexture(arrowTexture);
                    isLeftwardPressedCurrently = false;
                }
                if(event.key.code == sf::Keyboard::Up)
                {
                    arrowsSprite[1].setTexture(arrowTexture);
                    isForwardPressedCurrently = false;
                }
                if(event.key.code == sf::Keyboard::Right)
                {
                    arrowsSprite[2].setTexture(arrowTexture);
                    isRightwardPressedCurrently = false;
                }
                if(event.key.code == sf::Keyboard::Down)
                {
                    arrowsSprite[3].setTexture(arrowTexture);
                    isBackwardPressedCurrently = false;
                }
            }
        }

        speedFactorText.setString("Human speed: " + boost::str(boost::format("%.2f") % speedFactor));
    }

    void calculateCurrentTwist()
    {
        twist.header.stamp = ros::Time::now();

        if(isForwardPressedCurrently == true && isBackwardPressedCurrently == true)
        {
            twist.twist.linear.x = 0.0;
        }
        else if(isForwardPressedCurrently == true && isBackwardPressedCurrently == false)
        {
            twist.twist.linear.x = 1.0 * speedFactor;
        }
        else if(isForwardPressedCurrently == false && isBackwardPressedCurrently == true)
        {
            twist.twist.linear.x = -1.0 * speedFactor;
        }
        else
        {
            twist.twist.linear.x = 0.0;
        }

        if(isLeftwardPressedCurrently == true && isRightwardPressedCurrently == true)
        {
            twist.twist.angular.z = 0.0;
        }
        else if(isLeftwardPressedCurrently == true && isRightwardPressedCurrently == false)
        {
            twist.twist.angular.z = 1.5 * speedFactor;
        }
        else if(isLeftwardPressedCurrently == false && isRightwardPressedCurrently == true)
        {
            twist.twist.angular.z = -1.5 * speedFactor;
        }
        else
        {
            twist.twist.angular.z = 0.0;
        }

        //check if input has changed

        if(isForwardPressedCurrently != isForwardPressedPreviously || 
            isBackwardPressedCurrently != isBackwardPressedPreviously || 
            isLeftwardPressedCurrently != isLeftwardPressedPreviously ||
            isRightwardPressedCurrently != isRightwardPressedPreviously || isSpeedPressed == true)
        {
            isForwardPressedPreviously = isForwardPressedCurrently;
            isBackwardPressedPreviously = isBackwardPressedCurrently;
            isLeftwardPressedPreviously = isLeftwardPressedCurrently;
            isRightwardPressedPreviously = isRightwardPressedCurrently;
            isSpeedPressed = false;

            isInputChanged = true;
        }
    }

    void publishTwist()
    {
        if(isInputChanged == true)
        {
            isInputChanged = false;
            publisher->publish(twist);

            /*std::cout << "TWIST: " +
                boost::lexical_cast<std::string>(twist.twist.linear.x) + " " +
                boost::lexical_cast<std::string>(twist.twist.linear.y) + " " +
                boost::lexical_cast<std::string>(twist.twist.linear.z) + " " +
                boost::lexical_cast<std::string>(twist.twist.angular.x) + " " +
                boost::lexical_cast<std::string>(twist.twist.angular.y) + " " +
                boost::lexical_cast<std::string>(twist.twist.angular.z) << std::endl;*/
        }
    }

public:

    HumanMover(sf::RenderWindow* window, ros::Publisher* publisher)
    {
        this->window = window;
        this->publisher = publisher;

        twist.header.frame_id = "map";

        twist.twist.linear.y = 0.0;
        twist.twist.linear.z = 0.0;
        twist.twist.angular.x = 0.0;
        twist.twist.angular.y = 0.0;  
    }

    bool loadResources()
    {
        isArrowsLoadedCorrectly = true;

        if(!arrowTexture.loadFromFile("/home/pwalas1/catkin_pw/src/omnivelma/src/human_mover/include/arrows/down.png"))
        {
            isArrowsLoadedCorrectly = false;
            std::cout << "down.png not loaded" << std::endl;  
        }

        if(!arrowClickedTexture.loadFromFile("/home/pwalas1/catkin_pw/src/omnivelma/src/human_mover/include/arrows/down_clicked.png"))
        {
            isArrowsLoadedCorrectly = false;
            std::cout << "down_clicked.png not loaded" << std::endl;  
        }

        if(isArrowsLoadedCorrectly == true)
        {
            std::cout << "Texture loaded properly" << std::endl;    

            sf::Vector2f scale(0.5, 0.5);
            double scaleFlipped = 0.5;

            for(int i = 0; i < 4; i++)
            {
                arrowsSprite[i].setTexture(arrowTexture);
                arrowsSprite[i].setOrigin(25,25);
                arrowsSprite[i].rotate((i+1) * (90));
                arrowsSprite[i].scale(scale);
            }

            arrowsSprite[0].setPosition(WINDOW_WIDTH/2 - (50 + 5 + 1) * scaleFlipped, WINDOW_HEIGHT - (50 + 25 - 1) * scaleFlipped );
            arrowsSprite[1].setPosition(WINDOW_WIDTH/2 , WINDOW_HEIGHT - (50 + 25 + 5 + 50) * scaleFlipped );
            arrowsSprite[2].setPosition(WINDOW_WIDTH/2  + (50 + 5 + 1) * scaleFlipped, WINDOW_HEIGHT - (50 + 25 - 1) * scaleFlipped );
            arrowsSprite[3].setPosition(WINDOW_WIDTH/2 , WINDOW_HEIGHT - (50 + 25) * scaleFlipped );
        }
        else
        {
            std::cout << "Path where texture should be placed: " << "/home/pwalas1/catkin_pw/src/omnivelma/src/human_mover/include/arrows" << std::endl;
        }

        font.loadFromMemory(fontData, fontDataSize);
        speedFactorText.setFont(font);
        speedFactorText.setColor(sf::Color::Blue);
        speedFactorText.setCharacterSize(16);

        return isArrowsLoadedCorrectly;
    }

    void handleInput()
    {
        getInput();
        calculateCurrentTwist(); 
        publishTwist();
    }

    double getSpeedFactor()
    {
        return speedFactor;
    }

    void draw()
    {
        if(isArrowsLoadedCorrectly == true)
        {
            for(int i = 0; i < 4; i++)
                window->draw(arrowsSprite[i]);
        }

        window->draw(speedFactorText);
    }

};

////////

void updateGazeboImage()
{
    while(ros::ok())
    {
        ros::spinOnce();
        duration.sleep();
    }
}

int main(int argc, char **argv)
{
    //ROS SECTION

    if(!ros::isInitialized())
    {
        ros::init(argc, argv, "mover");
    }

    ros::NodeHandle nh_;
    ros::Publisher velPublisher = nh_.advertise<geometry_msgs::TwistStamped>("human/velocity", 2);

    sf::RenderWindow window(sf::VideoMode(WINDOW_WIDTH,WINDOW_HEIGHT), "Human Mover");
    sf::Image image;
    sf::Texture viewTexture;
    sf::Sprite viewSprite;
    cv::Mat mat;

    //CLASS INITIALIZERS

    CameraCapturer cc;
    HumanMover hm(&window, &velPublisher);

    //start callback thread
    //it might be simpler, but I want this duration.sleep() inside
    std::thread t(updateGazeboImage);
    t.detach();

    bool isArrowsLoadedCorrectly = hm.loadResources();
    
    while(window.isOpen() && ros::ok())
    {
        //OPENCV TO SF::IMAGE SECTION
        try{
            mat = cc.getImage();
            if(mat.empty())
                throw std::runtime_error("CV image not available");
        }
        catch(std::runtime_error &e)
        {
            std::cout << e.what() << std::endl;
            ros::Duration(0.5).sleep();
            continue;
        }

        cv::cvtColor(mat, mat, cv::COLOR_BGR2RGBA);

        image.create(mat.cols, mat.rows, mat.ptr());

        if(!viewTexture.loadFromImage(image))
        {
            return 1;
        }

        viewSprite.setTexture(viewTexture);

        //MOVER SECTION

        ros::Duration(0.005).sleep();
        hm.handleInput();

        //DRAW SECTION

        window.clear();

        window.draw(viewSprite);
        hm.draw();

        window.display();
        ros::Duration(0.05).sleep();
    }

    if(window.isOpen())
        window.close();

    return 0;
}