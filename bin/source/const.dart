import 'dart:io';

import 'download_upload.dart';

mixin Settings {
  static const String db_fileName = '\\appData\\Local\\Coner\\userDB.db';
  static const String programNameCompiled = 'bub.exe';
  static const String telegramApi = '';
  static String programDir =
      '${Downloader().userProfile}\\AppData\\Local\\Coner';
}
