;; Auto-generated. Do not edit!


(when (boundp 'omnivelma_msgs::SetFriction)
  (if (not (find-package "OMNIVELMA_MSGS"))
    (make-package "OMNIVELMA_MSGS"))
  (shadow 'SetFriction (find-package "OMNIVELMA_MSGS")))
(unless (find-package "OMNIVELMA_MSGS::SETFRICTION")
  (make-package "OMNIVELMA_MSGS::SETFRICTION"))
(unless (find-package "OMNIVELMA_MSGS::SETFRICTIONREQUEST")
  (make-package "OMNIVELMA_MSGS::SETFRICTIONREQUEST"))
(unless (find-package "OMNIVELMA_MSGS::SETFRICTIONRESPONSE")
  (make-package "OMNIVELMA_MSGS::SETFRICTIONRESPONSE"))

(in-package "ROS")





(defclass omnivelma_msgs::SetFrictionRequest
  :super ros::object
  :slots (_mu1 _mu2 ))

(defmethod omnivelma_msgs::SetFrictionRequest
  (:init
   (&key
    ((:mu1 __mu1) 0.0)
    ((:mu2 __mu2) 0.0)
    )
   (send-super :init)
   (setq _mu1 (float __mu1))
   (setq _mu2 (float __mu2))
   self)
  (:mu1
   (&optional __mu1)
   (if __mu1 (setq _mu1 __mu1)) _mu1)
  (:mu2
   (&optional __mu2)
   (if __mu2 (setq _mu2 __mu2)) _mu2)
  (:serialization-length
   ()
   (+
    ;; float64 _mu1
    8
    ;; float64 _mu2
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _mu1
       (sys::poke _mu1 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _mu2
       (sys::poke _mu2 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _mu1
     (setq _mu1 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _mu2
     (setq _mu2 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass omnivelma_msgs::SetFrictionResponse
  :super ros::object
  :slots ())

(defmethod omnivelma_msgs::SetFrictionResponse
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass omnivelma_msgs::SetFriction
  :super ros::object
  :slots ())

(setf (get omnivelma_msgs::SetFriction :md5sum-) "f4a6558102ac1181f82735851ff5553b")
(setf (get omnivelma_msgs::SetFriction :datatype-) "omnivelma_msgs/SetFriction")
(setf (get omnivelma_msgs::SetFriction :request) omnivelma_msgs::SetFrictionRequest)
(setf (get omnivelma_msgs::SetFriction :response) omnivelma_msgs::SetFrictionResponse)

(defmethod omnivelma_msgs::SetFrictionRequest
  (:response () (instance omnivelma_msgs::SetFrictionResponse :init)))

(setf (get omnivelma_msgs::SetFrictionRequest :md5sum-) "f4a6558102ac1181f82735851ff5553b")
(setf (get omnivelma_msgs::SetFrictionRequest :datatype-) "omnivelma_msgs/SetFrictionRequest")
(setf (get omnivelma_msgs::SetFrictionRequest :definition-)
      "float64 mu1
float64 mu2
---
")

(setf (get omnivelma_msgs::SetFrictionResponse :md5sum-) "f4a6558102ac1181f82735851ff5553b")
(setf (get omnivelma_msgs::SetFrictionResponse :datatype-) "omnivelma_msgs/SetFrictionResponse")
(setf (get omnivelma_msgs::SetFrictionResponse :definition-)
      "float64 mu1
float64 mu2
---
")



(provide :omnivelma_msgs/SetFriction "f4a6558102ac1181f82735851ff5553b")


