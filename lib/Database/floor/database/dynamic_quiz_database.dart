import 'dart:async';

import 'package:floor/floor.dart';
import 'package:quize_app_elaunch/Database/floor/dao/dynamic_quiz_dao.dart';
import 'package:quize_app_elaunch/Database/floor/model/dynamic_quiz_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'dynamic_quiz_database.g.dart';

@Database(version: 1, entities: [QuizData])
abstract class DynamicQuizDatabase extends FloorDatabase {
  DynamicQuizDao get dynamicQuizDao;
}
