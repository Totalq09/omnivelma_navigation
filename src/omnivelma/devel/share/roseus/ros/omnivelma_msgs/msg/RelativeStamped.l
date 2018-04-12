;; Auto-generated. Do not edit!


(when (boundp 'omnivelma_msgs::RelativeStamped)
  (if (not (find-package "OMNIVELMA_MSGS"))
    (make-package "OMNIVELMA_MSGS"))
  (shadow 'RelativeStamped (find-package "OMNIVELMA_MSGS")))
(unless (find-package "OMNIVELMA_MSGS::RELATIVESTAMPED")
  (make-package "OMNIVELMA_MSGS::RELATIVESTAMPED"))

(in-package "ROS")
;;//! \htmlinclude RelativeStamped.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass omnivelma_msgs::RelativeStamped
  :super ros::object
  :slots (_header _relative ))

(defmethod omnivelma_msgs::RelativeStamped
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:relative __relative) (instance omnivelma_msgs::Relative :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _relative __relative)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:relative
   (&rest __relative)
   (if (keywordp (car __relative))
       (send* _relative __relative)
     (progn
       (if __relative (setq _relative (car __relative)))
       _relative)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; omnivelma_msgs/Relative _relative
    (send _relative :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; omnivelma_msgs/Relative _relative
       (send _relative :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; omnivelma_msgs/Relative _relative
     (send _relative :deserialize buf ptr-) (incf ptr- (send _relative :serialization-length))
   ;;
   self)
  )

(setf (get omnivelma_msgs::RelativeStamped :md5sum-) "0b34c76dbe1f5aa71792100dda300765")
(setf (get omnivelma_msgs::RelativeStamped :datatype-) "omnivelma_msgs/RelativeStamped")
(setf (get omnivelma_msgs::RelativeStamped :definition-)
      "std_msgs/Header header
omnivelma_msgs/Relative relative

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
MSG: omnivelma_msgs/Relative
float64 distance
float64 angle
")



(provide :omnivelma_msgs/RelativeStamped "0b34c76dbe1f5aa71792100dda300765")


