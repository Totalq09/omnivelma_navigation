;; Auto-generated. Do not edit!


(when (boundp 'omnivelma_msgs::EncodersStamped)
  (if (not (find-package "OMNIVELMA_MSGS"))
    (make-package "OMNIVELMA_MSGS"))
  (shadow 'EncodersStamped (find-package "OMNIVELMA_MSGS")))
(unless (find-package "OMNIVELMA_MSGS::ENCODERSSTAMPED")
  (make-package "OMNIVELMA_MSGS::ENCODERSSTAMPED"))

(in-package "ROS")
;;//! \htmlinclude EncodersStamped.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass omnivelma_msgs::EncodersStamped
  :super ros::object
  :slots (_header _encoders ))

(defmethod omnivelma_msgs::EncodersStamped
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:encoders __encoders) (instance omnivelma_msgs::Encoders :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _encoders __encoders)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:encoders
   (&rest __encoders)
   (if (keywordp (car __encoders))
       (send* _encoders __encoders)
     (progn
       (if __encoders (setq _encoders (car __encoders)))
       _encoders)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; omnivelma_msgs/Encoders _encoders
    (send _encoders :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; omnivelma_msgs/Encoders _encoders
       (send _encoders :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; omnivelma_msgs/Encoders _encoders
     (send _encoders :deserialize buf ptr-) (incf ptr- (send _encoders :serialization-length))
   ;;
   self)
  )

(setf (get omnivelma_msgs::EncodersStamped :md5sum-) "e154a3842268fb728f92dcf5b5cba110")
(setf (get omnivelma_msgs::EncodersStamped :datatype-) "omnivelma_msgs/EncodersStamped")
(setf (get omnivelma_msgs::EncodersStamped :definition-)
      "std_msgs/Header header
omnivelma_msgs/Encoders encoders

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

================================================================================
MSG: omnivelma_msgs/Encoders
omnivelma_msgs/Vels velocity
omnivelma_msgs/Vels angle

================================================================================
MSG: omnivelma_msgs/Vels
float64 fr
float64 fl
float64 rl
float64 rr
")



(provide :omnivelma_msgs/EncodersStamped "e154a3842268fb728f92dcf5b5cba110")


