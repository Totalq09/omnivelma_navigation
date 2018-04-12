;; Auto-generated. Do not edit!


(when (boundp 'omnivelma_msgs::Vels)
  (if (not (find-package "OMNIVELMA_MSGS"))
    (make-package "OMNIVELMA_MSGS"))
  (shadow 'Vels (find-package "OMNIVELMA_MSGS")))
(unless (find-package "OMNIVELMA_MSGS::VELS")
  (make-package "OMNIVELMA_MSGS::VELS"))

(in-package "ROS")
;;//! \htmlinclude Vels.msg.html


(defclass omnivelma_msgs::Vels
  :super ros::object
  :slots (_fr _fl _rl _rr ))

(defmethod omnivelma_msgs::Vels
  (:init
   (&key
    ((:fr __fr) 0.0)
    ((:fl __fl) 0.0)
    ((:rl __rl) 0.0)
    ((:rr __rr) 0.0)
    )
   (send-super :init)
   (setq _fr (float __fr))
   (setq _fl (float __fl))
   (setq _rl (float __rl))
   (setq _rr (float __rr))
   self)
  (:fr
   (&optional __fr)
   (if __fr (setq _fr __fr)) _fr)
  (:fl
   (&optional __fl)
   (if __fl (setq _fl __fl)) _fl)
  (:rl
   (&optional __rl)
   (if __rl (setq _rl __rl)) _rl)
  (:rr
   (&optional __rr)
   (if __rr (setq _rr __rr)) _rr)
  (:serialization-length
   ()
   (+
    ;; float64 _fr
    8
    ;; float64 _fl
    8
    ;; float64 _rl
    8
    ;; float64 _rr
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _fr
       (sys::poke _fr (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _fl
       (sys::poke _fl (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _rl
       (sys::poke _rl (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _rr
       (sys::poke _rr (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _fr
     (setq _fr (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _fl
     (setq _fl (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _rl
     (setq _rl (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _rr
     (setq _rr (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get omnivelma_msgs::Vels :md5sum-) "d9241866e5fa52f8ff5c46fd7ab0776e")
(setf (get omnivelma_msgs::Vels :datatype-) "omnivelma_msgs/Vels")
(setf (get omnivelma_msgs::Vels :definition-)
      "float64 fr
float64 fl
float64 rl
float64 rr
")



(provide :omnivelma_msgs/Vels "d9241866e5fa52f8ff5c46fd7ab0776e")


