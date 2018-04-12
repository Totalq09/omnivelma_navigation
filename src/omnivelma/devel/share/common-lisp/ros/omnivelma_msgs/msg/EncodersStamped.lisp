; Auto-generated. Do not edit!


(cl:in-package omnivelma_msgs-msg)


;//! \htmlinclude EncodersStamped.msg.html

(cl:defclass <EncodersStamped> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (encoders
    :reader encoders
    :initarg :encoders
    :type omnivelma_msgs-msg:Encoders
    :initform (cl:make-instance 'omnivelma_msgs-msg:Encoders)))
)

(cl:defclass EncodersStamped (<EncodersStamped>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EncodersStamped>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EncodersStamped)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name omnivelma_msgs-msg:<EncodersStamped> is deprecated: use omnivelma_msgs-msg:EncodersStamped instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <EncodersStamped>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-msg:header-val is deprecated.  Use omnivelma_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'encoders-val :lambda-list '(m))
(cl:defmethod encoders-val ((m <EncodersStamped>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-msg:encoders-val is deprecated.  Use omnivelma_msgs-msg:encoders instead.")
  (encoders m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EncodersStamped>) ostream)
  "Serializes a message object of type '<EncodersStamped>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'encoders) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EncodersStamped>) istream)
  "Deserializes a message object of type '<EncodersStamped>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'encoders) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EncodersStamped>)))
  "Returns string type for a message object of type '<EncodersStamped>"
  "omnivelma_msgs/EncodersStamped")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EncodersStamped)))
  "Returns string type for a message object of type 'EncodersStamped"
  "omnivelma_msgs/EncodersStamped")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EncodersStamped>)))
  "Returns md5sum for a message object of type '<EncodersStamped>"
  "e154a3842268fb728f92dcf5b5cba110")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EncodersStamped)))
  "Returns md5sum for a message object of type 'EncodersStamped"
  "e154a3842268fb728f92dcf5b5cba110")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EncodersStamped>)))
  "Returns full string definition for message of type '<EncodersStamped>"
  (cl:format cl:nil "std_msgs/Header header~%omnivelma_msgs/Encoders encoders~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: omnivelma_msgs/Encoders~%omnivelma_msgs/Vels velocity~%omnivelma_msgs/Vels angle~%~%================================================================================~%MSG: omnivelma_msgs/Vels~%float64 fr~%float64 fl~%float64 rl~%float64 rr~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EncodersStamped)))
  "Returns full string definition for message of type 'EncodersStamped"
  (cl:format cl:nil "std_msgs/Header header~%omnivelma_msgs/Encoders encoders~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: omnivelma_msgs/Encoders~%omnivelma_msgs/Vels velocity~%omnivelma_msgs/Vels angle~%~%================================================================================~%MSG: omnivelma_msgs/Vels~%float64 fr~%float64 fl~%float64 rl~%float64 rr~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EncodersStamped>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'encoders))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EncodersStamped>))
  "Converts a ROS message object to a list"
  (cl:list 'EncodersStamped
    (cl:cons ':header (header msg))
    (cl:cons ':encoders (encoders msg))
))
