;; Auto-generated. Do not edit!


(when (boundp 'omnivelma_msgs::Relative)
  (if (not (find-package "OMNIVELMA_MSGS"))
    (make-package "OMNIVELMA_MSGS"))
  (shadow 'Relative (find-package "OMNIVELMA_MSGS")))
(unless (find-package "OMNIVELMA_MSGS::RELATIVE")
  (make-package "OMNIVELMA_MSGS::RELATIVE"))

(in-package "ROS")
;;//! \htmlinclude Relative.msg.html


(defclass omnivelma_msgs::Relative
  :super ros::object
  :slots (_distance _angle ))

(defmethod omnivelma_msgs::Relative
  (:init
   (&key
    ((:distance __distance) 0.0)
    ((:angle __angle) 0.0)
    )
   (send-super :init)
   (setq _distance (float __distance))
   (setq _angle (float __angle))
   self)
  (:distance
   (&optional __distance)
   (if __distance (setq _distance __distance)) _distance)
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:serialization-length
   ()
   (+
    ;; float64 _distance
    8
    ;; float64 _angle
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _distance
       (sys::poke _distance (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _angle
       (sys::poke _angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _distance
     (setq _distance (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _angle
     (setq _angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get omnivelma_msgs::Relative :md5sum-) "1f1d53743f4592ee455aa3eaf9019457")
(setf (get omnivelma_msgs::Relative :datatype-) "omnivelma_msgs/Relative")
(setf (get omnivelma_msgs::Relative :definition-)
      "float64 distance
float64 angle
")



(provide :omnivelma_msgs/Relative "1f1d53743f4592ee455aa3eaf9019457")


