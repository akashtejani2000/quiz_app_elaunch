import 'package:flutter/cupertino.dart';
import 'package:quize_app_elaunch/Database/floor/model/dynamic_quiz_model.dart';
import 'package:quize_app_elaunch/common/quiz_type_enum.dart';

class ResultDataModel {
  int correctAnswer;
  int wrongAnswer;
  List<QuizData> getData;
  Stream<List<QuizData>> streamData;
  int currentIndex;
  int startTime;
  bool isSelectOp1, isSelectOp2, isSelectOp3, isSelectOp4;
  RadioEnum selectRadioGroup;
  String checkString;
  TextEditingController answerController;
  List<dynamic> isChecked;
  int level;

  ResultDataModel({
    this.correctAnswer,
    this.wrongAnswer,
    this.getData,
    this.streamData,
    this.currentIndex,
    this.isSelectOp1,
    this.isSelectOp2,
    this.isSelectOp3,
    this.isSelectOp4,
    this.selectRadioGroup,
    this.checkString,
    this.answerController,
    this.isChecked,
    this.startTime,
    this.level,
  });
}
