// Auto-generated. Do not edit!

// (in-package omnivelma_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Vels = require('./Vels.js');

//-----------------------------------------------------------

class Encoders {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.velocity = null;
      this.angle = null;
    }
    else {
      if (initObj.hasOwnProperty('velocity')) {
        this.velocity = initObj.velocity
      }
      else {
        this.velocity = new Vels();
      }
      if (initObj.hasOwnProperty('angle')) {
        this.angle = initObj.angle
      }
      else {
        this.angle = new Vels();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Encoders
    // Serialize message field [velocity]
    bufferOffset = Vels.serialize(obj.velocity, buffer, bufferOffset);
    // Serialize message field [angle]
    bufferOffset = Vels.serialize(obj.angle, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Encoders
    let len;
    let data = new Encoders(null);
    // Deserialize message field [velocity]
    data.velocity = Vels.deserialize(buffer, bufferOffset);
    // Deserialize message field [angle]
    data.angle = Vels.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 64;
  }

  static datatype() {
    // Returns string type for a message object
    return 'omnivelma_msgs/Encoders';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a14e6d34d7cb73a32c3f00a409af72f0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    omnivelma_msgs/Vels velocity
    omnivelma_msgs/Vels angle
    
    ================================================================================
    MSG: omnivelma_msgs/Vels
    float64 fr
    float64 fl
    float64 rl
    float64 rr
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Encoders(null);
    if (msg.velocity !== undefined) {
      resolved.velocity = Vels.Resolve(msg.velocity)
    }
    else {
      resolved.velocity = new Vels()
    }

    if (msg.angle !== undefined) {
      resolved.angle = Vels.Resolve(msg.angle)
    }
    else {
      resolved.angle = new Vels()
    }

    return resolved;
    }
};

module.exports = Encoders;
