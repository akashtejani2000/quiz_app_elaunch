import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:quize_app_elaunch/common/string.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> copyDB() async {
  var dbPath = await getDatabasesPath();
  var path = join(dbPath, dbName);

  print(path);

  var exits = await databaseExists(path);
  if (!exits) {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (e) {
      print(e);
    }
    ByteData data = await rootBundle.load(("assets/dbFile/quiz.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print("DB exited");
  }
  return await openDatabase(path, readOnly: true);
}
