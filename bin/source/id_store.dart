import 'dart:async';
import 'dart:math';

import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'const.dart';
import 'download_upload.dart';

class User_DB {
  final String db_path = '${Downloader().userProfile}${Settings.db_fileName}';
  DatabaseFactory dbFactory = databaseFactoryIo;
  var userId = intMapStoreFactory.store('my_Id');

  Future<String> writeTodb() async {
    var db = await dbFactory.openDatabase(db_path);
    var key = await userId.add(db, {'UIDC': await random(1, 100000)});
    var record = await userId.record(key).getSnapshot(db);
    print(record.value.values.first.toString());
    return record.value.values.first.toString();
  }

  // ignore: missing_return
  Future<String> readUserId() async {
    try {
      var db = await dbFactory.openDatabase(db_path);
      var value = (await userId.find(db,
          finder: Finder(filter: Filter.matches('UIDC', '^'))));
      if (value != null) {
        print(value.first.value.values.first.toString());
        return value.first.value.values.first.toString();
      }
    } on Error catch (e) {
      return null;
    }
  }

  int random(min, max) {
    var rn = Random();
    return min + rn.nextInt(max - min);
  }

  Future<String> checkAndGet() async {
    if (await readUserId() == null) {
      var key = await writeTodb();
      return key;
    } else {
      return readUserId();
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
