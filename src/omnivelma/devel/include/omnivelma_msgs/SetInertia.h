// Generated by gencpp from file omnivelma_msgs/SetInertia.msg
// DO NOT EDIT!


#ifndef OMNIVELMA_MSGS_MESSAGE_SETINERTIA_H
#define OMNIVELMA_MSGS_MESSAGE_SETINERTIA_H

#include <ros/service_traits.h>


#include <omnivelma_msgs/SetInertiaRequest.h>
#include <omnivelma_msgs/SetInertiaResponse.h>


namespace omnivelma_msgs
{

struct SetInertia
{

typedef SetInertiaRequest Request;
typedef SetInertiaResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct SetInertia
} // namespace omnivelma_msgs


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::omnivelma_msgs::SetInertia > {
  static const char* value()
  {
    return "95e035d263d97e8c32424221cde3ffa8";
  }

  static const char* value(const ::omnivelma_msgs::SetInertia&) { return value(); }
};

template<>
struct DataType< ::omnivelma_msgs::SetInertia > {
  static const char* value()
  {
    return "omnivelma_msgs/SetInertia";
  }

  static const char* value(const ::omnivelma_msgs::SetInertia&) { return value(); }
};


// service_traits::MD5Sum< ::omnivelma_msgs::SetInertiaRequest> should match 
// service_traits::MD5Sum< ::omnivelma_msgs::SetInertia > 
template<>
struct MD5Sum< ::omnivelma_msgs::SetInertiaRequest>
{
  static const char* value()
  {
    return MD5Sum< ::omnivelma_msgs::SetInertia >::value();
  }
  static const char* value(const ::omnivelma_msgs::SetInertiaRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::omnivelma_msgs::SetInertiaRequest> should match 
// service_traits::DataType< ::omnivelma_msgs::SetInertia > 
template<>
struct DataType< ::omnivelma_msgs::SetInertiaRequest>
{
  static const char* value()
  {
    return DataType< ::omnivelma_msgs::SetInertia >::value();
  }
  static const char* value(const ::omnivelma_msgs::SetInertiaRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::omnivelma_msgs::SetInertiaResponse> should match 
// service_traits::MD5Sum< ::omnivelma_msgs::SetInertia > 
template<>
struct MD5Sum< ::omnivelma_msgs::SetInertiaResponse>
{
  static const char* value()
  {
    return MD5Sum< ::omnivelma_msgs::SetInertia >::value();
  }
  static const char* value(const ::omnivelma_msgs::SetInertiaResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::omnivelma_msgs::SetInertiaResponse> should match 
// service_traits::DataType< ::omnivelma_msgs::SetInertia > 
template<>
struct DataType< ::omnivelma_msgs::SetInertiaResponse>
{
  static const char* value()
  {
    return DataType< ::omnivelma_msgs::SetInertia >::value();
  }
  static const char* value(const ::omnivelma_msgs::SetInertiaResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // OMNIVELMA_MSGS_MESSAGE_SETINERTIA_H