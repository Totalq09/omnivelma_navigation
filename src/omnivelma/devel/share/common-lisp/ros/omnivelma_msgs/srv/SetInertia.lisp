; Auto-generated. Do not edit!


(cl:in-package omnivelma_msgs-srv)


;//! \htmlinclude SetInertia-request.msg.html

(cl:defclass <SetInertia-request> (roslisp-msg-protocol:ros-message)
  ((base
    :reader base
    :initarg :base
    :type geometry_msgs-msg:Inertia
    :initform (cl:make-instance 'geometry_msgs-msg:Inertia))
   (front
    :reader front
    :initarg :front
    :type geometry_msgs-msg:Inertia
    :initform (cl:make-instance 'geometry_msgs-msg:Inertia))
   (wheel
    :reader wheel
    :initarg :wheel
    :type geometry_msgs-msg:Inertia
    :initform (cl:make-instance 'geometry_msgs-msg:Inertia)))
)

(cl:defclass SetInertia-request (<SetInertia-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetInertia-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetInertia-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name omnivelma_msgs-srv:<SetInertia-request> is deprecated: use omnivelma_msgs-srv:SetInertia-request instead.")))

(cl:ensure-generic-function 'base-val :lambda-list '(m))
(cl:defmethod base-val ((m <SetInertia-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-srv:base-val is deprecated.  Use omnivelma_msgs-srv:base instead.")
  (base m))

(cl:ensure-generic-function 'front-val :lambda-list '(m))
(cl:defmethod front-val ((m <SetInertia-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-srv:front-val is deprecated.  Use omnivelma_msgs-srv:front instead.")
  (front m))

(cl:ensure-generic-function 'wheel-val :lambda-list '(m))
(cl:defmethod wheel-val ((m <SetInertia-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-srv:wheel-val is deprecated.  Use omnivelma_msgs-srv:wheel instead.")
  (wheel m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetInertia-request>) ostream)
  "Serializes a message object of type '<SetInertia-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'base) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'front) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'wheel) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetInertia-request>) istream)
  "Deserializes a message object of type '<SetInertia-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'base) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'front) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'wheel) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetInertia-request>)))
  "Returns string type for a service object of type '<SetInertia-request>"
  "omnivelma_msgs/SetInertiaRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetInertia-request)))
  "Returns string type for a service object of type 'SetInertia-request"
  "omnivelma_msgs/SetInertiaRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetInertia-request>)))
  "Returns md5sum for a message object of type '<SetInertia-request>"
  "95e035d263d97e8c32424221cde3ffa8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetInertia-request)))
  "Returns md5sum for a message object of type 'SetInertia-request"
  "95e035d263d97e8c32424221cde3ffa8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetInertia-request>)))
  "Returns full string definition for message of type '<SetInertia-request>"
  (cl:format cl:nil "geometry_msgs/Inertia base~%geometry_msgs/Inertia front~%geometry_msgs/Inertia wheel~%~%================================================================================~%MSG: geometry_msgs/Inertia~%# Mass [kg]~%float64 m~%~%# Center of mass [m]~%geometry_msgs/Vector3 com~%~%# Inertia Tensor [kg-m^2]~%#     | ixx ixy ixz |~%# I = | ixy iyy iyz |~%#     | ixz iyz izz |~%float64 ixx~%float64 ixy~%float64 ixz~%float64 iyy~%float64 iyz~%float64 izz~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetInertia-request)))
  "Returns full string definition for message of type 'SetInertia-request"
  (cl:format cl:nil "geometry_msgs/Inertia base~%geometry_msgs/Inertia front~%geometry_msgs/Inertia wheel~%~%================================================================================~%MSG: geometry_msgs/Inertia~%# Mass [kg]~%float64 m~%~%# Center of mass [m]~%geometry_msgs/Vector3 com~%~%# Inertia Tensor [kg-m^2]~%#     | ixx ixy ixz |~%# I = | ixy iyy iyz |~%#     | ixz iyz izz |~%float64 ixx~%float64 ixy~%float64 ixz~%float64 iyy~%float64 iyz~%float64 izz~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetInertia-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'base))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'front))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'wheel))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetInertia-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetInertia-request
    (cl:cons ':base (base msg))
    (cl:cons ':front (front msg))
    (cl:cons ':wheel (wheel msg))
))
;//! \htmlinclude SetInertia-response.msg.html

(cl:defclass <SetInertia-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass SetInertia-response (<SetInertia-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetInertia-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetInertia-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name omnivelma_msgs-srv:<SetInertia-response> is deprecated: use omnivelma_msgs-srv:SetInertia-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetInertia-response>) ostream)
  "Serializes a message object of type '<SetInertia-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetInertia-response>) istream)
  "Deserializes a message object of type '<SetInertia-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetInertia-response>)))
  "Returns string type for a service object of type '<SetInertia-response>"
  "omnivelma_msgs/SetInertiaResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetInertia-response)))
  "Returns string type for a service object of type 'SetInertia-response"
  "omnivelma_msgs/SetInertiaResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetInertia-response>)))
  "Returns md5sum for a message object of type '<SetInertia-response>"
  "95e035d263d97e8c32424221cde3ffa8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetInertia-response)))
  "Returns md5sum for a message object of type 'SetInertia-response"
  "95e035d263d97e8c32424221cde3ffa8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetInertia-response>)))
  "Returns full string definition for message of type '<SetInertia-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetInertia-response)))
  "Returns full string definition for message of type 'SetInertia-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetInertia-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetInertia-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetInertia-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetInertia)))
  'SetInertia-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetInertia)))
  'SetInertia-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetInertia)))
  "Returns string type for a service object of type '<SetInertia>"
  "omnivelma_msgs/SetInertia")