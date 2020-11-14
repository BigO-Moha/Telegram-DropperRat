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
      getCurrentDir();
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

  Future<File> getFile(String filename) async {
    return await File(filename);
  }

  Future<String> excuteProgram(String path) async {
    try {
      await shell.run(path, []);
      return '$path  Running';
    } catch (e) {
      return '$path is not runnig';
    }
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
