; Auto-generated. Do not edit!


(cl:in-package omnivelma_msgs-msg)


;//! \htmlinclude Vels.msg.html

(cl:defclass <Vels> (roslisp-msg-protocol:ros-message)
  ((fr
    :reader fr
    :initarg :fr
    :type cl:float
    :initform 0.0)
   (fl
    :reader fl
    :initarg :fl
    :type cl:float
    :initform 0.0)
   (rl
    :reader rl
    :initarg :rl
    :type cl:float
    :initform 0.0)
   (rr
    :reader rr
    :initarg :rr
    :type cl:float
    :initform 0.0))
)

(cl:defclass Vels (<Vels>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Vels>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Vels)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name omnivelma_msgs-msg:<Vels> is deprecated: use omnivelma_msgs-msg:Vels instead.")))

(cl:ensure-generic-function 'fr-val :lambda-list '(m))
(cl:defmethod fr-val ((m <Vels>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-msg:fr-val is deprecated.  Use omnivelma_msgs-msg:fr instead.")
  (fr m))

(cl:ensure-generic-function 'fl-val :lambda-list '(m))
(cl:defmethod fl-val ((m <Vels>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-msg:fl-val is deprecated.  Use omnivelma_msgs-msg:fl instead.")
  (fl m))

(cl:ensure-generic-function 'rl-val :lambda-list '(m))
(cl:defmethod rl-val ((m <Vels>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-msg:rl-val is deprecated.  Use omnivelma_msgs-msg:rl instead.")
  (rl m))

(cl:ensure-generic-function 'rr-val :lambda-list '(m))
(cl:defmethod rr-val ((m <Vels>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omnivelma_msgs-msg:rr-val is deprecated.  Use omnivelma_msgs-msg:rr instead.")
  (rr m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Vels>) ostream)
  "Serializes a message object of type '<Vels>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'fr))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'fl))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'rl))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'rr))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Vels>) istream)
  "Deserializes a message object of type '<Vels>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fr) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fl) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rl) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rr) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Vels>)))
  "Returns string type for a message object of type '<Vels>"
  "omnivelma_msgs/Vels")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Vels)))
  "Returns string type for a message object of type 'Vels"
  "omnivelma_msgs/Vels")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Vels>)))
  "Returns md5sum for a message object of type '<Vels>"
  "d9241866e5fa52f8ff5c46fd7ab0776e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Vels)))
  "Returns md5sum for a message object of type 'Vels"
  "d9241866e5fa52f8ff5c46fd7ab0776e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Vels>)))
  "Returns full string definition for message of type '<Vels>"
  (cl:format cl:nil "float64 fr~%float64 fl~%float64 rl~%float64 rr~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Vels)))
  "Returns full string definition for message of type 'Vels"
  (cl:format cl:nil "float64 fr~%float64 fl~%float64 rl~%float64 rr~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Vels>))
  (cl:+ 0
     8
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Vels>))
  "Converts a ROS message object to a list"
  (cl:list 'Vels
    (cl:cons ':fr (fr msg))
    (cl:cons ':fl (fl msg))
    (cl:cons ':rl (rl msg))
    (cl:cons ':rr (rr msg))
))
