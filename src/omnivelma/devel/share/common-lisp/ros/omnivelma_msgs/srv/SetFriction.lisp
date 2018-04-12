; Auto-generated. Do not edit!


(cl:in-package omnivelma_msgs-srv)


;//! \htmlinclude SetFriction-request.msg.html

(cl:defclass <SetFriction-request> (roslisp-msg-protocol:ros-message)
  ((mu1
    :reader mu1
    :initarg :mu1
    :type cl:float
    :initform 0.0)
   (mu2
    :reader mu2
    :initarg :mu2
    :type cl:float
    :initform 0.0))
)

(cl:defclass SetFriction-request (<SetFriction-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetFriction-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetFriction-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name omnivelma_msgs-srv:<SetFriction-request> is deprecated: use omnivelma_msgs-srv:SetFriction-request instead.")))

(cl:ensure-generic-function 'mu1-val :lambda-list '(m))
(cl:defmethod mu1-val ((m <SetFriction-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-srv:mu1-val is deprecated.  Use omnivelma_msgs-srv:mu1 instead.")
  (mu1 m))

(cl:ensure-generic-function 'mu2-val :lambda-list '(m))
(cl:defmethod mu2-val ((m <SetFriction-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-srv:mu2-val is deprecated.  Use omnivelma_msgs-srv:mu2 instead.")
  (mu2 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetFriction-request>) ostream)
  "Serializes a message object of type '<SetFriction-request>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'mu1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'mu2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetFriction-request>) istream)
  "Deserializes a message object of type '<SetFriction-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'mu1) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'mu2) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetFriction-request>)))
  "Returns string type for a service object of type '<SetFriction-request>"
  "omnivelma_msgs/SetFrictionRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetFriction-request)))
  "Returns string type for a service object of type 'SetFriction-request"
  "omnivelma_msgs/SetFrictionRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetFriction-request>)))
  "Returns md5sum for a message object of type '<SetFriction-request>"
  "f4a6558102ac1181f82735851ff5553b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetFriction-request)))
  "Returns md5sum for a message object of type 'SetFriction-request"
  "f4a6558102ac1181f82735851ff5553b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetFriction-request>)))
  "Returns full string definition for message of type '<SetFriction-request>"
  (cl:format cl:nil "float64 mu1~%float64 mu2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetFriction-request)))
  "Returns full string definition for message of type 'SetFriction-request"
  (cl:format cl:nil "float64 mu1~%float64 mu2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetFriction-request>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetFriction-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetFriction-request
    (cl:cons ':mu1 (mu1 msg))
    (cl:cons ':mu2 (mu2 msg))
))
;//! \htmlinclude SetFriction-response.msg.html

(cl:defclass <SetFriction-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass SetFriction-response (<SetFriction-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetFriction-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetFriction-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name omnivelma_msgs-srv:<SetFriction-response> is deprecated: use omnivelma_msgs-srv:SetFriction-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetFriction-response>) ostream)
  "Serializes a message object of type '<SetFriction-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetFriction-response>) istream)
  "Deserializes a message object of type '<SetFriction-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetFriction-response>)))
  "Returns string type for a service object of type '<SetFriction-response>"
  "omnivelma_msgs/SetFrictionResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetFriction-response)))
  "Returns string type for a service object of type 'SetFriction-response"
  "omnivelma_msgs/SetFrictionResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetFriction-response>)))
  "Returns md5sum for a message object of type '<SetFriction-response>"
  "f4a6558102ac1181f82735851ff5553b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetFriction-response)))
  "Returns md5sum for a message object of type 'SetFriction-response"
  "f4a6558102ac1181f82735851ff5553b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetFriction-response>)))
  "Returns full string definition for message of type '<SetFriction-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetFriction-response)))
  "Returns full string definition for message of type 'SetFriction-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetFriction-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetFriction-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetFriction-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetFriction)))
  'SetFriction-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetFriction)))
  'SetFriction-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetFriction)))
  "Returns string type for a service object of type '<SetFriction>"
  "omnivelma_msgs/SetFriction")