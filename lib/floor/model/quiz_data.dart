import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

@entity
class QuizQuestion {
  @primaryKey
  int id;
  String question;

  QuizQuestion({this.id, this.question});
}

@entity
class QuizQuestionOption {
  @primaryKey
  int id;
  String option1, option2, option3, option4;

  QuizQuestionOption({this.id, this.option1, this.option2, this.option3, this.option4});
}

@entity
class QuizAnswer {
  @primaryKey
  int id;
  String answer;

  QuizAnswer({this.id, this.answer});
}

@entity
class QuizDetails {
  @primaryKey
  int id;
  String question;
  String option1, option2, option3, option4;
  String answer;

  QuizDetails({this.id, this.question, this.option1, this.option2, this.option3, this.option4, this.answer});
}
