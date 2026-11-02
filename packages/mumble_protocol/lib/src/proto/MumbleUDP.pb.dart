// This is a generated file - do not edit.
//
// Generated from MumbleUDP.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

enum Audio_Header { target, context, notSet }

class Audio extends $pb.GeneratedMessage {
  factory Audio({
    $core.int? target,
    $core.int? context,
    $core.int? senderSession,
    $fixnum.Int64? frameNumber,
    $core.List<$core.int>? opusData,
    $core.Iterable<$core.double>? positionalData,
    $core.double? volumeAdjustment,
    $core.bool? isTerminator,
  }) {
    final result = Audio._();
    if (target != null) result.target = target;
    if (context != null) result.context = context;
    if (senderSession != null) result.senderSession = senderSession;
    if (frameNumber != null) result.frameNumber = frameNumber;
    if (opusData != null) result.opusData = opusData;
    if (positionalData != null) result.positionalData.addAll(positionalData);
    if (volumeAdjustment != null) result.volumeAdjustment = volumeAdjustment;
    if (isTerminator != null) result.isTerminator = isTerminator;
    return result;
  }

  Audio._();

  factory Audio.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Audio()..mergeFromBuffer(data, registry);
  factory Audio.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Audio()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Audio_Header> _Audio_HeaderByTag = {
    1: Audio_Header.target,
    2: Audio_Header.context,
    0: Audio_Header.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Audio',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleUDP'),
      createEmptyInstance: Audio.$_createMessage)
    ..oo(0, [1, 2])
    ..aI(1, _omitFieldNames ? '' : 'target', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'context', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'senderSession',
        fieldType: $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'frameNumber', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(
        5, _omitFieldNames ? '' : 'opusData', $pb.PbFieldType.OY)
    ..p<$core.double>(
        6, _omitFieldNames ? '' : 'positionalData', $pb.PbFieldType.KF)
    ..aD(7, _omitFieldNames ? '' : 'volumeAdjustment',
        fieldType: $pb.PbFieldType.OF)
    ..aOB(16, _omitFieldNames ? '' : 'isTerminator')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Audio clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Audio copyWith(void Function(Audio) updates) =>
      super.copyWith((message) => updates(message as Audio)) as Audio;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Audio() / Audio.new instead')
  static Audio create() => Audio._();
  static $pb.GeneratedMessage $_createMessage() => Audio._();
  @$core.override
  Audio createEmptyInstance() => Audio._();
  @$core.pragma('dart2js:noInline')
  static Audio getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Audio>(Audio.$_createMessage);
  static Audio? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  Audio_Header whichHeader() => _Audio_HeaderByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearHeader() => $_clearField($_whichOneof(0));

  /// When this audio is sent by the client to the server, this is set to the target of the audio data. This target
  /// is a number in the range [0, 2^{32} - 1], where 0 means "normal talking", 2^{5} - 1 means "server loopback"
  /// and all other targets are understood as shout/whisper targets that have previously been registered via a
  /// VoiceTarget message (via TCP).
  @$pb.TagNumber(1)
  $core.int get target => $_getIZ(0);
  @$pb.TagNumber(1)
  set target($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTarget() => $_has(0);
  @$pb.TagNumber(1)
  void clearTarget() => $_clearField(1);

  /// When this audio is sent by the server to the client, this indicates the context in which the audio has been sent.
  /// 0: Normal speech
  /// 1: Shout to channel
  /// 2: Whisper to user
  /// 3: Received via channel listener
  @$pb.TagNumber(2)
  $core.int get context => $_getIZ(1);
  @$pb.TagNumber(2)
  set context($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContext() => $_has(1);
  @$pb.TagNumber(2)
  void clearContext() => $_clearField(2);

  /// The session of the client (sender) this audio was originally sent from. This field is not required when sending
  /// audio to the server, but will always be set when receiving audio from the server.
  @$pb.TagNumber(3)
  $core.int get senderSession => $_getIZ(2);
  @$pb.TagNumber(3)
  set senderSession($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSenderSession() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderSession() => $_clearField(3);

  /// The number of the first contained audio frame (indicating the position of that frame in the overall audio stream)
  @$pb.TagNumber(4)
  $fixnum.Int64 get frameNumber => $_getI64(3);
  @$pb.TagNumber(4)
  set frameNumber($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFrameNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrameNumber() => $_clearField(4);

  /// The actual voice data payload in the Opus format.
  @$pb.TagNumber(5)
  $core.List<$core.int> get opusData => $_getN(4);
  @$pb.TagNumber(5)
  set opusData($core.List<$core.int> value) => $_setBytes(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOpusData() => $_has(4);
  @$pb.TagNumber(5)
  void clearOpusData() => $_clearField(5);

  /// Optional positional data indicating the speaker's position in a virtual world (in meters). This "list" is really
  /// expected to be an array of size 3 containing the X, Y and Z coordinates of the position (in that order).
  @$pb.TagNumber(6)
  $pb.PbList<$core.double> get positionalData => $_getList(5);

  /// A volume adjustment determined by the server for this audio packet. It is up to the client to apply this adjustment to
  /// the resulting audio (or not). Note: A value of 0 means that this field is unset.
  @$pb.TagNumber(7)
  $core.double get volumeAdjustment => $_getN(6);
  @$pb.TagNumber(7)
  set volumeAdjustment($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVolumeAdjustment() => $_has(6);
  @$pb.TagNumber(7)
  void clearVolumeAdjustment() => $_clearField(7);

  /// A flag indicating whether this audio packet represents the end of transmission for the current audio stream
  @$pb.TagNumber(16)
  $core.bool get isTerminator => $_getBF(7);
  @$pb.TagNumber(16)
  set isTerminator($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(16)
  $core.bool hasIsTerminator() => $_has(7);
  @$pb.TagNumber(16)
  void clearIsTerminator() => $_clearField(16);
}

/// *
///  Ping message for checking UDP connectivity (and roundtrip ping) and potentially obtaining further server
///  details (e.g. version).
class Ping extends $pb.GeneratedMessage {
  factory Ping({
    $fixnum.Int64? timestamp,
    $core.bool? requestExtendedInformation,
    $fixnum.Int64? serverVersionV2,
    $core.int? userCount,
    $core.int? maxUserCount,
    $core.int? maxBandwidthPerUser,
  }) {
    final result = Ping._();
    if (timestamp != null) result.timestamp = timestamp;
    if (requestExtendedInformation != null)
      result.requestExtendedInformation = requestExtendedInformation;
    if (serverVersionV2 != null) result.serverVersionV2 = serverVersionV2;
    if (userCount != null) result.userCount = userCount;
    if (maxUserCount != null) result.maxUserCount = maxUserCount;
    if (maxBandwidthPerUser != null)
      result.maxBandwidthPerUser = maxBandwidthPerUser;
    return result;
  }

  Ping._();

  factory Ping.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Ping()..mergeFromBuffer(data, registry);
  factory Ping.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Ping()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Ping',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleUDP'),
      createEmptyInstance: Ping.$_createMessage)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(2, _omitFieldNames ? '' : 'requestExtendedInformation')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'serverVersionV2', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aI(4, _omitFieldNames ? '' : 'userCount', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'maxUserCount',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'maxBandwidthPerUser',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Ping clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Ping copyWith(void Function(Ping) updates) =>
      super.copyWith((message) => updates(message as Ping)) as Ping;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Ping() / Ping.new instead')
  static Ping create() => Ping._();
  static $pb.GeneratedMessage $_createMessage() => Ping._();
  @$core.override
  Ping createEmptyInstance() => Ping._();
  @$core.pragma('dart2js:noInline')
  static Ping getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Ping>(Ping.$_createMessage);
  static Ping? _defaultInstance;

  /// Timestamp as encoded by the client. A server is not supposed to attempt to decode or modify this field. Therefore,
  /// clients may choose an arbitrary format for this timestamp (as long as it fits into a uint64 field).
  @$pb.TagNumber(1)
  $fixnum.Int64 get timestamp => $_getI64(0);
  @$pb.TagNumber(1)
  set timestamp($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => $_clearField(1);

  /// A flag set by the sending client, if it wants to obtain additional information about the server.
  @$pb.TagNumber(2)
  $core.bool get requestExtendedInformation => $_getBF(1);
  @$pb.TagNumber(2)
  set requestExtendedInformation($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRequestExtendedInformation() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequestExtendedInformation() => $_clearField(2);

  /// The version of the server in the new version format.
  /// The new protobuf Ping packet introduced with 1.5 drops support for the legacy version format
  /// since both server and client have to support this new format.
  /// (See https://github.com/mumble-voip/mumble/issues/5827)
  @$pb.TagNumber(3)
  $fixnum.Int64 get serverVersionV2 => $_getI64(2);
  @$pb.TagNumber(3)
  set serverVersionV2($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasServerVersionV2() => $_has(2);
  @$pb.TagNumber(3)
  void clearServerVersionV2() => $_clearField(3);

  /// The amount of users currently connected to the server
  @$pb.TagNumber(4)
  $core.int get userCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set userCount($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserCount() => $_clearField(4);

  /// The maximum amount of users permitted on this server
  @$pb.TagNumber(5)
  $core.int get maxUserCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set maxUserCount($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMaxUserCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaxUserCount() => $_clearField(5);

  /// The maximum bandwidth each user is allowed to use for sending audio to the server
  @$pb.TagNumber(6)
  $core.int get maxBandwidthPerUser => $_getIZ(5);
  @$pb.TagNumber(6)
  set maxBandwidthPerUser($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMaxBandwidthPerUser() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxBandwidthPerUser() => $_clearField(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
