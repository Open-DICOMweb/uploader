library odw.sdk.core.system;

import 'dart:io';

class System {

  static void config([file='config.json']) {
    //TODO: finish
  }

  static String _fmtEnv(Map map) {
    String s = '{\n';
    String f(String name, String values) => s += '\t\t$name: $values\n';
    map.forEach(f);
    return s += '\t}';
  }

  static String info([String msg = "ODW SDK"]) => '''
$msg
  Platform:
    Executable: ${Platform.executable} resolved to: ${Platform.resolvedExecutable}
    Args: ${Platform.executableArguments}
    Local Hostname: ${Platform.localHostname}
    Pid: $pid
    Processors: ${Platform.numberOfProcessors}
    Env: ${_fmtEnv(Platform.environment)}
    OS: ${Platform.operatingSystem}
    //TODO: Fix so the name is correct
    Charset: ${SYSTEM_ENCODING.name}
    //TODO: fix - needs async proc
    NetworkInterface: ${NetworkInterface.list(includeLoopback: true, includeLinkLocal: true)}
    Dart:
      script: ${Platform.script}
      version: ${Platform.version}
      packageRoot: ${Platform.packageRoot}
      packageConfig: ${Platform.packageConfig}
  ODW SDK
    Core Version: 0.1.1-Dev.0.5
    Client Version: x.y
    Server Version: a.b
  Directory:
    base: ${Directory.current}
    temp: ${Directory.systemTemp}
    isWatchSupported: ${FileSystemEntity.isWatchSupported}
''';

}
