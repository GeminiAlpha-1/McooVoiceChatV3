// This is a generated file - do not edit.
//
// Generated from MumbleUDP.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use audioDescriptor instead')
const Audio$json = {
  '1': 'Audio',
  '2': [
    {'1': 'target', '3': 1, '4': 1, '5': 13, '9': 0, '10': 'target'},
    {'1': 'context', '3': 2, '4': 1, '5': 13, '9': 0, '10': 'context'},
    {'1': 'sender_session', '3': 3, '4': 1, '5': 13, '10': 'senderSession'},
    {'1': 'frame_number', '3': 4, '4': 1, '5': 4, '10': 'frameNumber'},
    {'1': 'opus_data', '3': 5, '4': 1, '5': 12, '10': 'opusData'},
    {'1': 'positional_data', '3': 6, '4': 3, '5': 2, '10': 'positionalData'},
    {
      '1': 'volume_adjustment',
      '3': 7,
      '4': 1,
      '5': 2,
      '10': 'volumeAdjustment'
    },
    {'1': 'is_terminator', '3': 16, '4': 1, '5': 8, '10': 'isTerminator'},
  ],
  '8': [
    {'1': 'Header'},
  ],
};

/// Descriptor for `Audio`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioDescriptor = $convert.base64Decode(
    'CgVBdWRpbxIYCgZ0YXJnZXQYASABKA1IAFIGdGFyZ2V0EhoKB2NvbnRleHQYAiABKA1IAFIHY2'
    '9udGV4dBIlCg5zZW5kZXJfc2Vzc2lvbhgDIAEoDVINc2VuZGVyU2Vzc2lvbhIhCgxmcmFtZV9u'
    'dW1iZXIYBCABKARSC2ZyYW1lTnVtYmVyEhsKCW9wdXNfZGF0YRgFIAEoDFIIb3B1c0RhdGESJw'
    'oPcG9zaXRpb25hbF9kYXRhGAYgAygCUg5wb3NpdGlvbmFsRGF0YRIrChF2b2x1bWVfYWRqdXN0'
    'bWVudBgHIAEoAlIQdm9sdW1lQWRqdXN0bWVudBIjCg1pc190ZXJtaW5hdG9yGBAgASgIUgxpc1'
    'Rlcm1pbmF0b3JCCAoGSGVhZGVy');

@$core.Deprecated('Use pingDescriptor instead')
const Ping$json = {
  '1': 'Ping',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 4, '10': 'timestamp'},
    {
      '1': 'request_extended_information',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'requestExtendedInformation'
    },
    {'1': 'server_version_v2', '3': 3, '4': 1, '5': 4, '10': 'serverVersionV2'},
    {'1': 'user_count', '3': 4, '4': 1, '5': 13, '10': 'userCount'},
    {'1': 'max_user_count', '3': 5, '4': 1, '5': 13, '10': 'maxUserCount'},
    {
      '1': 'max_bandwidth_per_user',
      '3': 6,
      '4': 1,
      '5': 13,
      '10': 'maxBandwidthPerUser'
    },
  ],
};

/// Descriptor for `Ping`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pingDescriptor = $convert.base64Decode(
    'CgRQaW5nEhwKCXRpbWVzdGFtcBgBIAEoBFIJdGltZXN0YW1wEkAKHHJlcXVlc3RfZXh0ZW5kZW'
    'RfaW5mb3JtYXRpb24YAiABKAhSGnJlcXVlc3RFeHRlbmRlZEluZm9ybWF0aW9uEioKEXNlcnZl'
    'cl92ZXJzaW9uX3YyGAMgASgEUg9zZXJ2ZXJWZXJzaW9uVjISHQoKdXNlcl9jb3VudBgEIAEoDV'
    'IJdXNlckNvdW50EiQKDm1heF91c2VyX2NvdW50GAUgASgNUgxtYXhVc2VyQ291bnQSMwoWbWF4'
    'X2JhbmR3aWR0aF9wZXJfdXNlchgGIAEoDVITbWF4QmFuZHdpZHRoUGVyVXNlcg==');
