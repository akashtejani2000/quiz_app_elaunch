import 'package:floor/floor.dart';
import 'package:quize_app_elaunch/Database/floor/model/dynamic_quiz_model.dart';

@dao
abstract class DynamicQuizDao {
  @Query('SELECT * from DynamicQuiz')
  Stream<List<QuizData>> getAllData();

  @Query('SELECT * from DynamicQuiz where level=:level')
  Stream<List<QuizData>> getDataByLevel(int level);
}
