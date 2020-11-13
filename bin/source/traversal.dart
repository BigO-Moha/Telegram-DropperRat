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

  String getListFiles() {
    try {
      var dir = getCurrentDir();
      var files = fs.directory(dir);
      var listFile = files.listSync(recursive: false, followLinks: false);
      return listFile.toString();
    } catch (e) {
      print(e);
    }
  }

  String getCurrentDir() {
    return shell.workingDirectory;
  }

  File getFile(String filename) {
    return File(filename);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Traverslar &&
      o.password == password;
  }

  @override
  int get hashCode => password.hashCode;

  @override
  String toString() => 'Traverslar(password: $password)';
}
