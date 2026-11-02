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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'Mumble.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'Mumble.pbenum.dart';

class Version extends $pb.GeneratedMessage {
  factory Version({
    $core.int? versionV1,
    $core.String? release,
    $core.String? os,
    $core.String? osVersion,
    $fixnum.Int64? versionV2,
  }) {
    final result = Version._();
    if (versionV1 != null) result.versionV1 = versionV1;
    if (release != null) result.release = release;
    if (os != null) result.os = os;
    if (osVersion != null) result.osVersion = osVersion;
    if (versionV2 != null) result.versionV2 = versionV2;
    return result;
  }

  Version._();

  factory Version.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Version()..mergeFromBuffer(data, registry);
  factory Version.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Version()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Version',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: Version.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'versionV1', fieldType: $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'release')
    ..aOS(3, _omitFieldNames ? '' : 'os')
    ..aOS(4, _omitFieldNames ? '' : 'osVersion')
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'versionV2', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Version clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Version copyWith(void Function(Version) updates) =>
      super.copyWith((message) => updates(message as Version)) as Version;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Version() / Version.new instead')
  static Version create() => Version._();
  static $pb.GeneratedMessage $_createMessage() => Version._();
  @$core.override
  Version createEmptyInstance() => Version._();
  @$core.pragma('dart2js:noInline')
  static Version getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Version>(Version.$_createMessage);
  static Version? _defaultInstance;

