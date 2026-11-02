// This is a generated file - do not edit.
//
// Generated from Mumble.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Reject_RejectType extends $pb.ProtobufEnum {
  /// The rejection reason is unknown (details should be available
  /// in Reject.reason).
  static const Reject_RejectType None =
      Reject_RejectType._(0, _omitEnumNames ? '' : 'None');

  /// The client attempted to connect with an incompatible version.
  static const Reject_RejectType WrongVersion =
      Reject_RejectType._(1, _omitEnumNames ? '' : 'WrongVersion');

  /// The user name supplied by the client was invalid.
  static const Reject_RejectType InvalidUsername =
      Reject_RejectType._(2, _omitEnumNames ? '' : 'InvalidUsername');

  /// The client attempted to authenticate as a user with a password but it
  /// was wrong.
  static const Reject_RejectType WrongUserPW =
      Reject_RejectType._(3, _omitEnumNames ? '' : 'WrongUserPW');

  /// The client attempted to connect to a passworded server but the password
  /// was wrong.
  static const Reject_RejectType WrongServerPW =
      Reject_RejectType._(4, _omitEnumNames ? '' : 'WrongServerPW');

  /// Supplied username is already in use.
  static const Reject_RejectType UsernameInUse =
      Reject_RejectType._(5, _omitEnumNames ? '' : 'UsernameInUse');

  /// Server is currently full and cannot accept more users.
  static const Reject_RejectType ServerFull =
      Reject_RejectType._(6, _omitEnumNames ? '' : 'ServerFull');

  /// The user did not provide a certificate but one is required.
  static const Reject_RejectType NoCertificate =
      Reject_RejectType._(7, _omitEnumNames ? '' : 'NoCertificate');
  static const Reject_RejectType AuthenticatorFail =
      Reject_RejectType._(8, _omitEnumNames ? '' : 'AuthenticatorFail');

  /// The server is currently not accepting new connections
  static const Reject_RejectType NoNewConnections =
      Reject_RejectType._(9, _omitEnumNames ? '' : 'NoNewConnections');

  static const $core.List<Reject_RejectType> values = <Reject_RejectType>[
    None,
    WrongVersion,
    InvalidUsername,
    WrongUserPW,
    WrongServerPW,
    UsernameInUse,
    ServerFull,
    NoCertificate,
    AuthenticatorFail,
    NoNewConnections,
  ];

  static final $core.List<Reject_RejectType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 9);
  static Reject_RejectType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Reject_RejectType._(super.value, super.name);
}

class PermissionDenied_DenyType extends $pb.ProtobufEnum {
  /// Operation denied for other reason, see reason field.
  static const PermissionDenied_DenyType Text =
      PermissionDenied_DenyType._(0, _omitEnumNames ? '' : 'Text');

  /// Permissions were denied.
  static const PermissionDenied_DenyType Permission =
      PermissionDenied_DenyType._(1, _omitEnumNames ? '' : 'Permission');

  /// Cannot modify SuperUser.
  static const PermissionDenied_DenyType SuperUser =
      PermissionDenied_DenyType._(2, _omitEnumNames ? '' : 'SuperUser');

  /// Invalid channel name.
  static const PermissionDenied_DenyType ChannelName =
      PermissionDenied_DenyType._(3, _omitEnumNames ? '' : 'ChannelName');

  /// Text message too long.
  static const PermissionDenied_DenyType TextTooLong =
      PermissionDenied_DenyType._(4, _omitEnumNames ? '' : 'TextTooLong');

  /// The flux capacitor was spelled wrong.
  static const PermissionDenied_DenyType H9K =
      PermissionDenied_DenyType._(5, _omitEnumNames ? '' : 'H9K');

  /// Operation not permitted in temporary channel.
  static const PermissionDenied_DenyType TemporaryChannel =
      PermissionDenied_DenyType._(6, _omitEnumNames ? '' : 'TemporaryChannel');

  /// Operation requires certificate.
  static const PermissionDenied_DenyType MissingCertificate =
      PermissionDenied_DenyType._(
          7, _omitEnumNames ? '' : 'MissingCertificate');

  /// Invalid username.
  static const PermissionDenied_DenyType UserName =
      PermissionDenied_DenyType._(8, _omitEnumNames ? '' : 'UserName');

  /// Channel is full.
  static const PermissionDenied_DenyType ChannelFull =
      PermissionDenied_DenyType._(9, _omitEnumNames ? '' : 'ChannelFull');

  /// Channels are nested too deeply.
  static const PermissionDenied_DenyType NestingLimit =
      PermissionDenied_DenyType._(10, _omitEnumNames ? '' : 'NestingLimit');

  /// Maximum channel count reached.
  static const PermissionDenied_DenyType ChannelCountLimit =
      PermissionDenied_DenyType._(
          11, _omitEnumNames ? '' : 'ChannelCountLimit');

  /// Amount of listener objects for this channel has been reached
  static const PermissionDenied_DenyType ChannelListenerLimit =
      PermissionDenied_DenyType._(
          12, _omitEnumNames ? '' : 'ChannelListenerLimit');

  /// Amount of listener proxies for the user has been reached
  static const PermissionDenied_DenyType UserListenerLimit =
      PermissionDenied_DenyType._(
          13, _omitEnumNames ? '' : 'UserListenerLimit');

  static const $core.List<PermissionDenied_DenyType> values =
      <PermissionDenied_DenyType>[
    Text,
    Permission,
    SuperUser,
    ChannelName,
    TextTooLong,
    H9K,
    TemporaryChannel,
    MissingCertificate,
    UserName,
    ChannelFull,
    NestingLimit,
    ChannelCountLimit,
    ChannelListenerLimit,
    UserListenerLimit,
  ];

  static final $core.List<PermissionDenied_DenyType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 13);
  static PermissionDenied_DenyType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PermissionDenied_DenyType._(super.value, super.name);
}

class ContextActionModify_Context extends $pb.ProtobufEnum {
  /// Action is applicable to the server.
  static const ContextActionModify_Context Server =
      ContextActionModify_Context._(1, _omitEnumNames ? '' : 'Server');

  /// Action can target a Channel.
  static const ContextActionModify_Context Channel =
      ContextActionModify_Context._(2, _omitEnumNames ? '' : 'Channel');

  /// Action can target a User.
  static const ContextActionModify_Context User =
      ContextActionModify_Context._(4, _omitEnumNames ? '' : 'User');

  static const $core.List<ContextActionModify_Context> values =
      <ContextActionModify_Context>[
    Server,
    Channel,
    User,
  ];

  static final $core.Map<$core.int, ContextActionModify_Context> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ContextActionModify_Context? valueOf($core.int value) =>
      _byValue[value];

  const ContextActionModify_Context._(super.value, super.name);
}

class ContextActionModify_Operation extends $pb.ProtobufEnum {
  static const ContextActionModify_Operation Add =
      ContextActionModify_Operation._(0, _omitEnumNames ? '' : 'Add');
  static const ContextActionModify_Operation Remove =
      ContextActionModify_Operation._(1, _omitEnumNames ? '' : 'Remove');

  static const $core.List<ContextActionModify_Operation> values =
      <ContextActionModify_Operation>[
    Add,
    Remove,
  ];

  static final $core.List<ContextActionModify_Operation?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static ContextActionModify_Operation? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ContextActionModify_Operation._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
