import 'dart:async';

import 'package:floor/floor.dart';
import 'package:quize_app_elaunch/floor/dao/quiz_dao.dart';
import 'package:quize_app_elaunch/floor/model/quiz_data.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'quiz_database.g.dart';

@Database(version: 1, entities: [QuizQuestion, QuizQuestionOption, QuizAnswer, QuizDetails])
abstract class QuizDatabase extends FloorDatabase {
  QuizDao get quizDao;
}
