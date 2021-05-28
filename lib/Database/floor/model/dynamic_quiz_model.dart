import 'package:floor/floor.dart';

@entity
class QuizData {
  @primaryKey
  int id;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String answer;
  String type;

  QuizData({this.id, this.question, this.option1, this.option2, this.option3, this.option4, this.answer, this.type});
}
