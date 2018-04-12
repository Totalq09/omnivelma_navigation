# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "omnivelma_msgs: 5 messages, 2 services")

set(MSG_I_FLAGS "-Iomnivelma_msgs:/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(omnivelma_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg" NAME_WE)
add_custom_target(_omnivelma_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "omnivelma_msgs" "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg" "omnivelma_msgs/Vels"
)

get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg" NAME_WE)
add_custom_target(_omnivelma_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "omnivelma_msgs" "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg" ""
)

get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/EncodersStamped.msg" NAME_WE)
add_custom_target(_omnivelma_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "omnivelma_msgs" "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/EncodersStamped.msg" "omnivelma_msgs/Encoders:std_msgs/Header:omnivelma_msgs/Vels"
)

get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetInertia.srv" NAME_WE)
add_custom_target(_omnivelma_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "omnivelma_msgs" "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetInertia.srv" "geometry_msgs/Inertia:geometry_msgs/Vector3"
)

get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/RelativeStamped.msg" NAME_WE)
add_custom_target(_omnivelma_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "omnivelma_msgs" "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/RelativeStamped.msg" "omnivelma_msgs/Relative:std_msgs/Header"
)

get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg" NAME_WE)
add_custom_target(_omnivelma_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "omnivelma_msgs" "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg" ""
)

get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetFriction.srv" NAME_WE)
add_custom_target(_omnivelma_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "omnivelma_msgs" "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetFriction.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_cpp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/EncodersStamped.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_cpp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_cpp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/RelativeStamped.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_cpp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omnivelma_msgs
)

### Generating Services
_generate_srv_cpp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetFriction.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omnivelma_msgs
)
_generate_srv_cpp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetInertia.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Inertia.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omnivelma_msgs
)

### Generating Module File
_generate_module_cpp(omnivelma_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omnivelma_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(omnivelma_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(omnivelma_msgs_generate_messages omnivelma_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_cpp _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_cpp _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/EncodersStamped.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_cpp _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetInertia.srv" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_cpp _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/RelativeStamped.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_cpp _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_cpp _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetFriction.srv" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_cpp _omnivelma_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(omnivelma_msgs_gencpp)
add_dependencies(omnivelma_msgs_gencpp omnivelma_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS omnivelma_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_eus(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/EncodersStamped.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_eus(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_eus(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/RelativeStamped.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_eus(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/omnivelma_msgs
)

### Generating Services
_generate_srv_eus(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetFriction.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/omnivelma_msgs
)
_generate_srv_eus(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetInertia.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Inertia.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/omnivelma_msgs
)

### Generating Module File
_generate_module_eus(omnivelma_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/omnivelma_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(omnivelma_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(omnivelma_msgs_generate_messages omnivelma_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_eus _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_eus _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/EncodersStamped.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_eus _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetInertia.srv" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_eus _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/RelativeStamped.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_eus _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_eus _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetFriction.srv" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_eus _omnivelma_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(omnivelma_msgs_geneus)
add_dependencies(omnivelma_msgs_geneus omnivelma_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS omnivelma_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_lisp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/EncodersStamped.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_lisp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_lisp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/RelativeStamped.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_lisp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omnivelma_msgs
)

### Generating Services
_generate_srv_lisp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetFriction.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omnivelma_msgs
)
_generate_srv_lisp(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetInertia.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Inertia.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omnivelma_msgs
)

### Generating Module File
_generate_module_lisp(omnivelma_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omnivelma_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(omnivelma_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(omnivelma_msgs_generate_messages omnivelma_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_lisp _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_lisp _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/EncodersStamped.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_lisp _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetInertia.srv" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_lisp _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/RelativeStamped.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_lisp _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_lisp _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetFriction.srv" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_lisp _omnivelma_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(omnivelma_msgs_genlisp)
add_dependencies(omnivelma_msgs_genlisp omnivelma_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS omnivelma_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_nodejs(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/EncodersStamped.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_nodejs(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_nodejs(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/RelativeStamped.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_nodejs(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/omnivelma_msgs
)

### Generating Services
_generate_srv_nodejs(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetFriction.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/omnivelma_msgs
)
_generate_srv_nodejs(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetInertia.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Inertia.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/omnivelma_msgs
)

### Generating Module File
_generate_module_nodejs(omnivelma_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/omnivelma_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(omnivelma_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(omnivelma_msgs_generate_messages omnivelma_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_nodejs _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_nodejs _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/EncodersStamped.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_nodejs _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetInertia.srv" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_nodejs _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/RelativeStamped.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_nodejs _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_nodejs _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetFriction.srv" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_nodejs _omnivelma_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(omnivelma_msgs_gennodejs)
add_dependencies(omnivelma_msgs_gennodejs omnivelma_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS omnivelma_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_py(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/EncodersStamped.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_py(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_py(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/RelativeStamped.msg"
  "${MSG_I_FLAGS}"
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omnivelma_msgs
)
_generate_msg_py(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omnivelma_msgs
)

### Generating Services
_generate_srv_py(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetFriction.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omnivelma_msgs
)
_generate_srv_py(omnivelma_msgs
  "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetInertia.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Inertia.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omnivelma_msgs
)

### Generating Module File
_generate_module_py(omnivelma_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omnivelma_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(omnivelma_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(omnivelma_msgs_generate_messages omnivelma_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Encoders.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_py _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Relative.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_py _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/EncodersStamped.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_py _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetInertia.srv" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_py _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/RelativeStamped.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_py _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/msg/Vels.msg" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_py _omnivelma_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/pwalas1/catkin_pw/src/omnivelma/src/omnivelma_msgs/srv/SetFriction.srv" NAME_WE)
add_dependencies(omnivelma_msgs_generate_messages_py _omnivelma_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(omnivelma_msgs_genpy)
add_dependencies(omnivelma_msgs_genpy omnivelma_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS omnivelma_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omnivelma_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omnivelma_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(omnivelma_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(omnivelma_msgs_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/omnivelma_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/omnivelma_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(omnivelma_msgs_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(omnivelma_msgs_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omnivelma_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omnivelma_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(omnivelma_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(omnivelma_msgs_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/omnivelma_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/omnivelma_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(omnivelma_msgs_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(omnivelma_msgs_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omnivelma_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omnivelma_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omnivelma_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(omnivelma_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(omnivelma_msgs_generate_messages_py geometry_msgs_generate_messages_py)
endif()
