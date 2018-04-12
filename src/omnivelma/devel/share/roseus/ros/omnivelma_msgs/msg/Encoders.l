;; Auto-generated. Do not edit!


(when (boundp 'omnivelma_msgs::Encoders)
  (if (not (find-package "OMNIVELMA_MSGS"))
    (make-package "OMNIVELMA_MSGS"))
  (shadow 'Encoders (find-package "OMNIVELMA_MSGS")))
(unless (find-package "OMNIVELMA_MSGS::ENCODERS")
  (make-package "OMNIVELMA_MSGS::ENCODERS"))

(in-package "ROS")
;;//! \htmlinclude Encoders.msg.html


(defclass omnivelma_msgs::Encoders
  :super ros::object
  :slots (_velocity _angle ))

(defmethod omnivelma_msgs::Encoders
  (:init
   (&key
    ((:velocity __velocity) (instance omnivelma_msgs::Vels :init))
    ((:angle __angle) (instance omnivelma_msgs::Vels :init))
    )
   (send-super :init)
   (setq _velocity __velocity)
   (setq _angle __angle)
   self)
  (:velocity
   (&rest __velocity)
   (if (keywordp (car __velocity))
       (send* _velocity __velocity)
     (progn
       (if __velocity (setq _velocity (car __velocity)))
       _velocity)))
  (:angle
   (&rest __angle)
   (if (keywordp (car __angle))
       (send* _angle __angle)
     (progn
       (if __angle (setq _angle (car __angle)))
       _angle)))
  (:serialization-length
   ()
   (+
    ;; omnivelma_msgs/Vels _velocity
    (send _velocity :serialization-length)
    ;; omnivelma_msgs/Vels _angle
    (send _angle :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; omnivelma_msgs/Vels _velocity
       (send _velocity :serialize s)
     ;; omnivelma_msgs/Vels _angle
       (send _angle :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; omnivelma_msgs/Vels _velocity
     (send _velocity :deserialize buf ptr-) (incf ptr- (send _velocity :serialization-length))
   ;; omnivelma_msgs/Vels _angle
     (send _angle :deserialize buf ptr-) (incf ptr- (send _angle :serialization-length))
   ;;
   self)
  )

(setf (get omnivelma_msgs::Encoders :md5sum-) "a14e6d34d7cb73a32c3f00a409af72f0")
(setf (get omnivelma_msgs::Encoders :datatype-) "omnivelma_msgs/Encoders")
(setf (get omnivelma_msgs::Encoders :definition-)
      "omnivelma_msgs/Vels velocity
omnivelma_msgs/Vels angle

================================================================================
MSG: omnivelma_msgs/Vels
float64 fr
float64 fl
float64 rl
float64 rr
")



(provide :omnivelma_msgs/Encoders "a14e6d34d7cb73a32c3f00a409af72f0")