  /// Legacy version number format.
  @$pb.TagNumber(1)
  $core.int get versionV1 => $_getIZ(0);
  @$pb.TagNumber(1)
  set versionV1($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersionV1() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersionV1() => $_clearField(1);

  /// Client release name.
  @$pb.TagNumber(2)
  $core.String get release => $_getSZ(1);
  @$pb.TagNumber(2)
  set release($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRelease() => $_has(1);
  @$pb.TagNumber(2)
  void clearRelease() => $_clearField(2);

  /// Client OS name.
  @$pb.TagNumber(3)
  $core.String get os => $_getSZ(2);
  @$pb.TagNumber(3)
  set os($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOs() => $_has(2);
  @$pb.TagNumber(3)
  void clearOs() => $_clearField(3);

  /// Client OS version.
  @$pb.TagNumber(4)
  $core.String get osVersion => $_getSZ(3);
  @$pb.TagNumber(4)
  set osVersion($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOsVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearOsVersion() => $_clearField(4);

  /// New version number format.
  /// Necessary since patch level may exceed 255. (See https://github.com/mumble-voip/mumble/issues/5827)
  @$pb.TagNumber(5)
  $fixnum.Int64 get versionV2 => $_getI64(4);
  @$pb.TagNumber(5)
  set versionV2($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVersionV2() => $_has(4);
  @$pb.TagNumber(5)
  void clearVersionV2() => $_clearField(5);
}

/// Not used. Not even for tunneling UDP through TCP.
class UDPTunnel extends $pb.GeneratedMessage {
  factory UDPTunnel({
    $core.List<$core.int>? packet,
  }) {
    final result = UDPTunnel._();
    if (packet != null) result.packet = packet;
    return result;
  }

  UDPTunnel._();

  factory UDPTunnel.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UDPTunnel()..mergeFromBuffer(data, registry);
  factory UDPTunnel.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UDPTunnel()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UDPTunnel',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: UDPTunnel.$_createMessage)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'packet', $pb.PbFieldType.QY);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UDPTunnel clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UDPTunnel copyWith(void Function(UDPTunnel) updates) =>
      super.copyWith((message) => updates(message as UDPTunnel)) as UDPTunnel;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UDPTunnel() / UDPTunnel.new instead')
  static UDPTunnel create() => UDPTunnel._();
  static $pb.GeneratedMessage $_createMessage() => UDPTunnel._();
  @$core.override
  UDPTunnel createEmptyInstance() => UDPTunnel._();
  @$core.pragma('dart2js:noInline')
  static UDPTunnel getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UDPTunnel>(UDPTunnel.$_createMessage);
  static UDPTunnel? _defaultInstance;

  /// Not used.
  @$pb.TagNumber(1)
  $core.List<$core.int> get packet => $_getN(0);
  @$pb.TagNumber(1)
  set packet($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPacket() => $_has(0);
  @$pb.TagNumber(1)
  void clearPacket() => $_clearField(1);
}

/// Used by the client to send the authentication credentials to the server.
class Authenticate extends $pb.GeneratedMessage {
  factory Authenticate({
    $core.String? username,
    $core.String? password,
    $core.Iterable<$core.String>? tokens,
    $core.Iterable<$core.int>? celtVersions,
    $core.bool? opus,
    $core.int? clientType,
  }) {
    final result = Authenticate._();
    if (username != null) result.username = username;
    if (password != null) result.password = password;
    if (tokens != null) result.tokens.addAll(tokens);
    if (celtVersions != null) result.celtVersions.addAll(celtVersions);
    if (opus != null) result.opus = opus;
    if (clientType != null) result.clientType = clientType;
    return result;
  }

  Authenticate._();

  factory Authenticate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Authenticate()..mergeFromBuffer(data, registry);
  factory Authenticate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Authenticate()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Authenticate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: Authenticate.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..pPS(3, _omitFieldNames ? '' : 'tokens')
    ..p<$core.int>(4, _omitFieldNames ? '' : 'celtVersions', $pb.PbFieldType.P3)
    ..aOB(5, _omitFieldNames ? '' : 'opus')
    ..aI(6, _omitFieldNames ? '' : 'clientType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Authenticate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Authenticate copyWith(void Function(Authenticate) updates) =>
      super.copyWith((message) => updates(message as Authenticate))
          as Authenticate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Authenticate() / Authenticate.new instead')
  static Authenticate create() => Authenticate._();
  static $pb.GeneratedMessage $_createMessage() => Authenticate._();
  @$core.override
  Authenticate createEmptyInstance() => Authenticate._();
  @$core.pragma('dart2js:noInline')
  static Authenticate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Authenticate>(
          Authenticate.$_createMessage);
  static Authenticate? _defaultInstance;

  /// UTF-8 encoded username.
  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);

  /// Server or user password.
  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);

  /// Additional access tokens for server ACL groups.
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get tokens => $_getList(2);

  /// A list of CELT bitstream version constants supported by the client.
  @$pb.TagNumber(4)
  $pb.PbList<$core.int> get celtVersions => $_getList(3);

  @$pb.TagNumber(5)
  $core.bool get opus => $_getBF(4);
  @$pb.TagNumber(5)
  set opus($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOpus() => $_has(4);
  @$pb.TagNumber(5)
  void clearOpus() => $_clearField(5);

  /// 0 = REGULAR, 1 = BOT
  @$pb.TagNumber(6)
  $core.int get clientType => $_getIZ(5);
  @$pb.TagNumber(6)
  set clientType($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasClientType() => $_has(5);
  @$pb.TagNumber(6)
  void clearClientType() => $_clearField(6);
}

/// Sent by the client to notify the server that the client is still alive.
/// Server must reply to the packet with the same timestamp and its own
/// good/late/lost/resync numbers. None of the fields is strictly required.
class Ping extends $pb.GeneratedMessage {
  factory Ping({
    $fixnum.Int64? timestamp,
    $core.int? good,
    $core.int? late,
    $core.int? lost,
    $core.int? resync,
    $core.int? udpPackets,
    $core.int? tcpPackets,
    $core.double? udpPingAvg,
    $core.double? udpPingVar,
    $core.double? tcpPingAvg,
    $core.double? tcpPingVar,
  }) {
    final result = Ping._();
    if (timestamp != null) result.timestamp = timestamp;
    if (good != null) result.good = good;
    if (late != null) result.late = late;
    if (lost != null) result.lost = lost;
    if (resync != null) result.resync = resync;
    if (udpPackets != null) result.udpPackets = udpPackets;
    if (tcpPackets != null) result.tcpPackets = tcpPackets;
    if (udpPingAvg != null) result.udpPingAvg = udpPingAvg;
    if (udpPingVar != null) result.udpPingVar = udpPingVar;
    if (tcpPingAvg != null) result.tcpPingAvg = tcpPingAvg;
    if (tcpPingVar != null) result.tcpPingVar = tcpPingVar;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: Ping.$_createMessage)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aI(2, _omitFieldNames ? '' : 'good', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'late', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'lost', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'resync', fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'udpPackets', fieldType: $pb.PbFieldType.OU3)
    ..aI(7, _omitFieldNames ? '' : 'tcpPackets', fieldType: $pb.PbFieldType.OU3)
    ..aD(8, _omitFieldNames ? '' : 'udpPingAvg', fieldType: $pb.PbFieldType.OF)
    ..aD(9, _omitFieldNames ? '' : 'udpPingVar', fieldType: $pb.PbFieldType.OF)
    ..aD(10, _omitFieldNames ? '' : 'tcpPingAvg', fieldType: $pb.PbFieldType.OF)
    ..aD(11, _omitFieldNames ? '' : 'tcpPingVar', fieldType: $pb.PbFieldType.OF)
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

  /// Client timestamp. Server should not attempt to decode.
  @$pb.TagNumber(1)
  $fixnum.Int64 get timestamp => $_getI64(0);
  @$pb.TagNumber(1)
  set timestamp($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => $_clearField(1);

  /// The amount of good packets received.
  @$pb.TagNumber(2)
  $core.int get good => $_getIZ(1);
  @$pb.TagNumber(2)
  set good($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasGood() => $_has(1);
  @$pb.TagNumber(2)
  void clearGood() => $_clearField(2);

  /// The amount of late packets received.
  @$pb.TagNumber(3)
  $core.int get late => $_getIZ(2);
  @$pb.TagNumber(3)
  set late($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLate() => $_has(2);
  @$pb.TagNumber(3)
  void clearLate() => $_clearField(3);

  /// The amount of packets never received.
  @$pb.TagNumber(4)
  $core.int get lost => $_getIZ(3);
  @$pb.TagNumber(4)
  set lost($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLost() => $_has(3);
  @$pb.TagNumber(4)
  void clearLost() => $_clearField(4);

  /// The amount of nonce resyncs.
  @$pb.TagNumber(5)
  $core.int get resync => $_getIZ(4);
  @$pb.TagNumber(5)
  set resync($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasResync() => $_has(4);
  @$pb.TagNumber(5)
  void clearResync() => $_clearField(5);

  /// The total amount of UDP packets received.
  @$pb.TagNumber(6)
  $core.int get udpPackets => $_getIZ(5);
  @$pb.TagNumber(6)
  set udpPackets($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUdpPackets() => $_has(5);
  @$pb.TagNumber(6)
  void clearUdpPackets() => $_clearField(6);

  /// The total amount of TCP packets received.
  @$pb.TagNumber(7)
  $core.int get tcpPackets => $_getIZ(6);
  @$pb.TagNumber(7)
  set tcpPackets($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTcpPackets() => $_has(6);
  @$pb.TagNumber(7)
  void clearTcpPackets() => $_clearField(7);

  /// UDP ping average.
  @$pb.TagNumber(8)
  $core.double get udpPingAvg => $_getN(7);
  @$pb.TagNumber(8)
  set udpPingAvg($core.double value) => $_setFloat(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUdpPingAvg() => $_has(7);
  @$pb.TagNumber(8)
  void clearUdpPingAvg() => $_clearField(8);

  /// UDP ping variance.
  @$pb.TagNumber(9)
  $core.double get udpPingVar => $_getN(8);
  @$pb.TagNumber(9)
  set udpPingVar($core.double value) => $_setFloat(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUdpPingVar() => $_has(8);
  @$pb.TagNumber(9)
  void clearUdpPingVar() => $_clearField(9);

  /// TCP ping average.
  @$pb.TagNumber(10)
  $core.double get tcpPingAvg => $_getN(9);
  @$pb.TagNumber(10)
  set tcpPingAvg($core.double value) => $_setFloat(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTcpPingAvg() => $_has(9);
  @$pb.TagNumber(10)
  void clearTcpPingAvg() => $_clearField(10);

  /// TCP ping variance.
  @$pb.TagNumber(11)
  $core.double get tcpPingVar => $_getN(10);
  @$pb.TagNumber(11)
  set tcpPingVar($core.double value) => $_setFloat(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTcpPingVar() => $_has(10);
  @$pb.TagNumber(11)
  void clearTcpPingVar() => $_clearField(11);
}

/// Sent by the server when it rejects the user connection.
class Reject extends $pb.GeneratedMessage {
  factory Reject({
    Reject_RejectType? type,
    $core.String? reason,
  }) {
    final result = Reject._();
    if (type != null) result.type = type;
    if (reason != null) result.reason = reason;
    return result;
  }

  Reject._();

  factory Reject.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Reject()..mergeFromBuffer(data, registry);
  factory Reject.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Reject()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Reject',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: Reject.$_createMessage)
    ..aE<Reject_RejectType>(1, _omitFieldNames ? '' : 'type',
        enumValues: Reject_RejectType.values)
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Reject clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Reject copyWith(void Function(Reject) updates) =>
      super.copyWith((message) => updates(message as Reject)) as Reject;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Reject() / Reject.new instead')
  static Reject create() => Reject._();
  static $pb.GeneratedMessage $_createMessage() => Reject._();
  @$core.override
  Reject createEmptyInstance() => Reject._();
  @$core.pragma('dart2js:noInline')
  static Reject getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Reject>(Reject.$_createMessage);
  static Reject? _defaultInstance;

  /// Rejection type.
  @$pb.TagNumber(1)
  Reject_RejectType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(Reject_RejectType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  /// Human readable rejection reason.
  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

/// ServerSync message is sent by the server when it has authenticated the user
/// and finished synchronizing the server state.
class ServerSync extends $pb.GeneratedMessage {
  factory ServerSync({
    $core.int? session,
    $core.int? maxBandwidth,
    $core.String? welcomeText,
    $fixnum.Int64? permissions,
  }) {
    final result = ServerSync._();
    if (session != null) result.session = session;
    if (maxBandwidth != null) result.maxBandwidth = maxBandwidth;
    if (welcomeText != null) result.welcomeText = welcomeText;
    if (permissions != null) result.permissions = permissions;
    return result;
  }

  ServerSync._();

  factory ServerSync.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ServerSync()..mergeFromBuffer(data, registry);
  factory ServerSync.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ServerSync()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServerSync',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: ServerSync.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'session', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'maxBandwidth',
        fieldType: $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'welcomeText')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'permissions', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServerSync clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServerSync copyWith(void Function(ServerSync) updates) =>
      super.copyWith((message) => updates(message as ServerSync)) as ServerSync;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ServerSync() / ServerSync.new instead')
  static ServerSync create() => ServerSync._();
  static $pb.GeneratedMessage $_createMessage() => ServerSync._();
  @$core.override
  ServerSync createEmptyInstance() => ServerSync._();
  @$core.pragma('dart2js:noInline')
  static ServerSync getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServerSync>(ServerSync.$_createMessage);
  static ServerSync? _defaultInstance;

  /// The session of the current user.
  @$pb.TagNumber(1)
  $core.int get session => $_getIZ(0);
  @$pb.TagNumber(1)
  set session($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => $_clearField(1);

  /// Maximum bandwidth that the user should use.
  @$pb.TagNumber(2)
  $core.int get maxBandwidth => $_getIZ(1);
  @$pb.TagNumber(2)
  set maxBandwidth($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxBandwidth() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxBandwidth() => $_clearField(2);

  /// Server welcome text.
  @$pb.TagNumber(3)
  $core.String get welcomeText => $_getSZ(2);
  @$pb.TagNumber(3)
  set welcomeText($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWelcomeText() => $_has(2);
  @$pb.TagNumber(3)
  void clearWelcomeText() => $_clearField(3);

  /// Current user permissions in the root channel.
  /// Note: The permissions data type usually is uin32 (e.g. in PermissionQuery and PermissionDenied messages). Here
  /// it is uint64 because of an oversight in the past. Nonetheless it should never exceed the uin32 range.
  /// See also: https://github.com/mumble-voip/mumble/issues/5139
  @$pb.TagNumber(4)
  $fixnum.Int64 get permissions => $_getI64(3);
  @$pb.TagNumber(4)
  set permissions($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPermissions() => $_has(3);
  @$pb.TagNumber(4)
  void clearPermissions() => $_clearField(4);
}

/// Sent by the client when it wants a channel removed. Sent by the server when
/// a channel has been removed and clients should be notified.
class ChannelRemove extends $pb.GeneratedMessage {
  factory ChannelRemove({
    $core.int? channelId,
  }) {
    final result = ChannelRemove._();
    if (channelId != null) result.channelId = channelId;
    return result;
  }

  ChannelRemove._();

  factory ChannelRemove.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChannelRemove()..mergeFromBuffer(data, registry);
  factory ChannelRemove.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChannelRemove()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChannelRemove',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: ChannelRemove.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'channelId', fieldType: $pb.PbFieldType.QU3);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelRemove clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelRemove copyWith(void Function(ChannelRemove) updates) =>
      super.copyWith((message) => updates(message as ChannelRemove))
          as ChannelRemove;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChannelRemove() / ChannelRemove.new instead')
  static ChannelRemove create() => ChannelRemove._();
  static $pb.GeneratedMessage $_createMessage() => ChannelRemove._();
  @$core.override
  ChannelRemove createEmptyInstance() => ChannelRemove._();
  @$core.pragma('dart2js:noInline')
  static ChannelRemove getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelRemove>(
          ChannelRemove.$_createMessage);
  static ChannelRemove? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get channelId => $_getIZ(0);
  @$pb.TagNumber(1)
  set channelId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);
}

/// Used to communicate channel properties between the client and the server.
/// Sent by the server during the login process or when channel properties are
/// updated. Client may use this message to update said channel properties.
class ChannelState extends $pb.GeneratedMessage {
  factory ChannelState({
    $core.int? channelId,
    $core.int? parent,
    $core.String? name,
    $core.Iterable<$core.int>? links,
    $core.String? description,
    $core.Iterable<$core.int>? linksAdd,
    $core.Iterable<$core.int>? linksRemove,
    $core.bool? temporary,
    $core.int? position,
    $core.List<$core.int>? descriptionHash,
    $core.int? maxUsers,
    $core.bool? isEnterRestricted,
    $core.bool? canEnter,
  }) {
    final result = ChannelState._();
    if (channelId != null) result.channelId = channelId;
    if (parent != null) result.parent = parent;
    if (name != null) result.name = name;
    if (links != null) result.links.addAll(links);
    if (description != null) result.description = description;
    if (linksAdd != null) result.linksAdd.addAll(linksAdd);
    if (linksRemove != null) result.linksRemove.addAll(linksRemove);
    if (temporary != null) result.temporary = temporary;
    if (position != null) result.position = position;
    if (descriptionHash != null) result.descriptionHash = descriptionHash;
    if (maxUsers != null) result.maxUsers = maxUsers;
    if (isEnterRestricted != null) result.isEnterRestricted = isEnterRestricted;
    if (canEnter != null) result.canEnter = canEnter;
    return result;
  }

  ChannelState._();

  factory ChannelState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChannelState()..mergeFromBuffer(data, registry);
  factory ChannelState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChannelState()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChannelState',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: ChannelState.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'channelId', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'parent', fieldType: $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..p<$core.int>(4, _omitFieldNames ? '' : 'links', $pb.PbFieldType.PU3)
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..p<$core.int>(6, _omitFieldNames ? '' : 'linksAdd', $pb.PbFieldType.PU3)
    ..p<$core.int>(7, _omitFieldNames ? '' : 'linksRemove', $pb.PbFieldType.PU3)
    ..aOB(8, _omitFieldNames ? '' : 'temporary')
    ..aI(9, _omitFieldNames ? '' : 'position')
    ..a<$core.List<$core.int>>(
        10, _omitFieldNames ? '' : 'descriptionHash', $pb.PbFieldType.OY)
    ..aI(11, _omitFieldNames ? '' : 'maxUsers', fieldType: $pb.PbFieldType.OU3)
    ..aOB(12, _omitFieldNames ? '' : 'isEnterRestricted')
    ..aOB(13, _omitFieldNames ? '' : 'canEnter')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelState copyWith(void Function(ChannelState) updates) =>
      super.copyWith((message) => updates(message as ChannelState))
          as ChannelState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChannelState() / ChannelState.new instead')
  static ChannelState create() => ChannelState._();
  static $pb.GeneratedMessage $_createMessage() => ChannelState._();
  @$core.override
  ChannelState createEmptyInstance() => ChannelState._();
  @$core.pragma('dart2js:noInline')
  static ChannelState getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelState>(
          ChannelState.$_createMessage);
  static ChannelState? _defaultInstance;

  /// Unique ID for the channel within the server.
  @$pb.TagNumber(1)
  $core.int get channelId => $_getIZ(0);
  @$pb.TagNumber(1)
  set channelId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// channel_id of the parent channel.
  @$pb.TagNumber(2)
  $core.int get parent => $_getIZ(1);
  @$pb.TagNumber(2)
  set parent($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasParent() => $_has(1);
  @$pb.TagNumber(2)
  void clearParent() => $_clearField(2);

  /// UTF-8 encoded channel name.
  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  /// A collection of channel id values of the linked channels. Absent during
  /// the first channel listing.
  @$pb.TagNumber(4)
  $pb.PbList<$core.int> get links => $_getList(3);

  /// UTF-8 encoded channel description. Only if the description is less than
  /// 128 bytes
  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  /// A collection of channel_id values that should be added to links.
  @$pb.TagNumber(6)
  $pb.PbList<$core.int> get linksAdd => $_getList(5);

  /// A collection of channel_id values that should be removed from links.
  @$pb.TagNumber(7)
  $pb.PbList<$core.int> get linksRemove => $_getList(6);

  /// True if the channel is temporary.
  @$pb.TagNumber(8)
  $core.bool get temporary => $_getBF(7);
  @$pb.TagNumber(8)
  set temporary($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTemporary() => $_has(7);
  @$pb.TagNumber(8)
  void clearTemporary() => $_clearField(8);

  /// Position weight to tweak the channel position in the channel list.
  @$pb.TagNumber(9)
  $core.int get position => $_getIZ(8);
  @$pb.TagNumber(9)
  set position($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPosition() => $_has(8);
  @$pb.TagNumber(9)
  void clearPosition() => $_clearField(9);

  /// SHA1 hash of the description if the description is 128 bytes or more.
  @$pb.TagNumber(10)
  $core.List<$core.int> get descriptionHash => $_getN(9);
  @$pb.TagNumber(10)
  set descriptionHash($core.List<$core.int> value) => $_setBytes(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDescriptionHash() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescriptionHash() => $_clearField(10);

  /// Maximum number of users allowed in the channel. If this value is zero,
  /// the maximum number of users allowed in the channel is given by the
  /// server's "usersperchannel" setting.
  @$pb.TagNumber(11)
  $core.int get maxUsers => $_getIZ(10);
  @$pb.TagNumber(11)
  set maxUsers($core.int value) => $_setUnsignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMaxUsers() => $_has(10);
  @$pb.TagNumber(11)
  void clearMaxUsers() => $_clearField(11);

  /// Whether this channel has enter restrictions (ACL denying ENTER) set
  @$pb.TagNumber(12)
  $core.bool get isEnterRestricted => $_getBF(11);
  @$pb.TagNumber(12)
  set isEnterRestricted($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsEnterRestricted() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsEnterRestricted() => $_clearField(12);

  /// Whether the receiver of this msg is considered to be able to enter this channel
  @$pb.TagNumber(13)
  $core.bool get canEnter => $_getBF(12);
  @$pb.TagNumber(13)
  set canEnter($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCanEnter() => $_has(12);
  @$pb.TagNumber(13)
  void clearCanEnter() => $_clearField(13);
}

/// Used to communicate user leaving or being kicked. May be sent by the client
/// when it attempts to kick a user. Sent by the server when it informs the
/// clients that a user is not present anymore.
class UserRemove extends $pb.GeneratedMessage {
  factory UserRemove({
    $core.int? session,
    $core.int? actor,
    $core.String? reason,
    $core.bool? ban,
    $core.bool? banCertificate,
    $core.bool? banIp,
  }) {
    final result = UserRemove._();
    if (session != null) result.session = session;
    if (actor != null) result.actor = actor;
    if (reason != null) result.reason = reason;
    if (ban != null) result.ban = ban;
    if (banCertificate != null) result.banCertificate = banCertificate;
    if (banIp != null) result.banIp = banIp;
    return result;
  }

  UserRemove._();

  factory UserRemove.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserRemove()..mergeFromBuffer(data, registry);
  factory UserRemove.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserRemove()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserRemove',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: UserRemove.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'session', fieldType: $pb.PbFieldType.QU3)
    ..aI(2, _omitFieldNames ? '' : 'actor', fieldType: $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..aOB(4, _omitFieldNames ? '' : 'ban')
    ..aOB(5, _omitFieldNames ? '' : 'banCertificate')
    ..aOB(6, _omitFieldNames ? '' : 'banIp');

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRemove clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRemove copyWith(void Function(UserRemove) updates) =>
      super.copyWith((message) => updates(message as UserRemove)) as UserRemove;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserRemove() / UserRemove.new instead')
  static UserRemove create() => UserRemove._();
  static $pb.GeneratedMessage $_createMessage() => UserRemove._();
  @$core.override
  UserRemove createEmptyInstance() => UserRemove._();
  @$core.pragma('dart2js:noInline')
  static UserRemove getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserRemove>(UserRemove.$_createMessage);
  static UserRemove? _defaultInstance;

  /// The user who is being kicked, identified by their session, not present
  /// when no one is being kicked.
  @$pb.TagNumber(1)
  $core.int get session => $_getIZ(0);
  @$pb.TagNumber(1)
  set session($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => $_clearField(1);

  /// The user who initiated the removal. Either the user who performs the kick
  /// or the user who is currently leaving.
  @$pb.TagNumber(2)
  $core.int get actor => $_getIZ(1);
  @$pb.TagNumber(2)
  set actor($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActor() => $_has(1);
  @$pb.TagNumber(2)
  void clearActor() => $_clearField(2);

  /// Reason for the kick, stored as the ban reason if the user is banned.
  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);

  /// True if the user shall be banned, false if the user shall be kicked
  @$pb.TagNumber(4)
  $core.bool get ban => $_getBF(3);
  @$pb.TagNumber(4)
  set ban($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBan() => $_has(3);
  @$pb.TagNumber(4)
  void clearBan() => $_clearField(4);

  /// True if the user shall be banned by certificate.
  @$pb.TagNumber(5)
  $core.bool get banCertificate => $_getBF(4);
  @$pb.TagNumber(5)
  set banCertificate($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBanCertificate() => $_has(4);
  @$pb.TagNumber(5)
  void clearBanCertificate() => $_clearField(5);

  /// True if the user shall be banned by IP.
  @$pb.TagNumber(6)
  $core.bool get banIp => $_getBF(5);
  @$pb.TagNumber(6)
  set banIp($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBanIp() => $_has(5);
  @$pb.TagNumber(6)
  void clearBanIp() => $_clearField(6);
}

class UserState_VolumeAdjustment extends $pb.GeneratedMessage {
  factory UserState_VolumeAdjustment({
    $core.int? listeningChannel,
    $core.double? volumeAdjustment,
  }) {
    final result = UserState_VolumeAdjustment._();
    if (listeningChannel != null) result.listeningChannel = listeningChannel;
    if (volumeAdjustment != null) result.volumeAdjustment = volumeAdjustment;
    return result;
  }

  UserState_VolumeAdjustment._();

  factory UserState_VolumeAdjustment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserState_VolumeAdjustment()..mergeFromBuffer(data, registry);
  factory UserState_VolumeAdjustment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserState_VolumeAdjustment()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserState.VolumeAdjustment',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: UserState_VolumeAdjustment.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'listeningChannel',
        fieldType: $pb.PbFieldType.OU3)
    ..aD(2, _omitFieldNames ? '' : 'volumeAdjustment',
        fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserState_VolumeAdjustment clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserState_VolumeAdjustment copyWith(
          void Function(UserState_VolumeAdjustment) updates) =>
      super.copyWith(
              (message) => updates(message as UserState_VolumeAdjustment))
          as UserState_VolumeAdjustment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UserState_VolumeAdjustment() / UserState_VolumeAdjustment.new instead')
  static UserState_VolumeAdjustment create() => UserState_VolumeAdjustment._();
  static $pb.GeneratedMessage $_createMessage() =>
      UserState_VolumeAdjustment._();
  @$core.override
  UserState_VolumeAdjustment createEmptyInstance() =>
      UserState_VolumeAdjustment._();
  @$core.pragma('dart2js:noInline')
  static UserState_VolumeAdjustment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserState_VolumeAdjustment>(
          UserState_VolumeAdjustment.$_createMessage);
  static UserState_VolumeAdjustment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get listeningChannel => $_getIZ(0);
  @$pb.TagNumber(1)
  set listeningChannel($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasListeningChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearListeningChannel() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get volumeAdjustment => $_getN(1);
  @$pb.TagNumber(2)
  set volumeAdjustment($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVolumeAdjustment() => $_has(1);
  @$pb.TagNumber(2)
  void clearVolumeAdjustment() => $_clearField(2);
}

/// Sent by the server when it communicates new and changed users to client.
/// First seen during login procedure. May be sent by the client when it wishes
/// to alter its state.
class UserState extends $pb.GeneratedMessage {
  factory UserState({
    $core.int? session,
    $core.int? actor,
    $core.String? name,
    $core.int? userId,
    $core.int? channelId,
    $core.bool? mute,
    $core.bool? deaf,
    $core.bool? suppress,
    $core.bool? selfMute,
    $core.bool? selfDeaf,
    $core.List<$core.int>? texture,
    $core.List<$core.int>? pluginContext,
    $core.String? pluginIdentity,
    $core.String? comment,
    $core.String? hash,
    $core.List<$core.int>? commentHash,
    $core.List<$core.int>? textureHash,
    $core.bool? prioritySpeaker,
    $core.bool? recording,
    $core.Iterable<$core.String>? temporaryAccessTokens,
    $core.Iterable<$core.int>? listeningChannelAdd,
    $core.Iterable<$core.int>? listeningChannelRemove,
    $core.Iterable<UserState_VolumeAdjustment>? listeningVolumeAdjustment,
  }) {
    final result = UserState._();
    if (session != null) result.session = session;
    if (actor != null) result.actor = actor;
    if (name != null) result.name = name;
    if (userId != null) result.userId = userId;
    if (channelId != null) result.channelId = channelId;
    if (mute != null) result.mute = mute;
    if (deaf != null) result.deaf = deaf;
    if (suppress != null) result.suppress = suppress;
    if (selfMute != null) result.selfMute = selfMute;
    if (selfDeaf != null) result.selfDeaf = selfDeaf;
    if (texture != null) result.texture = texture;
    if (pluginContext != null) result.pluginContext = pluginContext;
    if (pluginIdentity != null) result.pluginIdentity = pluginIdentity;
    if (comment != null) result.comment = comment;
    if (hash != null) result.hash = hash;
    if (commentHash != null) result.commentHash = commentHash;
    if (textureHash != null) result.textureHash = textureHash;
    if (prioritySpeaker != null) result.prioritySpeaker = prioritySpeaker;
    if (recording != null) result.recording = recording;
    if (temporaryAccessTokens != null)
      result.temporaryAccessTokens.addAll(temporaryAccessTokens);
    if (listeningChannelAdd != null)
      result.listeningChannelAdd.addAll(listeningChannelAdd);
    if (listeningChannelRemove != null)
      result.listeningChannelRemove.addAll(listeningChannelRemove);
    if (listeningVolumeAdjustment != null)
      result.listeningVolumeAdjustment.addAll(listeningVolumeAdjustment);
    return result;
  }

  UserState._();

  factory UserState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserState()..mergeFromBuffer(data, registry);
  factory UserState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserState()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserState',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: UserState.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'session', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'actor', fieldType: $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aI(4, _omitFieldNames ? '' : 'userId', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'channelId', fieldType: $pb.PbFieldType.OU3)
    ..aOB(6, _omitFieldNames ? '' : 'mute')
    ..aOB(7, _omitFieldNames ? '' : 'deaf')
    ..aOB(8, _omitFieldNames ? '' : 'suppress')
    ..aOB(9, _omitFieldNames ? '' : 'selfMute')
    ..aOB(10, _omitFieldNames ? '' : 'selfDeaf')
    ..a<$core.List<$core.int>>(
        11, _omitFieldNames ? '' : 'texture', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        12, _omitFieldNames ? '' : 'pluginContext', $pb.PbFieldType.OY)
    ..aOS(13, _omitFieldNames ? '' : 'pluginIdentity')
    ..aOS(14, _omitFieldNames ? '' : 'comment')
    ..aOS(15, _omitFieldNames ? '' : 'hash')
    ..a<$core.List<$core.int>>(
        16, _omitFieldNames ? '' : 'commentHash', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        17, _omitFieldNames ? '' : 'textureHash', $pb.PbFieldType.OY)
    ..aOB(18, _omitFieldNames ? '' : 'prioritySpeaker')
    ..aOB(19, _omitFieldNames ? '' : 'recording')
    ..pPS(20, _omitFieldNames ? '' : 'temporaryAccessTokens')
    ..p<$core.int>(
        21, _omitFieldNames ? '' : 'listeningChannelAdd', $pb.PbFieldType.PU3)
    ..p<$core.int>(22, _omitFieldNames ? '' : 'listeningChannelRemove',
        $pb.PbFieldType.PU3)
    ..pPM<UserState_VolumeAdjustment>(
        23, _omitFieldNames ? '' : 'listeningVolumeAdjustment',
        subBuilder: UserState_VolumeAdjustment.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserState copyWith(void Function(UserState) updates) =>
      super.copyWith((message) => updates(message as UserState)) as UserState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserState() / UserState.new instead')
  static UserState create() => UserState._();
  static $pb.GeneratedMessage $_createMessage() => UserState._();
  @$core.override
  UserState createEmptyInstance() => UserState._();
  @$core.pragma('dart2js:noInline')
  static UserState getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserState>(UserState.$_createMessage);
  static UserState? _defaultInstance;

  /// Unique user session ID of the user whose state this is, may change on
  /// reconnect.
  @$pb.TagNumber(1)
  $core.int get session => $_getIZ(0);
  @$pb.TagNumber(1)
  set session($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => $_clearField(1);

  /// The session of the user who is updating this user.
  @$pb.TagNumber(2)
  $core.int get actor => $_getIZ(1);
  @$pb.TagNumber(2)
  set actor($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActor() => $_has(1);
  @$pb.TagNumber(2)
  void clearActor() => $_clearField(2);

  /// User name, UTF-8 encoded.
  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  /// Registered user ID if the user is registered.
  @$pb.TagNumber(4)
  $core.int get userId => $_getIZ(3);
  @$pb.TagNumber(4)
  set userId($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);

  /// Channel on which the user is.
  @$pb.TagNumber(5)
  $core.int get channelId => $_getIZ(4);
  @$pb.TagNumber(5)
  set channelId($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChannelId() => $_has(4);
  @$pb.TagNumber(5)
  void clearChannelId() => $_clearField(5);

  /// True if the user is muted by admin.
  @$pb.TagNumber(6)
  $core.bool get mute => $_getBF(5);
  @$pb.TagNumber(6)
  set mute($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMute() => $_has(5);
  @$pb.TagNumber(6)
  void clearMute() => $_clearField(6);

  /// True if the user is deafened by admin.
  @$pb.TagNumber(7)
  $core.bool get deaf => $_getBF(6);
  @$pb.TagNumber(7)
  set deaf($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDeaf() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeaf() => $_clearField(7);

  /// True if the user has been suppressed from talking by a reason other than
  /// being muted.
  @$pb.TagNumber(8)
  $core.bool get suppress => $_getBF(7);
  @$pb.TagNumber(8)
  set suppress($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSuppress() => $_has(7);
  @$pb.TagNumber(8)
  void clearSuppress() => $_clearField(8);

  /// True if the user has muted self.
  @$pb.TagNumber(9)
  $core.bool get selfMute => $_getBF(8);
  @$pb.TagNumber(9)
  set selfMute($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSelfMute() => $_has(8);
  @$pb.TagNumber(9)
  void clearSelfMute() => $_clearField(9);

  /// True if the user has deafened self.
  @$pb.TagNumber(10)
  $core.bool get selfDeaf => $_getBF(9);
  @$pb.TagNumber(10)
  set selfDeaf($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSelfDeaf() => $_has(9);
  @$pb.TagNumber(10)
  void clearSelfDeaf() => $_clearField(10);

  /// User image if it is less than 128 bytes.
  @$pb.TagNumber(11)
  $core.List<$core.int> get texture => $_getN(10);
  @$pb.TagNumber(11)
  set texture($core.List<$core.int> value) => $_setBytes(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTexture() => $_has(10);
  @$pb.TagNumber(11)
  void clearTexture() => $_clearField(11);

  /// The positional audio plugin identifier.
  /// Positional audio information is only sent to users who share
  /// identical plugin contexts.
  ///
  /// This value is not transmitted to clients.
  @$pb.TagNumber(12)
  $core.List<$core.int> get pluginContext => $_getN(11);
  @$pb.TagNumber(12)
  set pluginContext($core.List<$core.int> value) => $_setBytes(11, value);
  @$pb.TagNumber(12)
  $core.bool hasPluginContext() => $_has(11);
  @$pb.TagNumber(12)
  void clearPluginContext() => $_clearField(12);

  /// The user's plugin-specific identity.
  /// This value is not transmitted to clients.
  @$pb.TagNumber(13)
  $core.String get pluginIdentity => $_getSZ(12);
  @$pb.TagNumber(13)
  set pluginIdentity($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasPluginIdentity() => $_has(12);
  @$pb.TagNumber(13)
  void clearPluginIdentity() => $_clearField(13);

  /// User comment if it is less than 128 bytes.
  @$pb.TagNumber(14)
  $core.String get comment => $_getSZ(13);
  @$pb.TagNumber(14)
  set comment($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasComment() => $_has(13);
  @$pb.TagNumber(14)
  void clearComment() => $_clearField(14);

  /// The hash of the user certificate.
  @$pb.TagNumber(15)
  $core.String get hash => $_getSZ(14);
  @$pb.TagNumber(15)
  set hash($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasHash() => $_has(14);
  @$pb.TagNumber(15)
  void clearHash() => $_clearField(15);

  /// SHA1 hash of the user comment if it 128 bytes or more.
  @$pb.TagNumber(16)
  $core.List<$core.int> get commentHash => $_getN(15);
  @$pb.TagNumber(16)
  set commentHash($core.List<$core.int> value) => $_setBytes(15, value);
  @$pb.TagNumber(16)
  $core.bool hasCommentHash() => $_has(15);
  @$pb.TagNumber(16)
  void clearCommentHash() => $_clearField(16);

  /// SHA1 hash of the user picture if it 128 bytes or more.
  @$pb.TagNumber(17)
  $core.List<$core.int> get textureHash => $_getN(16);
  @$pb.TagNumber(17)
  set textureHash($core.List<$core.int> value) => $_setBytes(16, value);
  @$pb.TagNumber(17)
  $core.bool hasTextureHash() => $_has(16);
  @$pb.TagNumber(17)
  void clearTextureHash() => $_clearField(17);

  /// True if the user is a priority speaker.
  @$pb.TagNumber(18)
  $core.bool get prioritySpeaker => $_getBF(17);
  @$pb.TagNumber(18)
  set prioritySpeaker($core.bool value) => $_setBool(17, value);
  @$pb.TagNumber(18)
  $core.bool hasPrioritySpeaker() => $_has(17);
  @$pb.TagNumber(18)
  void clearPrioritySpeaker() => $_clearField(18);

  /// True if the user is currently recording.
  @$pb.TagNumber(19)
  $core.bool get recording => $_getBF(18);
  @$pb.TagNumber(19)
  set recording($core.bool value) => $_setBool(18, value);
  @$pb.TagNumber(19)
  $core.bool hasRecording() => $_has(18);
  @$pb.TagNumber(19)
  void clearRecording() => $_clearField(19);

  /// A list of temporary access tokens to be respected when processing this request.
  @$pb.TagNumber(20)
  $pb.PbList<$core.String> get temporaryAccessTokens => $_getList(19);

  /// A list of channels the user wants to start listening to.
  @$pb.TagNumber(21)
  $pb.PbList<$core.int> get listeningChannelAdd => $_getList(20);

  /// a list of channels the user does no longer want to listen to.
  @$pb.TagNumber(22)
  $pb.PbList<$core.int> get listeningChannelRemove => $_getList(21);

  /// A list of volume adjustments the user has applied to listeners
  @$pb.TagNumber(23)
  $pb.PbList<UserState_VolumeAdjustment> get listeningVolumeAdjustment =>
      $_getList(22);
}

class BanList_BanEntry extends $pb.GeneratedMessage {
  factory BanList_BanEntry({
    $core.List<$core.int>? address,
    $core.int? mask,
    $core.String? name,
    $core.String? hash,
    $core.String? reason,
    $core.String? start,
    $core.int? duration,
  }) {
    final result = BanList_BanEntry._();
    if (address != null) result.address = address;
    if (mask != null) result.mask = mask;
    if (name != null) result.name = name;
    if (hash != null) result.hash = hash;
    if (reason != null) result.reason = reason;
    if (start != null) result.start = start;
    if (duration != null) result.duration = duration;
    return result;
  }

  BanList_BanEntry._();

  factory BanList_BanEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BanList_BanEntry()..mergeFromBuffer(data, registry);
  factory BanList_BanEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BanList_BanEntry()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BanList.BanEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: BanList_BanEntry.$_createMessage)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'address', $pb.PbFieldType.QY)
    ..aI(2, _omitFieldNames ? '' : 'mask', fieldType: $pb.PbFieldType.QU3)
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'hash')
    ..aOS(5, _omitFieldNames ? '' : 'reason')
    ..aOS(6, _omitFieldNames ? '' : 'start')
    ..aI(7, _omitFieldNames ? '' : 'duration', fieldType: $pb.PbFieldType.OU3);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BanList_BanEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BanList_BanEntry copyWith(void Function(BanList_BanEntry) updates) =>
      super.copyWith((message) => updates(message as BanList_BanEntry))
          as BanList_BanEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BanList_BanEntry() / BanList_BanEntry.new instead')
  static BanList_BanEntry create() => BanList_BanEntry._();
  static $pb.GeneratedMessage $_createMessage() => BanList_BanEntry._();
  @$core.override
  BanList_BanEntry createEmptyInstance() => BanList_BanEntry._();
  @$core.pragma('dart2js:noInline')
  static BanList_BanEntry getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BanList_BanEntry>(
          BanList_BanEntry.$_createMessage);
  static BanList_BanEntry? _defaultInstance;

  /// Banned IP address.
  @$pb.TagNumber(1)
  $core.List<$core.int> get address => $_getN(0);
  @$pb.TagNumber(1)
  set address($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => $_clearField(1);

  /// The length of the subnet mask for the ban.
  @$pb.TagNumber(2)
  $core.int get mask => $_getIZ(1);
  @$pb.TagNumber(2)
  set mask($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearMask() => $_clearField(2);

  /// User name for identification purposes (does not affect the ban).
  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  /// The certificate hash of the banned user.
  @$pb.TagNumber(4)
  $core.String get hash => $_getSZ(3);
  @$pb.TagNumber(4)
  set hash($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearHash() => $_clearField(4);

  /// Reason for the ban (does not affect the ban).
  @$pb.TagNumber(5)
  $core.String get reason => $_getSZ(4);
  @$pb.TagNumber(5)
  set reason($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReason() => $_has(4);
  @$pb.TagNumber(5)
  void clearReason() => $_clearField(5);

  /// Ban start time.
  @$pb.TagNumber(6)
  $core.String get start => $_getSZ(5);
  @$pb.TagNumber(6)
  set start($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStart() => $_has(5);
  @$pb.TagNumber(6)
  void clearStart() => $_clearField(6);

  /// Ban duration in seconds.
  @$pb.TagNumber(7)
  $core.int get duration => $_getIZ(6);
  @$pb.TagNumber(7)
  set duration($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDuration() => $_has(6);
  @$pb.TagNumber(7)
  void clearDuration() => $_clearField(7);
}

/// Relays information on the bans. The client may send the BanList message to
/// either modify the list of bans or query them from the server. The server
/// sends this list only after a client queries for it.
class BanList extends $pb.GeneratedMessage {
  factory BanList({
    $core.Iterable<BanList_BanEntry>? bans,
    $core.bool? query,
  }) {
    final result = BanList._();
    if (bans != null) result.bans.addAll(bans);
    if (query != null) result.query = query;
    return result;
  }

  BanList._();

  factory BanList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BanList()..mergeFromBuffer(data, registry);
  factory BanList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BanList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BanList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: BanList.$_createMessage)
    ..pPM<BanList_BanEntry>(1, _omitFieldNames ? '' : 'bans',
        subBuilder: BanList_BanEntry.$_createMessage)
    ..aOB(2, _omitFieldNames ? '' : 'query');

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BanList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BanList copyWith(void Function(BanList) updates) =>
      super.copyWith((message) => updates(message as BanList)) as BanList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BanList() / BanList.new instead')
  static BanList create() => BanList._();
  static $pb.GeneratedMessage $_createMessage() => BanList._();
  @$core.override
  BanList createEmptyInstance() => BanList._();
  @$core.pragma('dart2js:noInline')
  static BanList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BanList>(BanList.$_createMessage);
  static BanList? _defaultInstance;

  /// List of ban entries currently in place.
  @$pb.TagNumber(1)
  $pb.PbList<BanList_BanEntry> get bans => $_getList(0);

  /// True if the server should return the list, false if it should replace old
  /// ban list with the one provided.
  @$pb.TagNumber(2)
  $core.bool get query => $_getBF(1);
  @$pb.TagNumber(2)
  set query($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => $_clearField(2);
}

/// Used to send and broadcast text messages.
class TextMessage extends $pb.GeneratedMessage {
  factory TextMessage({
    $core.int? actor,
    $core.Iterable<$core.int>? session,
    $core.Iterable<$core.int>? channelId,
    $core.Iterable<$core.int>? treeId,
    $core.String? message,
  }) {
    final result = TextMessage._();
    if (actor != null) result.actor = actor;
    if (session != null) result.session.addAll(session);
    if (channelId != null) result.channelId.addAll(channelId);
    if (treeId != null) result.treeId.addAll(treeId);
    if (message != null) result.message = message;
    return result;
  }

  TextMessage._();

  factory TextMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TextMessage()..mergeFromBuffer(data, registry);
  factory TextMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TextMessage()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TextMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: TextMessage.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'actor', fieldType: $pb.PbFieldType.OU3)
    ..p<$core.int>(2, _omitFieldNames ? '' : 'session', $pb.PbFieldType.PU3)
    ..p<$core.int>(3, _omitFieldNames ? '' : 'channelId', $pb.PbFieldType.PU3)
    ..p<$core.int>(4, _omitFieldNames ? '' : 'treeId', $pb.PbFieldType.PU3)
    ..aQS(5, _omitFieldNames ? '' : 'message');

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextMessage copyWith(void Function(TextMessage) updates) =>
      super.copyWith((message) => updates(message as TextMessage))
          as TextMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TextMessage() / TextMessage.new instead')
  static TextMessage create() => TextMessage._();
  static $pb.GeneratedMessage $_createMessage() => TextMessage._();
  @$core.override
  TextMessage createEmptyInstance() => TextMessage._();
  @$core.pragma('dart2js:noInline')
  static TextMessage getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TextMessage>(
          TextMessage.$_createMessage);
  static TextMessage? _defaultInstance;

  /// The message sender, identified by its session.
  @$pb.TagNumber(1)
  $core.int get actor => $_getIZ(0);
  @$pb.TagNumber(1)
  set actor($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasActor() => $_has(0);
  @$pb.TagNumber(1)
  void clearActor() => $_clearField(1);

  /// Target users for the message, identified by their session.
  @$pb.TagNumber(2)
  $pb.PbList<$core.int> get session => $_getList(1);

  /// The channels to which the message is sent, identified by their
  /// channel_ids.
  @$pb.TagNumber(3)
  $pb.PbList<$core.int> get channelId => $_getList(2);

  /// The root channels when sending message recursively to several channels,
  /// identified by their channel_ids.
  @$pb.TagNumber(4)
  $pb.PbList<$core.int> get treeId => $_getList(3);

  /// The UTF-8 encoded message. May be HTML if the server allows.
  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

class PermissionDenied extends $pb.GeneratedMessage {
  factory PermissionDenied({
    $core.int? permission,
    $core.int? channelId,
    $core.int? session,
    $core.String? reason,
    PermissionDenied_DenyType? type,
    $core.String? name,
  }) {
    final result = PermissionDenied._();
    if (permission != null) result.permission = permission;
    if (channelId != null) result.channelId = channelId;
    if (session != null) result.session = session;
    if (reason != null) result.reason = reason;
    if (type != null) result.type = type;
    if (name != null) result.name = name;
    return result;
  }

  PermissionDenied._();

  factory PermissionDenied.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PermissionDenied()..mergeFromBuffer(data, registry);
  factory PermissionDenied.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PermissionDenied()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PermissionDenied',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: PermissionDenied.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'permission', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'channelId', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'session', fieldType: $pb.PbFieldType.OU3)
    ..aOS(4, _omitFieldNames ? '' : 'reason')
    ..aE<PermissionDenied_DenyType>(5, _omitFieldNames ? '' : 'type',
        enumValues: PermissionDenied_DenyType.values)
    ..aOS(6, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PermissionDenied clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PermissionDenied copyWith(void Function(PermissionDenied) updates) =>
      super.copyWith((message) => updates(message as PermissionDenied))
          as PermissionDenied;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PermissionDenied() / PermissionDenied.new instead')
  static PermissionDenied create() => PermissionDenied._();
  static $pb.GeneratedMessage $_createMessage() => PermissionDenied._();
  @$core.override
  PermissionDenied createEmptyInstance() => PermissionDenied._();
  @$core.pragma('dart2js:noInline')
  static PermissionDenied getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PermissionDenied>(
          PermissionDenied.$_createMessage);
  static PermissionDenied? _defaultInstance;

  /// The denied permission when type is Permission.
  @$pb.TagNumber(1)
  $core.int get permission => $_getIZ(0);
  @$pb.TagNumber(1)
  set permission($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPermission() => $_has(0);
  @$pb.TagNumber(1)
  void clearPermission() => $_clearField(1);

  /// channel_id for the channel where the permission was denied when type is
  /// Permission.
  @$pb.TagNumber(2)
  $core.int get channelId => $_getIZ(1);
  @$pb.TagNumber(2)
  set channelId($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelId() => $_clearField(2);

  /// The user who was denied permissions, identified by session.
  @$pb.TagNumber(3)
  $core.int get session => $_getIZ(2);
  @$pb.TagNumber(3)
  set session($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSession() => $_has(2);
  @$pb.TagNumber(3)
  void clearSession() => $_clearField(3);

  /// Textual reason for the denial.
  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => $_clearField(4);

  /// Type of the denial.
  @$pb.TagNumber(5)
  PermissionDenied_DenyType get type => $_getN(4);
  @$pb.TagNumber(5)
  set type(PermissionDenied_DenyType value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => $_clearField(5);

  /// The name that is invalid when type is UserName.
  @$pb.TagNumber(6)
  $core.String get name => $_getSZ(5);
  @$pb.TagNumber(6)
  set name($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasName() => $_has(5);
  @$pb.TagNumber(6)
  void clearName() => $_clearField(6);
}

class ACL_ChanGroup extends $pb.GeneratedMessage {
  factory ACL_ChanGroup({
    $core.String? name,
    $core.bool? inherited,
    $core.bool? inherit,
    $core.bool? inheritable,
    $core.Iterable<$core.int>? add,
    $core.Iterable<$core.int>? remove,
    $core.Iterable<$core.int>? inheritedMembers,
  }) {
    final result = ACL_ChanGroup._();
    if (name != null) result.name = name;
    if (inherited != null) result.inherited = inherited;
    if (inherit != null) result.inherit = inherit;
    if (inheritable != null) result.inheritable = inheritable;
    if (add != null) result.add.addAll(add);
    if (remove != null) result.remove.addAll(remove);
    if (inheritedMembers != null)
      result.inheritedMembers.addAll(inheritedMembers);
    return result;
  }

  ACL_ChanGroup._();

  factory ACL_ChanGroup.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ACL_ChanGroup()..mergeFromBuffer(data, registry);
  factory ACL_ChanGroup.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ACL_ChanGroup()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ACL.ChanGroup',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: ACL_ChanGroup.$_createMessage)
    ..aQS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.bool>(2, _omitFieldNames ? '' : 'inherited', $pb.PbFieldType.OB,
        defaultOrMaker: true)
    ..a<$core.bool>(3, _omitFieldNames ? '' : 'inherit', $pb.PbFieldType.OB,
        defaultOrMaker: true)
    ..a<$core.bool>(4, _omitFieldNames ? '' : 'inheritable', $pb.PbFieldType.OB,
        defaultOrMaker: true)
    ..p<$core.int>(5, _omitFieldNames ? '' : 'add', $pb.PbFieldType.PU3)
    ..p<$core.int>(6, _omitFieldNames ? '' : 'remove', $pb.PbFieldType.PU3)
    ..p<$core.int>(
        7, _omitFieldNames ? '' : 'inheritedMembers', $pb.PbFieldType.PU3);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ACL_ChanGroup clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ACL_ChanGroup copyWith(void Function(ACL_ChanGroup) updates) =>
      super.copyWith((message) => updates(message as ACL_ChanGroup))
          as ACL_ChanGroup;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ACL_ChanGroup() / ACL_ChanGroup.new instead')
  static ACL_ChanGroup create() => ACL_ChanGroup._();
  static $pb.GeneratedMessage $_createMessage() => ACL_ChanGroup._();
  @$core.override
  ACL_ChanGroup createEmptyInstance() => ACL_ChanGroup._();
  @$core.pragma('dart2js:noInline')
  static ACL_ChanGroup getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ACL_ChanGroup>(
          ACL_ChanGroup.$_createMessage);
  static ACL_ChanGroup? _defaultInstance;

  /// Name of the channel group, UTF-8 encoded.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// True if the group has been inherited from the parent (Read only).
  @$pb.TagNumber(2)
  $core.bool get inherited => $_getB(1, true);
  @$pb.TagNumber(2)
  set inherited($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInherited() => $_has(1);
  @$pb.TagNumber(2)
  void clearInherited() => $_clearField(2);

  /// True if the group members are inherited.
  @$pb.TagNumber(3)
  $core.bool get inherit => $_getB(2, true);
  @$pb.TagNumber(3)
  set inherit($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInherit() => $_has(2);
  @$pb.TagNumber(3)
  void clearInherit() => $_clearField(3);

  /// True if the group can be inherited by sub channels.
  @$pb.TagNumber(4)
  $core.bool get inheritable => $_getB(3, true);
  @$pb.TagNumber(4)
  set inheritable($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInheritable() => $_has(3);
  @$pb.TagNumber(4)
  void clearInheritable() => $_clearField(4);

  /// Users explicitly included in this group, identified by user_id.
  @$pb.TagNumber(5)
  $pb.PbList<$core.int> get add => $_getList(4);

  /// Users explicitly removed from this group in this channel if the group
  /// has been inherited, identified by user_id.
  @$pb.TagNumber(6)
  $pb.PbList<$core.int> get remove => $_getList(5);

  /// Users inherited, identified by user_id.
  @$pb.TagNumber(7)
  $pb.PbList<$core.int> get inheritedMembers => $_getList(6);
}

class ACL_ChanACL extends $pb.GeneratedMessage {
  factory ACL_ChanACL({
    $core.bool? applyHere,
    $core.bool? applySubs,
    $core.bool? inherited,
    $core.int? userId,
    $core.String? group,
    $core.int? grant,
    $core.int? deny,
  }) {
    final result = ACL_ChanACL._();
    if (applyHere != null) result.applyHere = applyHere;
    if (applySubs != null) result.applySubs = applySubs;
    if (inherited != null) result.inherited = inherited;
    if (userId != null) result.userId = userId;
    if (group != null) result.group = group;
    if (grant != null) result.grant = grant;
    if (deny != null) result.deny = deny;
    return result;
  }

  ACL_ChanACL._();

  factory ACL_ChanACL.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ACL_ChanACL()..mergeFromBuffer(data, registry);
  factory ACL_ChanACL.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ACL_ChanACL()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ACL.ChanACL',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: ACL_ChanACL.$_createMessage)
    ..a<$core.bool>(1, _omitFieldNames ? '' : 'applyHere', $pb.PbFieldType.OB,
        defaultOrMaker: true)
    ..a<$core.bool>(2, _omitFieldNames ? '' : 'applySubs', $pb.PbFieldType.OB,
        defaultOrMaker: true)
    ..a<$core.bool>(3, _omitFieldNames ? '' : 'inherited', $pb.PbFieldType.OB,
        defaultOrMaker: true)
    ..aI(4, _omitFieldNames ? '' : 'userId', fieldType: $pb.PbFieldType.OU3)
    ..aOS(5, _omitFieldNames ? '' : 'group')
    ..aI(6, _omitFieldNames ? '' : 'grant', fieldType: $pb.PbFieldType.OU3)
    ..aI(7, _omitFieldNames ? '' : 'deny', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ACL_ChanACL clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ACL_ChanACL copyWith(void Function(ACL_ChanACL) updates) =>
      super.copyWith((message) => updates(message as ACL_ChanACL))
          as ACL_ChanACL;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ACL_ChanACL() / ACL_ChanACL.new instead')
  static ACL_ChanACL create() => ACL_ChanACL._();
  static $pb.GeneratedMessage $_createMessage() => ACL_ChanACL._();
  @$core.override
  ACL_ChanACL createEmptyInstance() => ACL_ChanACL._();
  @$core.pragma('dart2js:noInline')
  static ACL_ChanACL getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ACL_ChanACL>(
          ACL_ChanACL.$_createMessage);
  static ACL_ChanACL? _defaultInstance;

  /// True if this ACL applies to the current channel.
  @$pb.TagNumber(1)
  $core.bool get applyHere => $_getB(0, true);
  @$pb.TagNumber(1)
  set applyHere($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApplyHere() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplyHere() => $_clearField(1);

  /// True if this ACL applies to the sub channels.
  @$pb.TagNumber(2)
  $core.bool get applySubs => $_getB(1, true);
  @$pb.TagNumber(2)
  set applySubs($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasApplySubs() => $_has(1);
  @$pb.TagNumber(2)
  void clearApplySubs() => $_clearField(2);

  /// True if the ACL has been inherited from the parent.
  @$pb.TagNumber(3)
  $core.bool get inherited => $_getB(2, true);
  @$pb.TagNumber(3)
  set inherited($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInherited() => $_has(2);
  @$pb.TagNumber(3)
  void clearInherited() => $_clearField(3);

  /// ID of the user that is affected by this ACL.
  @$pb.TagNumber(4)
  $core.int get userId => $_getIZ(3);
  @$pb.TagNumber(4)
  set userId($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);

  /// ID of the group that is affected by this ACL.
  @$pb.TagNumber(5)
  $core.String get group => $_getSZ(4);
  @$pb.TagNumber(5)
  set group($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasGroup() => $_has(4);
  @$pb.TagNumber(5)
  void clearGroup() => $_clearField(5);

  /// Bit flag field of the permissions granted by this ACL.
  @$pb.TagNumber(6)
  $core.int get grant => $_getIZ(5);
  @$pb.TagNumber(6)
  set grant($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasGrant() => $_has(5);
  @$pb.TagNumber(6)
  void clearGrant() => $_clearField(6);

  /// Bit flag field of the permissions denied by this ACL.
  @$pb.TagNumber(7)
  $core.int get deny => $_getIZ(6);
  @$pb.TagNumber(7)
  set deny($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDeny() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeny() => $_clearField(7);
}

class ACL extends $pb.GeneratedMessage {
  factory ACL({
    $core.int? channelId,
    $core.bool? inheritAcls,
    $core.Iterable<ACL_ChanGroup>? groups,
    $core.Iterable<ACL_ChanACL>? acls,
    $core.bool? query,
  }) {
    final result = ACL._();
    if (channelId != null) result.channelId = channelId;
    if (inheritAcls != null) result.inheritAcls = inheritAcls;
    if (groups != null) result.groups.addAll(groups);
    if (acls != null) result.acls.addAll(acls);
    if (query != null) result.query = query;
    return result;
  }

  ACL._();

  factory ACL.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ACL()..mergeFromBuffer(data, registry);
  factory ACL.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ACL()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ACL',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: ACL.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'channelId', fieldType: $pb.PbFieldType.QU3)
    ..a<$core.bool>(2, _omitFieldNames ? '' : 'inheritAcls', $pb.PbFieldType.OB,
        defaultOrMaker: true)
    ..pPM<ACL_ChanGroup>(3, _omitFieldNames ? '' : 'groups',
        subBuilder: ACL_ChanGroup.$_createMessage)
    ..pPM<ACL_ChanACL>(4, _omitFieldNames ? '' : 'acls',
        subBuilder: ACL_ChanACL.$_createMessage)
    ..aOB(5, _omitFieldNames ? '' : 'query');

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ACL clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ACL copyWith(void Function(ACL) updates) =>
      super.copyWith((message) => updates(message as ACL)) as ACL;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ACL() / ACL.new instead')
  static ACL create() => ACL._();
  static $pb.GeneratedMessage $_createMessage() => ACL._();
  @$core.override
  ACL createEmptyInstance() => ACL._();
  @$core.pragma('dart2js:noInline')
  static ACL getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ACL>(ACL.$_createMessage);
  static ACL? _defaultInstance;

  /// Channel ID of the channel this message affects.
  @$pb.TagNumber(1)
  $core.int get channelId => $_getIZ(0);
  @$pb.TagNumber(1)
  set channelId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// True if the channel inherits its parent's ACLs.
  @$pb.TagNumber(2)
  $core.bool get inheritAcls => $_getB(1, true);
  @$pb.TagNumber(2)
  set inheritAcls($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInheritAcls() => $_has(1);
  @$pb.TagNumber(2)
  void clearInheritAcls() => $_clearField(2);

  /// User group specifications.
  @$pb.TagNumber(3)
  $pb.PbList<ACL_ChanGroup> get groups => $_getList(2);

  /// ACL specifications.
  @$pb.TagNumber(4)
  $pb.PbList<ACL_ChanACL> get acls => $_getList(3);

  /// True if the message is a query for ACLs instead of setting them.
  @$pb.TagNumber(5)
  $core.bool get query => $_getBF(4);
  @$pb.TagNumber(5)
  set query($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQuery() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuery() => $_clearField(5);
}

/// Client may use this message to refresh its registered user information. The
/// client should fill the IDs or Names of the users it wants to refresh. The
/// server fills the missing parts and sends the message back.
class QueryUsers extends $pb.GeneratedMessage {
  factory QueryUsers({
    $core.Iterable<$core.int>? ids,
    $core.Iterable<$core.String>? names,
  }) {
    final result = QueryUsers._();
    if (ids != null) result.ids.addAll(ids);
    if (names != null) result.names.addAll(names);
    return result;
  }

  QueryUsers._();

  factory QueryUsers.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      QueryUsers()..mergeFromBuffer(data, registry);
  factory QueryUsers.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      QueryUsers()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QueryUsers',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: QueryUsers.$_createMessage)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'ids', $pb.PbFieldType.PU3)
    ..pPS(2, _omitFieldNames ? '' : 'names')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QueryUsers clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QueryUsers copyWith(void Function(QueryUsers) updates) =>
      super.copyWith((message) => updates(message as QueryUsers)) as QueryUsers;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use QueryUsers() / QueryUsers.new instead')
  static QueryUsers create() => QueryUsers._();
  static $pb.GeneratedMessage $_createMessage() => QueryUsers._();
  @$core.override
  QueryUsers createEmptyInstance() => QueryUsers._();
  @$core.pragma('dart2js:noInline')
  static QueryUsers getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QueryUsers>(QueryUsers.$_createMessage);
  static QueryUsers? _defaultInstance;

  /// user_ids.
  @$pb.TagNumber(1)
  $pb.PbList<$core.int> get ids => $_getList(0);

  /// User names in the same order as ids.
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get names => $_getList(1);
}

/// Used to initialize and resync the UDP encryption. Either side may request a
/// resync by sending the message without any values filled. The resync is
/// performed by sending the message with only the client or server nonce
/// filled.
class CryptSetup extends $pb.GeneratedMessage {
  factory CryptSetup({
    $core.List<$core.int>? key,
    $core.List<$core.int>? clientNonce,
    $core.List<$core.int>? serverNonce,
  }) {
    final result = CryptSetup._();
    if (key != null) result.key = key;
    if (clientNonce != null) result.clientNonce = clientNonce;
    if (serverNonce != null) result.serverNonce = serverNonce;
    return result;
  }

  CryptSetup._();

  factory CryptSetup.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CryptSetup()..mergeFromBuffer(data, registry);
  factory CryptSetup.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CryptSetup()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CryptSetup',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: CryptSetup.$_createMessage)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'key', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'clientNonce', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'serverNonce', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CryptSetup clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CryptSetup copyWith(void Function(CryptSetup) updates) =>
      super.copyWith((message) => updates(message as CryptSetup)) as CryptSetup;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CryptSetup() / CryptSetup.new instead')
  static CryptSetup create() => CryptSetup._();
  static $pb.GeneratedMessage $_createMessage() => CryptSetup._();
  @$core.override
  CryptSetup createEmptyInstance() => CryptSetup._();
  @$core.pragma('dart2js:noInline')
  static CryptSetup getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CryptSetup>(CryptSetup.$_createMessage);
  static CryptSetup? _defaultInstance;

  /// Encryption key.
  @$pb.TagNumber(1)
  $core.List<$core.int> get key => $_getN(0);
  @$pb.TagNumber(1)
  set key($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  /// Client nonce.
  @$pb.TagNumber(2)
  $core.List<$core.int> get clientNonce => $_getN(1);
  @$pb.TagNumber(2)
  set clientNonce($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClientNonce() => $_has(1);
  @$pb.TagNumber(2)
  void clearClientNonce() => $_clearField(2);

  /// Server nonce.
  @$pb.TagNumber(3)
  $core.List<$core.int> get serverNonce => $_getN(2);
  @$pb.TagNumber(3)
  set serverNonce($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasServerNonce() => $_has(2);
  @$pb.TagNumber(3)
  void clearServerNonce() => $_clearField(3);
}

/// Used to add or remove custom context menu item on client-side.
class ContextActionModify extends $pb.GeneratedMessage {
  factory ContextActionModify({
    $core.String? action,
    $core.String? text,
    $core.int? context,
    ContextActionModify_Operation? operation,
  }) {
    final result = ContextActionModify._();
    if (action != null) result.action = action;
    if (text != null) result.text = text;
    if (context != null) result.context = context;
    if (operation != null) result.operation = operation;
    return result;
  }

  ContextActionModify._();

  factory ContextActionModify.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ContextActionModify()..mergeFromBuffer(data, registry);
  factory ContextActionModify.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ContextActionModify()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContextActionModify',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: ContextActionModify.$_createMessage)
    ..aQS(1, _omitFieldNames ? '' : 'action')
    ..aOS(2, _omitFieldNames ? '' : 'text')
    ..aI(3, _omitFieldNames ? '' : 'context', fieldType: $pb.PbFieldType.OU3)
    ..aE<ContextActionModify_Operation>(4, _omitFieldNames ? '' : 'operation',
        enumValues: ContextActionModify_Operation.values);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContextActionModify clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContextActionModify copyWith(void Function(ContextActionModify) updates) =>
      super.copyWith((message) => updates(message as ContextActionModify))
          as ContextActionModify;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ContextActionModify() / ContextActionModify.new instead')
  static ContextActionModify create() => ContextActionModify._();
  static $pb.GeneratedMessage $_createMessage() => ContextActionModify._();
  @$core.override
  ContextActionModify createEmptyInstance() => ContextActionModify._();
  @$core.pragma('dart2js:noInline')
  static ContextActionModify getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContextActionModify>(
          ContextActionModify.$_createMessage);
  static ContextActionModify? _defaultInstance;

  /// The action identifier. Used later to initiate an action.
  @$pb.TagNumber(1)
  $core.String get action => $_getSZ(0);
  @$pb.TagNumber(1)
  set action($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => $_clearField(1);

  /// The display name of the action.
  @$pb.TagNumber(2)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => $_clearField(2);

  /// Context bit flags defining where the action should be displayed.
  /// Flags can be OR-ed to combine different types.
  @$pb.TagNumber(3)
  $core.int get context => $_getIZ(2);
  @$pb.TagNumber(3)
  set context($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasContext() => $_has(2);
  @$pb.TagNumber(3)
  void clearContext() => $_clearField(3);

  /// Choose either to add or to remove the context action.
  /// Note: This field only exists after Mumble 1.2.4-beta1 release.
  ///       The message will be recognized as Add regardless of this field
  ///       before said release.
  @$pb.TagNumber(4)
  ContextActionModify_Operation get operation => $_getN(3);
  @$pb.TagNumber(4)
  set operation(ContextActionModify_Operation value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasOperation() => $_has(3);
  @$pb.TagNumber(4)
  void clearOperation() => $_clearField(4);
}

/// Sent by the client when it wants to initiate a Context action.
class ContextAction extends $pb.GeneratedMessage {
  factory ContextAction({
    $core.int? session,
    $core.int? channelId,
    $core.String? action,
  }) {
    final result = ContextAction._();
    if (session != null) result.session = session;
    if (channelId != null) result.channelId = channelId;
    if (action != null) result.action = action;
    return result;
  }

  ContextAction._();

  factory ContextAction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ContextAction()..mergeFromBuffer(data, registry);
  factory ContextAction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ContextAction()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContextAction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: ContextAction.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'session', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'channelId', fieldType: $pb.PbFieldType.OU3)
    ..aQS(3, _omitFieldNames ? '' : 'action');

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContextAction clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContextAction copyWith(void Function(ContextAction) updates) =>
      super.copyWith((message) => updates(message as ContextAction))
          as ContextAction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ContextAction() / ContextAction.new instead')
  static ContextAction create() => ContextAction._();
  static $pb.GeneratedMessage $_createMessage() => ContextAction._();
  @$core.override
  ContextAction createEmptyInstance() => ContextAction._();
  @$core.pragma('dart2js:noInline')
  static ContextAction getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContextAction>(
          ContextAction.$_createMessage);
  static ContextAction? _defaultInstance;

  /// The target User for the action, identified by session.
  @$pb.TagNumber(1)
  $core.int get session => $_getIZ(0);
  @$pb.TagNumber(1)
  set session($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => $_clearField(1);

  /// The target Channel for the action, identified by channel_id.
  @$pb.TagNumber(2)
  $core.int get channelId => $_getIZ(1);
  @$pb.TagNumber(2)
  set channelId($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelId() => $_clearField(2);

  /// The action that should be executed.
  @$pb.TagNumber(3)
  $core.String get action => $_getSZ(2);
  @$pb.TagNumber(3)
  set action($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAction() => $_has(2);
  @$pb.TagNumber(3)
  void clearAction() => $_clearField(3);
}

class UserList_User extends $pb.GeneratedMessage {
  factory UserList_User({
    $core.int? userId,
    $core.String? name,
    $core.String? lastSeen,
    $core.int? lastChannel,
  }) {
    final result = UserList_User._();
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (lastSeen != null) result.lastSeen = lastSeen;
    if (lastChannel != null) result.lastChannel = lastChannel;
    return result;
  }

  UserList_User._();

  factory UserList_User.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserList_User()..mergeFromBuffer(data, registry);
  factory UserList_User.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserList_User()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserList.User',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: UserList_User.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'userId', fieldType: $pb.PbFieldType.QU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'lastSeen')
    ..aI(4, _omitFieldNames ? '' : 'lastChannel',
        fieldType: $pb.PbFieldType.OU3);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserList_User clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserList_User copyWith(void Function(UserList_User) updates) =>
      super.copyWith((message) => updates(message as UserList_User))
          as UserList_User;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserList_User() / UserList_User.new instead')
  static UserList_User create() => UserList_User._();
  static $pb.GeneratedMessage $_createMessage() => UserList_User._();
  @$core.override
  UserList_User createEmptyInstance() => UserList_User._();
  @$core.pragma('dart2js:noInline')
  static UserList_User getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserList_User>(
          UserList_User.$_createMessage);
  static UserList_User? _defaultInstance;

  /// Registered user ID.
  @$pb.TagNumber(1)
  $core.int get userId => $_getIZ(0);
  @$pb.TagNumber(1)
  set userId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  /// Registered user name.
  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastSeen => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastSeen($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLastSeen() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastSeen() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get lastChannel => $_getIZ(3);
  @$pb.TagNumber(4)
  set lastChannel($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastChannel() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastChannel() => $_clearField(4);
}

/// Lists the registered users.
class UserList extends $pb.GeneratedMessage {
  factory UserList({
    $core.Iterable<UserList_User>? users,
  }) {
    final result = UserList._();
    if (users != null) result.users.addAll(users);
    return result;
  }

  UserList._();

  factory UserList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserList()..mergeFromBuffer(data, registry);
  factory UserList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: UserList.$_createMessage)
    ..pPM<UserList_User>(1, _omitFieldNames ? '' : 'users',
        subBuilder: UserList_User.$_createMessage);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserList copyWith(void Function(UserList) updates) =>
      super.copyWith((message) => updates(message as UserList)) as UserList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserList() / UserList.new instead')
  static UserList create() => UserList._();
  static $pb.GeneratedMessage $_createMessage() => UserList._();
  @$core.override
  UserList createEmptyInstance() => UserList._();
  @$core.pragma('dart2js:noInline')
  static UserList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserList>(UserList.$_createMessage);
  static UserList? _defaultInstance;

  /// A list of registered users.
  @$pb.TagNumber(1)
  $pb.PbList<UserList_User> get users => $_getList(0);
}

class VoiceTarget_Target extends $pb.GeneratedMessage {
  factory VoiceTarget_Target({
    $core.Iterable<$core.int>? session,
    $core.int? channelId,
    $core.String? group,
    $core.bool? links,
    $core.bool? children,
  }) {
    final result = VoiceTarget_Target._();
    if (session != null) result.session.addAll(session);
    if (channelId != null) result.channelId = channelId;
    if (group != null) result.group = group;
    if (links != null) result.links = links;
    if (children != null) result.children = children;
    return result;
  }

  VoiceTarget_Target._();

  factory VoiceTarget_Target.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      VoiceTarget_Target()..mergeFromBuffer(data, registry);
  factory VoiceTarget_Target.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      VoiceTarget_Target()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VoiceTarget.Target',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: VoiceTarget_Target.$_createMessage)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'session', $pb.PbFieldType.PU3)
    ..aI(2, _omitFieldNames ? '' : 'channelId', fieldType: $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'group')
    ..aOB(4, _omitFieldNames ? '' : 'links')
    ..aOB(5, _omitFieldNames ? '' : 'children')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VoiceTarget_Target clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VoiceTarget_Target copyWith(void Function(VoiceTarget_Target) updates) =>
      super.copyWith((message) => updates(message as VoiceTarget_Target))
          as VoiceTarget_Target;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use VoiceTarget_Target() / VoiceTarget_Target.new instead')
  static VoiceTarget_Target create() => VoiceTarget_Target._();
  static $pb.GeneratedMessage $_createMessage() => VoiceTarget_Target._();
  @$core.override
  VoiceTarget_Target createEmptyInstance() => VoiceTarget_Target._();
  @$core.pragma('dart2js:noInline')
  static VoiceTarget_Target getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VoiceTarget_Target>(
          VoiceTarget_Target.$_createMessage);
  static VoiceTarget_Target? _defaultInstance;

  /// Users that are included as targets.
  @$pb.TagNumber(1)
  $pb.PbList<$core.int> get session => $_getList(0);

  /// Channel that is included as a target.
  @$pb.TagNumber(2)
  $core.int get channelId => $_getIZ(1);
  @$pb.TagNumber(2)
  set channelId($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelId() => $_clearField(2);

  /// ACL group that is included as a target.
  @$pb.TagNumber(3)
  $core.String get group => $_getSZ(2);
  @$pb.TagNumber(3)
  set group($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGroup() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroup() => $_clearField(3);

  /// True if the voice should follow links from the specified channel.
  @$pb.TagNumber(4)
  $core.bool get links => $_getBF(3);
  @$pb.TagNumber(4)
  set links($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLinks() => $_has(3);
  @$pb.TagNumber(4)
  void clearLinks() => $_clearField(4);

  /// True if the voice should also be sent to children of the specific
  /// channel.
  @$pb.TagNumber(5)
  $core.bool get children => $_getBF(4);
  @$pb.TagNumber(5)
  set children($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChildren() => $_has(4);
  @$pb.TagNumber(5)
  void clearChildren() => $_clearField(5);
}

/// Sent by the client when it wants to register or clear whisper targets.
///
/// Note: The first available target ID is 1 as 0 is reserved for normal
/// talking. Maximum target ID is 30.
class VoiceTarget extends $pb.GeneratedMessage {
  factory VoiceTarget({
    $core.int? id,
    $core.Iterable<VoiceTarget_Target>? targets,
  }) {
    final result = VoiceTarget._();
    if (id != null) result.id = id;
    if (targets != null) result.targets.addAll(targets);
    return result;
  }

  VoiceTarget._();

  factory VoiceTarget.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      VoiceTarget()..mergeFromBuffer(data, registry);
  factory VoiceTarget.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      VoiceTarget()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VoiceTarget',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: VoiceTarget.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'id', fieldType: $pb.PbFieldType.OU3)
    ..pPM<VoiceTarget_Target>(2, _omitFieldNames ? '' : 'targets',
        subBuilder: VoiceTarget_Target.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VoiceTarget clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VoiceTarget copyWith(void Function(VoiceTarget) updates) =>
      super.copyWith((message) => updates(message as VoiceTarget))
          as VoiceTarget;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use VoiceTarget() / VoiceTarget.new instead')
  static VoiceTarget create() => VoiceTarget._();
  static $pb.GeneratedMessage $_createMessage() => VoiceTarget._();
  @$core.override
  VoiceTarget createEmptyInstance() => VoiceTarget._();
  @$core.pragma('dart2js:noInline')
  static VoiceTarget getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VoiceTarget>(
          VoiceTarget.$_createMessage);
  static VoiceTarget? _defaultInstance;

  /// Voice target ID.
  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// The receivers that this voice target includes.
  @$pb.TagNumber(2)
  $pb.PbList<VoiceTarget_Target> get targets => $_getList(1);
}

/// Sent by the client when it wants permissions for a certain channel. Sent by
/// the server when it replies to the query or wants the user to resync all
/// channel permissions.
class PermissionQuery extends $pb.GeneratedMessage {
  factory PermissionQuery({
    $core.int? channelId,
    $core.int? permissions,
    $core.bool? flush,
  }) {
    final result = PermissionQuery._();
    if (channelId != null) result.channelId = channelId;
    if (permissions != null) result.permissions = permissions;
    if (flush != null) result.flush = flush;
    return result;
  }

  PermissionQuery._();

  factory PermissionQuery.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PermissionQuery()..mergeFromBuffer(data, registry);
  factory PermissionQuery.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PermissionQuery()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PermissionQuery',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: PermissionQuery.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'channelId', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'permissions',
        fieldType: $pb.PbFieldType.OU3)
    ..aOB(3, _omitFieldNames ? '' : 'flush')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PermissionQuery clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PermissionQuery copyWith(void Function(PermissionQuery) updates) =>
      super.copyWith((message) => updates(message as PermissionQuery))
          as PermissionQuery;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PermissionQuery() / PermissionQuery.new instead')
  static PermissionQuery create() => PermissionQuery._();
  static $pb.GeneratedMessage $_createMessage() => PermissionQuery._();
  @$core.override
  PermissionQuery createEmptyInstance() => PermissionQuery._();
  @$core.pragma('dart2js:noInline')
  static PermissionQuery getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PermissionQuery>(
          PermissionQuery.$_createMessage);
  static PermissionQuery? _defaultInstance;

  /// channel_id of the channel for which the permissions are queried.
  @$pb.TagNumber(1)
  $core.int get channelId => $_getIZ(0);
  @$pb.TagNumber(1)
  set channelId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// Channel permissions.
  @$pb.TagNumber(2)
  $core.int get permissions => $_getIZ(1);
  @$pb.TagNumber(2)
  set permissions($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPermissions() => $_has(1);
  @$pb.TagNumber(2)
  void clearPermissions() => $_clearField(2);

  /// True if the client should drop its current permission information for all
  /// channels.
  @$pb.TagNumber(3)
  $core.bool get flush => $_getBF(2);
  @$pb.TagNumber(3)
  set flush($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFlush() => $_has(2);
  @$pb.TagNumber(3)
  void clearFlush() => $_clearField(3);
}

/// Sent by the server to notify the users of the version of the CELT codec they
/// should use. This may change during the connection when new users join.
class CodecVersion extends $pb.GeneratedMessage {
  factory CodecVersion({
    $core.int? alpha,
    $core.int? beta,
    $core.bool? preferAlpha,
    $core.bool? opus,
  }) {
    final result = CodecVersion._();
    if (alpha != null) result.alpha = alpha;
    if (beta != null) result.beta = beta;
    if (preferAlpha != null) result.preferAlpha = preferAlpha;
    if (opus != null) result.opus = opus;
    return result;
  }

  CodecVersion._();

  factory CodecVersion.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CodecVersion()..mergeFromBuffer(data, registry);
  factory CodecVersion.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CodecVersion()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CodecVersion',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: CodecVersion.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'alpha', fieldType: $pb.PbFieldType.Q3)
    ..aI(2, _omitFieldNames ? '' : 'beta', fieldType: $pb.PbFieldType.Q3)
    ..a<$core.bool>(3, _omitFieldNames ? '' : 'preferAlpha', $pb.PbFieldType.QB,
        defaultOrMaker: true)
    ..aOB(4, _omitFieldNames ? '' : 'opus');

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodecVersion clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodecVersion copyWith(void Function(CodecVersion) updates) =>
      super.copyWith((message) => updates(message as CodecVersion))
          as CodecVersion;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CodecVersion() / CodecVersion.new instead')
  static CodecVersion create() => CodecVersion._();
  static $pb.GeneratedMessage $_createMessage() => CodecVersion._();
  @$core.override
  CodecVersion createEmptyInstance() => CodecVersion._();
  @$core.pragma('dart2js:noInline')
  static CodecVersion getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CodecVersion>(
          CodecVersion.$_createMessage);
  static CodecVersion? _defaultInstance;

  /// The version of the CELT Alpha codec.
  @$pb.TagNumber(1)
  $core.int get alpha => $_getIZ(0);
  @$pb.TagNumber(1)
  set alpha($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAlpha() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlpha() => $_clearField(1);

  /// The version of the CELT Beta codec.
  @$pb.TagNumber(2)
  $core.int get beta => $_getIZ(1);
  @$pb.TagNumber(2)
  set beta($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBeta() => $_has(1);
  @$pb.TagNumber(2)
  void clearBeta() => $_clearField(2);

  /// True if the user should prefer Alpha over Beta.
  @$pb.TagNumber(3)
  $core.bool get preferAlpha => $_getB(2, true);
  @$pb.TagNumber(3)
  set preferAlpha($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPreferAlpha() => $_has(2);
  @$pb.TagNumber(3)
  void clearPreferAlpha() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get opus => $_getBF(3);
  @$pb.TagNumber(4)
  set opus($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOpus() => $_has(3);
  @$pb.TagNumber(4)
  void clearOpus() => $_clearField(4);
}

class UserStats_Stats extends $pb.GeneratedMessage {
  factory UserStats_Stats({
    $core.int? good,
    $core.int? late,
    $core.int? lost,
    $core.int? resync,
  }) {
    final result = UserStats_Stats._();
    if (good != null) result.good = good;
    if (late != null) result.late = late;
    if (lost != null) result.lost = lost;
    if (resync != null) result.resync = resync;
    return result;
  }

  UserStats_Stats._();

  factory UserStats_Stats.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserStats_Stats()..mergeFromBuffer(data, registry);
  factory UserStats_Stats.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserStats_Stats()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserStats.Stats',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: UserStats_Stats.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'good', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'late', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'lost', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'resync', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserStats_Stats clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserStats_Stats copyWith(void Function(UserStats_Stats) updates) =>
      super.copyWith((message) => updates(message as UserStats_Stats))
          as UserStats_Stats;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserStats_Stats() / UserStats_Stats.new instead')
  static UserStats_Stats create() => UserStats_Stats._();
  static $pb.GeneratedMessage $_createMessage() => UserStats_Stats._();
  @$core.override
  UserStats_Stats createEmptyInstance() => UserStats_Stats._();
  @$core.pragma('dart2js:noInline')
  static UserStats_Stats getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserStats_Stats>(
          UserStats_Stats.$_createMessage);
  static UserStats_Stats? _defaultInstance;

  /// The amount of good packets received.
  @$pb.TagNumber(1)
  $core.int get good => $_getIZ(0);
  @$pb.TagNumber(1)
  set good($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGood() => $_has(0);
  @$pb.TagNumber(1)
  void clearGood() => $_clearField(1);

  /// The amount of late packets received.
  @$pb.TagNumber(2)
  $core.int get late => $_getIZ(1);
  @$pb.TagNumber(2)
  set late($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLate() => $_has(1);
  @$pb.TagNumber(2)
  void clearLate() => $_clearField(2);

  /// The amount of packets never received.
  @$pb.TagNumber(3)
  $core.int get lost => $_getIZ(2);
  @$pb.TagNumber(3)
  set lost($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLost() => $_has(2);
  @$pb.TagNumber(3)
  void clearLost() => $_clearField(3);

  /// The amount of nonce resyncs.
  @$pb.TagNumber(4)
  $core.int get resync => $_getIZ(3);
  @$pb.TagNumber(4)
  set resync($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasResync() => $_has(3);
  @$pb.TagNumber(4)
  void clearResync() => $_clearField(4);
}

class UserStats_RollingStats extends $pb.GeneratedMessage {
  factory UserStats_RollingStats({
    $core.int? timeWindow,
    UserStats_Stats? fromClient,
    UserStats_Stats? fromServer,
  }) {
    final result = UserStats_RollingStats._();
    if (timeWindow != null) result.timeWindow = timeWindow;
    if (fromClient != null) result.fromClient = fromClient;
    if (fromServer != null) result.fromServer = fromServer;
    return result;
  }

  UserStats_RollingStats._();

  factory UserStats_RollingStats.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserStats_RollingStats()..mergeFromBuffer(data, registry);
  factory UserStats_RollingStats.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserStats_RollingStats()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserStats.RollingStats',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: UserStats_RollingStats.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'timeWindow', fieldType: $pb.PbFieldType.OU3)
    ..aOM<UserStats_Stats>(2, _omitFieldNames ? '' : 'fromClient',
        subBuilder: UserStats_Stats.$_createMessage)
    ..aOM<UserStats_Stats>(3, _omitFieldNames ? '' : 'fromServer',
        subBuilder: UserStats_Stats.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserStats_RollingStats clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserStats_RollingStats copyWith(
          void Function(UserStats_RollingStats) updates) =>
      super.copyWith((message) => updates(message as UserStats_RollingStats))
          as UserStats_RollingStats;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UserStats_RollingStats() / UserStats_RollingStats.new instead')
  static UserStats_RollingStats create() => UserStats_RollingStats._();
  static $pb.GeneratedMessage $_createMessage() => UserStats_RollingStats._();
  @$core.override
  UserStats_RollingStats createEmptyInstance() => UserStats_RollingStats._();
  @$core.pragma('dart2js:noInline')
  static UserStats_RollingStats getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserStats_RollingStats>(
          UserStats_RollingStats.$_createMessage);
  static UserStats_RollingStats? _defaultInstance;

  /// Rolling packet statistics time window as defined on the server.
  @$pb.TagNumber(1)
  $core.int get timeWindow => $_getIZ(0);
  @$pb.TagNumber(1)
  set timeWindow($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTimeWindow() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimeWindow() => $_clearField(1);

  /// Rolling packet statistics for packets received from the client.
  @$pb.TagNumber(2)
  UserStats_Stats get fromClient => $_getN(1);
  @$pb.TagNumber(2)
  set fromClient(UserStats_Stats value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFromClient() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromClient() => $_clearField(2);
  @$pb.TagNumber(2)
  UserStats_Stats ensureFromClient() => $_ensure(1);

  /// Rolling packet statistics for packets sent by the server.
  @$pb.TagNumber(3)
  UserStats_Stats get fromServer => $_getN(2);
  @$pb.TagNumber(3)
  set fromServer(UserStats_Stats value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFromServer() => $_has(2);
  @$pb.TagNumber(3)
  void clearFromServer() => $_clearField(3);
  @$pb.TagNumber(3)
  UserStats_Stats ensureFromServer() => $_ensure(2);
}

/// Used to communicate user stats between the server and clients.
class UserStats extends $pb.GeneratedMessage {
  factory UserStats({
    $core.int? session,
    $core.bool? statsOnly,
    $core.Iterable<$core.List<$core.int>>? certificates,
    UserStats_Stats? fromClient,
    UserStats_Stats? fromServer,
    $core.int? udpPackets,
    $core.int? tcpPackets,
    $core.double? udpPingAvg,
    $core.double? udpPingVar,
    $core.double? tcpPingAvg,
    $core.double? tcpPingVar,
    Version? version,
    $core.Iterable<$core.int>? celtVersions,
    $core.List<$core.int>? address,
    $core.int? bandwidth,
    $core.int? onlinesecs,
    $core.int? idlesecs,
    $core.bool? strongCertificate,
    $core.bool? opus,
    UserStats_RollingStats? rollingStats,
  }) {
    final result = UserStats._();
    if (session != null) result.session = session;
    if (statsOnly != null) result.statsOnly = statsOnly;
    if (certificates != null) result.certificates.addAll(certificates);
    if (fromClient != null) result.fromClient = fromClient;
    if (fromServer != null) result.fromServer = fromServer;
    if (udpPackets != null) result.udpPackets = udpPackets;
    if (tcpPackets != null) result.tcpPackets = tcpPackets;
    if (udpPingAvg != null) result.udpPingAvg = udpPingAvg;
    if (udpPingVar != null) result.udpPingVar = udpPingVar;
    if (tcpPingAvg != null) result.tcpPingAvg = tcpPingAvg;
    if (tcpPingVar != null) result.tcpPingVar = tcpPingVar;
    if (version != null) result.version = version;
    if (celtVersions != null) result.celtVersions.addAll(celtVersions);
    if (address != null) result.address = address;
    if (bandwidth != null) result.bandwidth = bandwidth;
    if (onlinesecs != null) result.onlinesecs = onlinesecs;
    if (idlesecs != null) result.idlesecs = idlesecs;
    if (strongCertificate != null) result.strongCertificate = strongCertificate;
    if (opus != null) result.opus = opus;
    if (rollingStats != null) result.rollingStats = rollingStats;
    return result;
  }

  UserStats._();

  factory UserStats.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserStats()..mergeFromBuffer(data, registry);
  factory UserStats.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserStats()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserStats',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: UserStats.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'session', fieldType: $pb.PbFieldType.OU3)
    ..aOB(2, _omitFieldNames ? '' : 'statsOnly')
    ..p<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'certificates', $pb.PbFieldType.PY)
    ..aOM<UserStats_Stats>(4, _omitFieldNames ? '' : 'fromClient',
        subBuilder: UserStats_Stats.$_createMessage)
    ..aOM<UserStats_Stats>(5, _omitFieldNames ? '' : 'fromServer',
        subBuilder: UserStats_Stats.$_createMessage)
    ..aI(6, _omitFieldNames ? '' : 'udpPackets', fieldType: $pb.PbFieldType.OU3)
    ..aI(7, _omitFieldNames ? '' : 'tcpPackets', fieldType: $pb.PbFieldType.OU3)
    ..aD(8, _omitFieldNames ? '' : 'udpPingAvg', fieldType: $pb.PbFieldType.OF)
    ..aD(9, _omitFieldNames ? '' : 'udpPingVar', fieldType: $pb.PbFieldType.OF)
    ..aD(10, _omitFieldNames ? '' : 'tcpPingAvg', fieldType: $pb.PbFieldType.OF)
    ..aD(11, _omitFieldNames ? '' : 'tcpPingVar', fieldType: $pb.PbFieldType.OF)
    ..aOM<Version>(12, _omitFieldNames ? '' : 'version',
        subBuilder: Version.$_createMessage)
    ..p<$core.int>(
        13, _omitFieldNames ? '' : 'celtVersions', $pb.PbFieldType.P3)
    ..a<$core.List<$core.int>>(
        14, _omitFieldNames ? '' : 'address', $pb.PbFieldType.OY)
    ..aI(15, _omitFieldNames ? '' : 'bandwidth', fieldType: $pb.PbFieldType.OU3)
    ..aI(16, _omitFieldNames ? '' : 'onlinesecs',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(17, _omitFieldNames ? '' : 'idlesecs', fieldType: $pb.PbFieldType.OU3)
    ..aOB(18, _omitFieldNames ? '' : 'strongCertificate')
    ..aOB(19, _omitFieldNames ? '' : 'opus')
    ..aOM<UserStats_RollingStats>(20, _omitFieldNames ? '' : 'rollingStats',
        subBuilder: UserStats_RollingStats.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserStats clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserStats copyWith(void Function(UserStats) updates) =>
      super.copyWith((message) => updates(message as UserStats)) as UserStats;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserStats() / UserStats.new instead')
  static UserStats create() => UserStats._();
  static $pb.GeneratedMessage $_createMessage() => UserStats._();
  @$core.override
  UserStats createEmptyInstance() => UserStats._();
  @$core.pragma('dart2js:noInline')
  static UserStats getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserStats>(UserStats.$_createMessage);
  static UserStats? _defaultInstance;

  /// User whose stats these are.
  @$pb.TagNumber(1)
  $core.int get session => $_getIZ(0);
  @$pb.TagNumber(1)
  set session($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => $_clearField(1);

  /// True if the message contains only mutable stats (packets, ping).
  @$pb.TagNumber(2)
  $core.bool get statsOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set statsOnly($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatsOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatsOnly() => $_clearField(2);

  /// Full user certificate chain of the user certificate in DER format.
  @$pb.TagNumber(3)
  $pb.PbList<$core.List<$core.int>> get certificates => $_getList(2);

  /// Packet statistics for packets received from the client.
  @$pb.TagNumber(4)
  UserStats_Stats get fromClient => $_getN(3);
  @$pb.TagNumber(4)
  set fromClient(UserStats_Stats value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFromClient() => $_has(3);
  @$pb.TagNumber(4)
  void clearFromClient() => $_clearField(4);
  @$pb.TagNumber(4)
  UserStats_Stats ensureFromClient() => $_ensure(3);

  /// Packet statistics for packets sent by the server.
  @$pb.TagNumber(5)
  UserStats_Stats get fromServer => $_getN(4);
  @$pb.TagNumber(5)
  set fromServer(UserStats_Stats value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFromServer() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromServer() => $_clearField(5);
  @$pb.TagNumber(5)
  UserStats_Stats ensureFromServer() => $_ensure(4);

  /// Amount of UDP packets sent.
  @$pb.TagNumber(6)
  $core.int get udpPackets => $_getIZ(5);
  @$pb.TagNumber(6)
  set udpPackets($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUdpPackets() => $_has(5);
  @$pb.TagNumber(6)
  void clearUdpPackets() => $_clearField(6);

  /// Amount of TCP packets sent.
  @$pb.TagNumber(7)
  $core.int get tcpPackets => $_getIZ(6);
  @$pb.TagNumber(7)
  set tcpPackets($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTcpPackets() => $_has(6);
  @$pb.TagNumber(7)
  void clearTcpPackets() => $_clearField(7);

  /// UDP ping average.
  @$pb.TagNumber(8)
  $core.double get udpPingAvg => $_getN(7);
  @$pb.TagNumber(8)
  set udpPingAvg($core.double value) => $_setFloat(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUdpPingAvg() => $_has(7);
  @$pb.TagNumber(8)
  void clearUdpPingAvg() => $_clearField(8);

  /// UDP ping variance.
  @$pb.TagNumber(9)
  $core.double get udpPingVar => $_getN(8);
  @$pb.TagNumber(9)
  set udpPingVar($core.double value) => $_setFloat(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUdpPingVar() => $_has(8);
  @$pb.TagNumber(9)
  void clearUdpPingVar() => $_clearField(9);

  /// TCP ping average.
  @$pb.TagNumber(10)
  $core.double get tcpPingAvg => $_getN(9);
  @$pb.TagNumber(10)
  set tcpPingAvg($core.double value) => $_setFloat(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTcpPingAvg() => $_has(9);
  @$pb.TagNumber(10)
  void clearTcpPingAvg() => $_clearField(10);

  /// TCP ping variance.
  @$pb.TagNumber(11)
  $core.double get tcpPingVar => $_getN(10);
  @$pb.TagNumber(11)
  set tcpPingVar($core.double value) => $_setFloat(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTcpPingVar() => $_has(10);
  @$pb.TagNumber(11)
  void clearTcpPingVar() => $_clearField(11);

  /// Client version.
  @$pb.TagNumber(12)
  Version get version => $_getN(11);
  @$pb.TagNumber(12)
  set version(Version value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasVersion() => $_has(11);
  @$pb.TagNumber(12)
  void clearVersion() => $_clearField(12);
  @$pb.TagNumber(12)
  Version ensureVersion() => $_ensure(11);

  /// A list of CELT bitstream version constants supported by the client of this
  /// user.
  @$pb.TagNumber(13)
  $pb.PbList<$core.int> get celtVersions => $_getList(12);

  /// Client IP address.
  @$pb.TagNumber(14)
  $core.List<$core.int> get address => $_getN(13);
  @$pb.TagNumber(14)
  set address($core.List<$core.int> value) => $_setBytes(13, value);
  @$pb.TagNumber(14)
  $core.bool hasAddress() => $_has(13);
  @$pb.TagNumber(14)
  void clearAddress() => $_clearField(14);

  /// Bandwidth used by this client.
  @$pb.TagNumber(15)
  $core.int get bandwidth => $_getIZ(14);
  @$pb.TagNumber(15)
  set bandwidth($core.int value) => $_setUnsignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasBandwidth() => $_has(14);
  @$pb.TagNumber(15)
  void clearBandwidth() => $_clearField(15);

  /// Connection duration.
  @$pb.TagNumber(16)
  $core.int get onlinesecs => $_getIZ(15);
  @$pb.TagNumber(16)
  set onlinesecs($core.int value) => $_setUnsignedInt32(15, value);
  @$pb.TagNumber(16)
  $core.bool hasOnlinesecs() => $_has(15);
  @$pb.TagNumber(16)
  void clearOnlinesecs() => $_clearField(16);

  /// Duration since last activity.
  @$pb.TagNumber(17)
  $core.int get idlesecs => $_getIZ(16);
  @$pb.TagNumber(17)
  set idlesecs($core.int value) => $_setUnsignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasIdlesecs() => $_has(16);
  @$pb.TagNumber(17)
  void clearIdlesecs() => $_clearField(17);

  /// True if the user has a strong certificate.
  @$pb.TagNumber(18)
  $core.bool get strongCertificate => $_getBF(17);
  @$pb.TagNumber(18)
  set strongCertificate($core.bool value) => $_setBool(17, value);
  @$pb.TagNumber(18)
  $core.bool hasStrongCertificate() => $_has(17);
  @$pb.TagNumber(18)
  void clearStrongCertificate() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.bool get opus => $_getBF(18);
  @$pb.TagNumber(19)
  set opus($core.bool value) => $_setBool(18, value);
  @$pb.TagNumber(19)
  $core.bool hasOpus() => $_has(18);
  @$pb.TagNumber(19)
  void clearOpus() => $_clearField(19);

  /// Rolling packet statistics
  @$pb.TagNumber(20)
  UserStats_RollingStats get rollingStats => $_getN(19);
  @$pb.TagNumber(20)
  set rollingStats(UserStats_RollingStats value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasRollingStats() => $_has(19);
  @$pb.TagNumber(20)
  void clearRollingStats() => $_clearField(20);
  @$pb.TagNumber(20)
  UserStats_RollingStats ensureRollingStats() => $_ensure(19);
}

/// Used by the client to request binary data from the server. By default large
/// comments or textures are not sent within standard messages but instead the
/// hash is. If the client does not recognize the hash it may request the
/// resource when it needs it. The client does so by sending a RequestBlob
/// message with the correct fields filled with the user sessions or channel_ids
/// it wants to receive. The server replies to this by sending a new
/// UserState/ChannelState message with the resources filled even if they would
/// normally be transmitted as hashes.
class RequestBlob extends $pb.GeneratedMessage {
  factory RequestBlob({
    $core.Iterable<$core.int>? sessionTexture,
    $core.Iterable<$core.int>? sessionComment,
    $core.Iterable<$core.int>? channelDescription,
  }) {
    final result = RequestBlob._();
    if (sessionTexture != null) result.sessionTexture.addAll(sessionTexture);
    if (sessionComment != null) result.sessionComment.addAll(sessionComment);
    if (channelDescription != null)
      result.channelDescription.addAll(channelDescription);
    return result;
  }

  RequestBlob._();

  factory RequestBlob.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RequestBlob()..mergeFromBuffer(data, registry);
  factory RequestBlob.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RequestBlob()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestBlob',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: RequestBlob.$_createMessage)
    ..p<$core.int>(
        1, _omitFieldNames ? '' : 'sessionTexture', $pb.PbFieldType.PU3)
    ..p<$core.int>(
        2, _omitFieldNames ? '' : 'sessionComment', $pb.PbFieldType.PU3)
    ..p<$core.int>(
        3, _omitFieldNames ? '' : 'channelDescription', $pb.PbFieldType.PU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestBlob clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestBlob copyWith(void Function(RequestBlob) updates) =>
      super.copyWith((message) => updates(message as RequestBlob))
          as RequestBlob;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RequestBlob() / RequestBlob.new instead')
  static RequestBlob create() => RequestBlob._();
  static $pb.GeneratedMessage $_createMessage() => RequestBlob._();
  @$core.override
  RequestBlob createEmptyInstance() => RequestBlob._();
  @$core.pragma('dart2js:noInline')
  static RequestBlob getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestBlob>(
          RequestBlob.$_createMessage);
  static RequestBlob? _defaultInstance;

  /// sessions of the requested UserState textures.
  @$pb.TagNumber(1)
  $pb.PbList<$core.int> get sessionTexture => $_getList(0);

  /// sessions of the requested UserState comments.
  @$pb.TagNumber(2)
  $pb.PbList<$core.int> get sessionComment => $_getList(1);

  /// channel_ids of the requested ChannelState descriptions.
  @$pb.TagNumber(3)
  $pb.PbList<$core.int> get channelDescription => $_getList(2);
}

/// Sent by the server when it informs the clients on server configuration
/// details.
class ServerConfig extends $pb.GeneratedMessage {
  factory ServerConfig({
    $core.int? maxBandwidth,
    $core.String? welcomeText,
    $core.bool? allowHtml,
    $core.int? messageLength,
    $core.int? imageMessageLength,
    $core.int? maxUsers,
    $core.bool? recordingAllowed,
  }) {
    final result = ServerConfig._();
    if (maxBandwidth != null) result.maxBandwidth = maxBandwidth;
    if (welcomeText != null) result.welcomeText = welcomeText;
    if (allowHtml != null) result.allowHtml = allowHtml;
    if (messageLength != null) result.messageLength = messageLength;
    if (imageMessageLength != null)
      result.imageMessageLength = imageMessageLength;
    if (maxUsers != null) result.maxUsers = maxUsers;
    if (recordingAllowed != null) result.recordingAllowed = recordingAllowed;
    return result;
  }

  ServerConfig._();

  factory ServerConfig.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ServerConfig()..mergeFromBuffer(data, registry);
  factory ServerConfig.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ServerConfig()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServerConfig',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: ServerConfig.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'maxBandwidth',
        fieldType: $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'welcomeText')
    ..aOB(3, _omitFieldNames ? '' : 'allowHtml')
    ..aI(4, _omitFieldNames ? '' : 'messageLength',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'imageMessageLength',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'maxUsers', fieldType: $pb.PbFieldType.OU3)
    ..aOB(7, _omitFieldNames ? '' : 'recordingAllowed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServerConfig clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServerConfig copyWith(void Function(ServerConfig) updates) =>
      super.copyWith((message) => updates(message as ServerConfig))
          as ServerConfig;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ServerConfig() / ServerConfig.new instead')
  static ServerConfig create() => ServerConfig._();
  static $pb.GeneratedMessage $_createMessage() => ServerConfig._();
  @$core.override
  ServerConfig createEmptyInstance() => ServerConfig._();
  @$core.pragma('dart2js:noInline')
  static ServerConfig getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ServerConfig>(
          ServerConfig.$_createMessage);
  static ServerConfig? _defaultInstance;

  /// The maximum bandwidth the clients should use.
  @$pb.TagNumber(1)
  $core.int get maxBandwidth => $_getIZ(0);
  @$pb.TagNumber(1)
  set maxBandwidth($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMaxBandwidth() => $_has(0);
  @$pb.TagNumber(1)
  void clearMaxBandwidth() => $_clearField(1);

  /// Server welcome text.
  @$pb.TagNumber(2)
  $core.String get welcomeText => $_getSZ(1);
  @$pb.TagNumber(2)
  set welcomeText($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWelcomeText() => $_has(1);
  @$pb.TagNumber(2)
  void clearWelcomeText() => $_clearField(2);

  /// True if the server allows HTML.
  @$pb.TagNumber(3)
  $core.bool get allowHtml => $_getBF(2);
  @$pb.TagNumber(3)
  set allowHtml($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAllowHtml() => $_has(2);
  @$pb.TagNumber(3)
  void clearAllowHtml() => $_clearField(3);

  /// Maximum text message length.
  @$pb.TagNumber(4)
  $core.int get messageLength => $_getIZ(3);
  @$pb.TagNumber(4)
  set messageLength($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessageLength() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessageLength() => $_clearField(4);

  /// Maximum image message length.
  @$pb.TagNumber(5)
  $core.int get imageMessageLength => $_getIZ(4);
  @$pb.TagNumber(5)
  set imageMessageLength($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasImageMessageLength() => $_has(4);
  @$pb.TagNumber(5)
  void clearImageMessageLength() => $_clearField(5);

  /// The maximum number of users allowed on the server.
  @$pb.TagNumber(6)
  $core.int get maxUsers => $_getIZ(5);
  @$pb.TagNumber(6)
  set maxUsers($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMaxUsers() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxUsers() => $_clearField(6);

  /// Whether using Mumble's recording feature is allowed on the server
  @$pb.TagNumber(7)
  $core.bool get recordingAllowed => $_getBF(6);
  @$pb.TagNumber(7)
  set recordingAllowed($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRecordingAllowed() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecordingAllowed() => $_clearField(7);
}

/// Sent by the server to inform the clients of suggested client configuration
/// specified by the server administrator.
class SuggestConfig extends $pb.GeneratedMessage {
  factory SuggestConfig({
    $core.int? versionV1,
    $core.bool? positional,
    $core.bool? pushToTalk,
    $fixnum.Int64? versionV2,
  }) {
    final result = SuggestConfig._();
    if (versionV1 != null) result.versionV1 = versionV1;
    if (positional != null) result.positional = positional;
    if (pushToTalk != null) result.pushToTalk = pushToTalk;
    if (versionV2 != null) result.versionV2 = versionV2;
    return result;
  }

  SuggestConfig._();

  factory SuggestConfig.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SuggestConfig()..mergeFromBuffer(data, registry);
  factory SuggestConfig.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SuggestConfig()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SuggestConfig',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: SuggestConfig.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'versionV1', fieldType: $pb.PbFieldType.OU3)
    ..aOB(2, _omitFieldNames ? '' : 'positional')
    ..aOB(3, _omitFieldNames ? '' : 'pushToTalk')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'versionV2', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SuggestConfig clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SuggestConfig copyWith(void Function(SuggestConfig) updates) =>
      super.copyWith((message) => updates(message as SuggestConfig))
          as SuggestConfig;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SuggestConfig() / SuggestConfig.new instead')
  static SuggestConfig create() => SuggestConfig._();
  static $pb.GeneratedMessage $_createMessage() => SuggestConfig._();
  @$core.override
  SuggestConfig createEmptyInstance() => SuggestConfig._();
  @$core.pragma('dart2js:noInline')
  static SuggestConfig getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SuggestConfig>(
          SuggestConfig.$_createMessage);
  static SuggestConfig? _defaultInstance;

  /// Suggested client version in the legacy format.
  @$pb.TagNumber(1)
  $core.int get versionV1 => $_getIZ(0);
  @$pb.TagNumber(1)
  set versionV1($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersionV1() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersionV1() => $_clearField(1);

  /// True if the administrator suggests positional audio to be used on this
  /// server.
  @$pb.TagNumber(2)
  $core.bool get positional => $_getBF(1);
  @$pb.TagNumber(2)
  set positional($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPositional() => $_has(1);
  @$pb.TagNumber(2)
  void clearPositional() => $_clearField(2);

  /// True if the administrator suggests push to talk to be used on this server.
  @$pb.TagNumber(3)
  $core.bool get pushToTalk => $_getBF(2);
  @$pb.TagNumber(3)
  set pushToTalk($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPushToTalk() => $_has(2);
  @$pb.TagNumber(3)
  void clearPushToTalk() => $_clearField(3);

  /// Suggested client version in the new format.
  /// Necessary since patch level may exceed 255. (See https://github.com/mumble-voip/mumble/issues/5827)
  @$pb.TagNumber(4)
  $fixnum.Int64 get versionV2 => $_getI64(3);
  @$pb.TagNumber(4)
  set versionV2($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasVersionV2() => $_has(3);
  @$pb.TagNumber(4)
  void clearVersionV2() => $_clearField(4);
}

/// Used to send plugin messages between clients
class PluginDataTransmission extends $pb.GeneratedMessage {
  factory PluginDataTransmission({
    $core.int? senderSession,
    $core.Iterable<$core.int>? receiverSessions,
    $core.List<$core.int>? data,
    $core.String? dataID,
  }) {
    final result = PluginDataTransmission._();
    if (senderSession != null) result.senderSession = senderSession;
    if (receiverSessions != null)
      result.receiverSessions.addAll(receiverSessions);
    if (data != null) result.data = data;
    if (dataID != null) result.dataID = dataID;
    return result;
  }

  PluginDataTransmission._();

  factory PluginDataTransmission.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PluginDataTransmission()..mergeFromBuffer(data, registry);
  factory PluginDataTransmission.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PluginDataTransmission()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PluginDataTransmission',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'MumbleProto'),
      createEmptyInstance: PluginDataTransmission.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'senderSession',
        protoName: 'senderSession', fieldType: $pb.PbFieldType.OU3)
    ..p<$core.int>(
        2, _omitFieldNames ? '' : 'receiverSessions', $pb.PbFieldType.KU3,
        protoName: 'receiverSessions')
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..aOS(4, _omitFieldNames ? '' : 'dataID', protoName: 'dataID')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PluginDataTransmission clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PluginDataTransmission copyWith(
          void Function(PluginDataTransmission) updates) =>
      super.copyWith((message) => updates(message as PluginDataTransmission))
          as PluginDataTransmission;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use PluginDataTransmission() / PluginDataTransmission.new instead')
  static PluginDataTransmission create() => PluginDataTransmission._();
  static $pb.GeneratedMessage $_createMessage() => PluginDataTransmission._();
  @$core.override
  PluginDataTransmission createEmptyInstance() => PluginDataTransmission._();
  @$core.pragma('dart2js:noInline')
  static PluginDataTransmission getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PluginDataTransmission>(
          PluginDataTransmission.$_createMessage);
  static PluginDataTransmission? _defaultInstance;

  /// The session ID of the client this message was sent from
  @$pb.TagNumber(1)
  $core.int get senderSession => $_getIZ(0);
  @$pb.TagNumber(1)
  set senderSession($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSenderSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderSession() => $_clearField(1);

  /// The session IDs of the clients that should receive this message
  @$pb.TagNumber(2)
  $pb.PbList<$core.int> get receiverSessions => $_getList(1);

  /// The data that is sent
  @$pb.TagNumber(3)
  $core.List<$core.int> get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => $_clearField(3);

  /// The ID of the sent data. This will be used by plugins to check whether they will
  /// process it or not
  @$pb.TagNumber(4)
  $core.String get dataID => $_getSZ(3);
  @$pb.TagNumber(4)
  set dataID($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDataID() => $_has(3);
  @$pb.TagNumber(4)
  void clearDataID() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
