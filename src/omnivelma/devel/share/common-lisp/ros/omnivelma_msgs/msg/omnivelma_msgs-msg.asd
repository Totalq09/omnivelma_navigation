
(cl:in-package :asdf)

(defsystem "omnivelma_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Encoders" :depends-on ("_package_Encoders"))
    (:file "_package_Encoders" :depends-on ("_package"))
    (:file "EncodersStamped" :depends-on ("_package_EncodersStamped"))
    (:file "_package_EncodersStamped" :depends-on ("_package"))
    (:file "Relative" :depends-on ("_package_Relative"))
    (:file "_package_Relative" :depends-on ("_package"))
    (:file "RelativeStamped" :depends-on ("_package_RelativeStamped"))
    (:file "_package_RelativeStamped" :depends-on ("_package"))
    (:file "Vels" :depends-on ("_package_Vels"))
    (:file "_package_Vels" :depends-on ("_package"))
  ))