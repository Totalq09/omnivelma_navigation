// Auto-generated. Do not edit!

// (in-package omnivelma_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class SetInertiaRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.base = null;
      this.front = null;
      this.wheel = null;
    }
    else {
      if (initObj.hasOwnProperty('base')) {
        this.base = initObj.base
      }
      else {
        this.base = new geometry_msgs.msg.Inertia();
      }
      if (initObj.hasOwnProperty('front')) {
        this.front = initObj.front
      }
      else {
        this.front = new geometry_msgs.msg.Inertia();
      }
      if (initObj.hasOwnProperty('wheel')) {
        this.wheel = initObj.wheel
      }
      else {
        this.wheel = new geometry_msgs.msg.Inertia();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetInertiaRequest
    // Serialize message field [base]
    bufferOffset = geometry_msgs.msg.Inertia.serialize(obj.base, buffer, bufferOffset);
    // Serialize message field [front]
    bufferOffset = geometry_msgs.msg.Inertia.serialize(obj.front, buffer, bufferOffset);
    // Serialize message field [wheel]
    bufferOffset = geometry_msgs.msg.Inertia.serialize(obj.wheel, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetInertiaRequest
    let len;
    let data = new SetInertiaRequest(null);
    // Deserialize message field [base]
    data.base = geometry_msgs.msg.Inertia.deserialize(buffer, bufferOffset);
    // Deserialize message field [front]
    data.front = geometry_msgs.msg.Inertia.deserialize(buffer, bufferOffset);
    // Deserialize message field [wheel]
    data.wheel = geometry_msgs.msg.Inertia.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 240;
  }

  static datatype() {
    // Returns string type for a service object
    return 'omnivelma_msgs/SetInertiaRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '95e035d263d97e8c32424221cde3ffa8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    geometry_msgs/Inertia base
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
    float64 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetInertiaRequest(null);
    if (msg.base !== undefined) {
      resolved.base = geometry_msgs.msg.Inertia.Resolve(msg.base)
    }
    else {
      resolved.base = new geometry_msgs.msg.Inertia()
    }

    if (msg.front !== undefined) {
      resolved.front = geometry_msgs.msg.Inertia.Resolve(msg.front)
    }
    else {
      resolved.front = new geometry_msgs.msg.Inertia()
    }

    if (msg.wheel !== undefined) {
      resolved.wheel = geometry_msgs.msg.Inertia.Resolve(msg.wheel)
    }
    else {
      resolved.wheel = new geometry_msgs.msg.Inertia()
    }

    return resolved;
    }
};

class SetInertiaResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetInertiaResponse
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetInertiaResponse
    let len;
    let data = new SetInertiaResponse(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'omnivelma_msgs/SetInertiaResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetInertiaResponse(null);
    return resolved;
    }
};

module.exports = {
  Request: SetInertiaRequest,
  Response: SetInertiaResponse,
  md5sum() { return '95e035d263d97e8c32424221cde3ffa8'; },
  datatype() { return 'omnivelma_msgs/SetInertia'; }
};
