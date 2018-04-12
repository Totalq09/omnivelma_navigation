
(cl:in-package :asdf)

(defsystem "omnivelma_msgs-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "SetFriction" :depends-on ("_package_SetFriction"))
    (:file "_package_SetFriction" :depends-on ("_package"))
    (:file "SetInertia" :depends-on ("_package_SetInertia"))
    (:file "_package_SetInertia" :depends-on ("_package"))
  ))