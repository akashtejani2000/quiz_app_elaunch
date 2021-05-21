import 'package:floor/floor.dart';
import 'package:quize_app_elaunch/floor/model/quiz_data.dart';

@dao
abstract class QuizDao {
  @Query('SELECT * from QuizQuestion')
  Stream<List<QuizQuestion>> getAllQuestion();

  // @Query('SELECT * from quizeOption')
  // Stream<List<QuizQuestionOption>> getAllOption();
  //
  @Query(
      'SELECT QuizQuestion.question, QuizQuestionOption.option1,QuizQuestionOption.option2,QuizQuestionOption.option3,QuizQuestionOption.option4,QuizAnswer.answer FROM QuizQuestion INNER JOIN QuizQuestionOption ON QuizQuestion.id = QuizQuestionOption.id INNER JOIN QuizAnswer ON QuizQuestion.id = QuizAnswer.id')
  Stream<List<QuizDetails>> getAllData();
}
