// Auto-generated. Do not edit!

// (in-package omnivelma_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class SetFrictionRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.mu1 = null;
      this.mu2 = null;
    }
    else {
      if (initObj.hasOwnProperty('mu1')) {
        this.mu1 = initObj.mu1
      }
      else {
        this.mu1 = 0.0;
      }
      if (initObj.hasOwnProperty('mu2')) {
        this.mu2 = initObj.mu2
      }
      else {
        this.mu2 = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetFrictionRequest
    // Serialize message field [mu1]
    bufferOffset = _serializer.float64(obj.mu1, buffer, bufferOffset);
    // Serialize message field [mu2]
    bufferOffset = _serializer.float64(obj.mu2, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetFrictionRequest
    let len;
    let data = new SetFrictionRequest(null);
    // Deserialize message field [mu1]
    data.mu1 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [mu2]
    data.mu2 = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a service object
    return 'omnivelma_msgs/SetFrictionRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f4a6558102ac1181f82735851ff5553b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 mu1
    float64 mu2
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetFrictionRequest(null);
    if (msg.mu1 !== undefined) {
      resolved.mu1 = msg.mu1;
    }
    else {
      resolved.mu1 = 0.0
    }

    if (msg.mu2 !== undefined) {
      resolved.mu2 = msg.mu2;
    }
    else {
      resolved.mu2 = 0.0
    }

    return resolved;
    }
};

class SetFrictionResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetFrictionResponse
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetFrictionResponse
    let len;
    let data = new SetFrictionResponse(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'omnivelma_msgs/SetFrictionResponse';
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
    const resolved = new SetFrictionResponse(null);
    return resolved;
    }
};

module.exports = {
  Request: SetFrictionRequest,
  Response: SetFrictionResponse,
  md5sum() { return 'f4a6558102ac1181f82735851ff5553b'; },
  datatype() { return 'omnivelma_msgs/SetFriction'; }
};
