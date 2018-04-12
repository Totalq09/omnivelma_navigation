; Auto-generated. Do not edit!


(cl:in-package omnivelma_msgs-msg)


;//! \htmlinclude Relative.msg.html

(cl:defclass <Relative> (roslisp-msg-protocol:ros-message)
  ((distance
    :reader distance
    :initarg :distance
    :type cl:float
    :initform 0.0)
   (angle
    :reader angle
    :initarg :angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass Relative (<Relative>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Relative>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Relative)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name omnivelma_msgs-msg:<Relative> is deprecated: use omnivelma_msgs-msg:Relative instead.")))

(cl:ensure-generic-function 'distance-val :lambda-list '(m))
(cl:defmethod distance-val ((m <Relative>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-msg:distance-val is deprecated.  Use omnivelma_msgs-msg:distance instead.")
  (distance m))

(cl:ensure-generic-function 'angle-val :lambda-list '(m))
(cl:defmethod angle-val ((m <Relative>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-msg:angle-val is deprecated.  Use omnivelma_msgs-msg:angle instead.")
  (angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Relative>) ostream)
  "Serializes a message object of type '<Relative>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Relative>) istream)
  "Deserializes a message object of type '<Relative>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angle) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Relative>)))
  "Returns string type for a message object of type '<Relative>"
  "omnivelma_msgs/Relative")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Relative)))
  "Returns string type for a message object of type 'Relative"
  "omnivelma_msgs/Relative")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Relative>)))
  "Returns md5sum for a message object of type '<Relative>"
  "1f1d53743f4592ee455aa3eaf9019457")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Relative)))
  "Returns md5sum for a message object of type 'Relative"
  "1f1d53743f4592ee455aa3eaf9019457")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Relative>)))
  "Returns full string definition for message of type '<Relative>"
  (cl:format cl:nil "float64 distance~%float64 angle~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Relative)))
  "Returns full string definition for message of type 'Relative"
  (cl:format cl:nil "float64 distance~%float64 angle~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Relative>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Relative>))
  "Converts a ROS message object to a list"
  (cl:list 'Relative
    (cl:cons ':distance (distance msg))
    (cl:cons ':angle (angle msg))
))
