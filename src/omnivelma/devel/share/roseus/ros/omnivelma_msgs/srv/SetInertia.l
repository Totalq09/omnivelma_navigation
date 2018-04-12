;; Auto-generated. Do not edit!


(when (boundp 'omnivelma_msgs::SetInertia)
  (if (not (find-package "OMNIVELMA_MSGS"))
    (make-package "OMNIVELMA_MSGS"))
  (shadow 'SetInertia (find-package "OMNIVELMA_MSGS")))
(unless (find-package "OMNIVELMA_MSGS::SETINERTIA")
  (make-package "OMNIVELMA_MSGS::SETINERTIA"))
(unless (find-package "OMNIVELMA_MSGS::SETINERTIAREQUEST")
  (make-package "OMNIVELMA_MSGS::SETINERTIAREQUEST"))
(unless (find-package "OMNIVELMA_MSGS::SETINERTIARESPONSE")
  (make-package "OMNIVELMA_MSGS::SETINERTIARESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass omnivelma_msgs::SetInertiaRequest
  :super ros::object
  :slots (_base _front _wheel ))

(defmethod omnivelma_msgs::SetInertiaRequest
  (:init
   (&key
    ((:base __base) (instance geometry_msgs::Inertia :init))
    ((:front __front) (instance geometry_msgs::Inertia :init))
    ((:wheel __wheel) (instance geometry_msgs::Inertia :init))
    )
   (send-super :init)
   (setq _base __base)
   (setq _front __front)
   (setq _wheel __wheel)
   self)
  (:base
   (&rest __base)
   (if (keywordp (car __base))
       (send* _base __base)
     (progn
       (if __base (setq _base (car __base)))
       _base)))
  (:front
   (&rest __front)
   (if (keywordp (car __front))
       (send* _front __front)
     (progn
       (if __front (setq _front (car __front)))
       _front)))
  (:wheel
   (&rest __wheel)
   (if (keywordp (car __wheel))
       (send* _wheel __wheel)
     (progn
       (if __wheel (setq _wheel (car __wheel)))
       _wheel)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Inertia _base
    (send _base :serialization-length)
    ;; geometry_msgs/Inertia _front
    (send _front :serialization-length)
    ;; geometry_msgs/Inertia _wheel
    (send _wheel :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Inertia _base
       (send _base :serialize s)
     ;; geometry_msgs/Inertia _front
       (send _front :serialize s)
     ;; geometry_msgs/Inertia _wheel
       (send _wheel :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Inertia _base
     (send _base :deserialize buf ptr-) (incf ptr- (send _base :serialization-length))
   ;; geometry_msgs/Inertia _front
     (send _front :deserialize buf ptr-) (incf ptr- (send _front :serialization-length))
   ;; geometry_msgs/Inertia _wheel
     (send _wheel :deserialize buf ptr-) (incf ptr- (send _wheel :serialization-length))
   ;;
   self)
  )

(defclass omnivelma_msgs::SetInertiaResponse
  :super ros::object
  :slots ())

(defmethod omnivelma_msgs::SetInertiaResponse
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

(defclass omnivelma_msgs::SetInertia
  :super ros::object
  :slots ())

(setf (get omnivelma_msgs::SetInertia :md5sum-) "95e035d263d97e8c32424221cde3ffa8")
(setf (get omnivelma_msgs::SetInertia :datatype-) "omnivelma_msgs/SetInertia")
(setf (get omnivelma_msgs::SetInertia :request) omnivelma_msgs::SetInertiaRequest)
(setf (get omnivelma_msgs::SetInertia :response) omnivelma_msgs::SetInertiaResponse)

(defmethod omnivelma_msgs::SetInertiaRequest
  (:response () (instance omnivelma_msgs::SetInertiaResponse :init)))

(setf (get omnivelma_msgs::SetInertiaRequest :md5sum-) "95e035d263d97e8c32424221cde3ffa8")
(setf (get omnivelma_msgs::SetInertiaRequest :datatype-) "omnivelma_msgs/SetInertiaRequest")
(setf (get omnivelma_msgs::SetInertiaRequest :definition-)
      "geometry_msgs/Inertia base
geometry_msgs/Inertia front
geometry_msgs/Inertia wheel

================================================================================
MSG: geometry_msgs/Inertia
# Mass [kg]
float64 m

# Center of mass [m]
geometry_msgs/Vector3 com

# Inertia Tensor [kg-m^2]
#     | ixx ixy ixz |
# I = | ixy iyy iyz |
#     | ixz iyz izz |
float64 ixx
float64 ixy
float64 ixz
float64 iyy
float64 iyz
float64 izz

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
---
")

(setf (get omnivelma_msgs::SetInertiaResponse :md5sum-) "95e035d263d97e8c32424221cde3ffa8")
(setf (get omnivelma_msgs::SetInertiaResponse :datatype-) "omnivelma_msgs/SetInertiaResponse")
(setf (get omnivelma_msgs::SetInertiaResponse :definition-)
      "geometry_msgs/Inertia base
geometry_msgs/Inertia front
geometry_msgs/Inertia wheel

================================================================================
MSG: geometry_msgs/Inertia
# Mass [kg]
float64 m

# Center of mass [m]
geometry_msgs/Vector3 com

# Inertia Tensor [kg-m^2]
#     | ixx ixy ixz |
# I = | ixy iyy iyz |
#     | ixz iyz izz |
float64 ixx
float64 ixy
float64 ixz
float64 iyy
float64 iyz
float64 izz

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
---
")



(provide :omnivelma_msgs/SetInertia "95e035d263d97e8c32424221cde3ffa8")


