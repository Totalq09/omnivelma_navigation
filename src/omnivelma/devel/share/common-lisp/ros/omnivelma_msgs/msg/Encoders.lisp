; Auto-generated. Do not edit!


(cl:in-package omnivelma_msgs-msg)


;//! \htmlinclude Encoders.msg.html

(cl:defclass <Encoders> (roslisp-msg-protocol:ros-message)
  ((velocity
    :reader velocity
    :initarg :velocity
    :type omnivelma_msgs-msg:Vels
    :initform (cl:make-instance 'omnivelma_msgs-msg:Vels))
   (angle
    :reader angle
    :initarg :angle
    :type omnivelma_msgs-msg:Vels
    :initform (cl:make-instance 'omnivelma_msgs-msg:Vels)))
)

(cl:defclass Encoders (<Encoders>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Encoders>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Encoders)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name omnivelma_msgs-msg:<Encoders> is deprecated: use omnivelma_msgs-msg:Encoders instead.")))

(cl:ensure-generic-function 'velocity-val :lambda-list '(m))
(cl:defmethod velocity-val ((m <Encoders>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-msg:velocity-val is deprecated.  Use omnivelma_msgs-msg:velocity instead.")
  (velocity m))

(cl:ensure-generic-function 'angle-val :lambda-list '(m))
(cl:defmethod angle-val ((m <Encoders>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-msg:angle-val is deprecated.  Use omnivelma_msgs-msg:angle instead.")
  (angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Encoders>) ostream)
  "Serializes a message object of type '<Encoders>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'velocity) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'angle) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Encoders>) istream)
  "Deserializes a message object of type '<Encoders>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'velocity) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'angle) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Encoders>)))
  "Returns string type for a message object of type '<Encoders>"
  "omnivelma_msgs/Encoders")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Encoders)))
  "Returns string type for a message object of type 'Encoders"
  "omnivelma_msgs/Encoders")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Encoders>)))
  "Returns md5sum for a message object of type '<Encoders>"
  "a14e6d34d7cb73a32c3f00a409af72f0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Encoders)))
  "Returns md5sum for a message object of type 'Encoders"
  "a14e6d34d7cb73a32c3f00a409af72f0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Encoders>)))
  "Returns full string definition for message of type '<Encoders>"
  (cl:format cl:nil "omnivelma_msgs/Vels velocity~%omnivelma_msgs/Vels angle~%~%================================================================================~%MSG: omnivelma_msgs/Vels~%float64 fr~%float64 fl~%float64 rl~%float64 rr~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Encoders)))
  "Returns full string definition for message of type 'Encoders"
  (cl:format cl:nil "omnivelma_msgs/Vels velocity~%omnivelma_msgs/Vels angle~%~%================================================================================~%MSG: omnivelma_msgs/Vels~%float64 fr~%float64 fl~%float64 rl~%float64 rr~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Encoders>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'velocity))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'angle))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Encoders>))
  "Converts a ROS message object to a list"
  (cl:list 'Encoders
    (cl:cons ':velocity (velocity msg))
    (cl:cons ':angle (angle msg))
))
