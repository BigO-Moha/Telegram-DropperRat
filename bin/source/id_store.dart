import 'dart:async';
import 'dart:math';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'const.dart';
import 'download_upload.dart';

class User_DB {
  final String db_path = '${Downloader().userProfile}${Settings.db_fileName}';
  DatabaseFactory dbFactory = databaseFactoryIo;
  var userId = intMapStoreFactory.store('my_Id');

  Future<String> writeTodb() async {
    try {
      var db = await dbFactory.openDatabase(db_path);
      var userGenID = await random(1, 100000);
      var key = await userId.add(db, {'UIDC': userGenID.toString()});
      var record = await userId.record(key).getSnapshot(db);
      return record.value.values.first.toString();
    } on Error catch (e) {
      print(e);
    }
  }

  // ignore: missing_return
  Future<String> readUserId() async {
    try {
      var db = await dbFactory.openDatabase(db_path);
      var records = (await userId.find(db,
          finder: Finder(filter: Filter.matches('UIDC', ''))));
      print(records.first.value);
      return records.first.value.values.first;
    } on Error catch (e) {
      return null;
    }
  }

  int random(min, max) {
    var rn = Random();
    return min + rn.nextInt(max - min);
  }

  Future<String> checkAndGet() async {
    var userId = await readUserId();
    if (userId == null) {
      var key = await writeTodb();
      return key;
    } else {
      return await readUserId().then((value) {
        return value;
      });
    }
  }

  @override
  String toString() => 'User_DB(dbFactory: $dbFactory)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User_DB && o.dbFactory == dbFactory;
  }

  @override
  int get hashCode => dbFactory.hashCode;
}
