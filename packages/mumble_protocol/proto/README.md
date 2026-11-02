# proto/

这里的 `.proto` 文件**原样 vendor** 自 [mumble-voip/mumble](https://github.com/mumble-voip/mumble) 的 `src/` 目录。

| 文件 | 来源 | 许可 |
|---|---|---|
| `Mumble.proto` | `src/Mumble.proto` | BSD-3-Clause（文件头已注明） |
| `MumbleUDP.proto` | `src/MumbleUDP.proto` | BSD-3-Clause（文件头已注明） |

**不要手改这两个文件。** 需要跟进上游时重新下载并重新生成：

```bash
# 1) 同步 proto
curl -sSL -o proto/Mumble.proto    https://raw.githubusercontent.com/mumble-voip/mumble/master/src/Mumble.proto
curl -sSL -o proto/MumbleUDP.proto https://raw.githubusercontent.com/mumble-voip/mumble/master/src/MumbleUDP.proto

# 2) 重新生成（需要 protoc + dart pub global activate protoc_plugin）
protoc --proto_path=proto --dart_out=lib/src/proto \
       --plugin=protoc-gen-dart=<pub-cache>/bin/protoc-gen-dart.bat \
       proto/Mumble.proto proto/MumbleUDP.proto
```

生成物（`lib/src/proto/*.pb.dart`）提交进仓库，这样 CI 与本地构建不需要装 protoc。
