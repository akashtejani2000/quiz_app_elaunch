import 'package:get/get.dart';
import 'package:quize_app_elaunch/common/quiz_type_enum.dart';
import 'package:quize_app_elaunch/routs/app_routs.dart';
import 'package:quize_app_elaunch/screen/result_page/result_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultController extends GetxController {
  var result = Get.find<ResultDataModel>(tag: "result_data");

  bool isLevelUpdated = true;
  int nextLevel;

  SharedPreferences prefs;

  nextLevelQuiz() async {
    result.correctAnswer = 0;
    result.wrongAnswer = 0;

    result.currentIndex = 0;
    result.startTime = 10;

    result.isSelectOp1 = false;
    result.isSelectOp2 = false;
    result.isSelectOp3 = false;
    result.isSelectOp4 = false;

    result.selectRadioGroup = RadioEnum.none;

    result.checkString = "";

    result.answerController.clear();

    result.isChecked.clear();

    result.getData.clear();

    nextQuizLevel();
    Get.offAllNamed(AppRoute.quizLevelScreen);
    update();
  }

  // resetQuiz() async {
  //   result.correctAnswer = 0;
  //   result.wrongAnswer = 0;
  //
  //   result.currentIndex = 0;
  //   result.startTime = 10;
  //
  //   result.isSelectOp1 = false;
  //   result.isSelectOp2 = false;
  //   result.isSelectOp3 = false;
  //   result.isSelectOp4 = false;
  //
  //   result.selectRadioGroup = RadioEnum.none;
  //
  //   result.checkString = "";
  //
  //   result.answerController.clear();
  //
  //   result.isChecked.clear();
  //
  //   result.getData.clear();
  //
  //   prefs.clear();
  //
  //   nextQuizLevel();
  //   Get.offAllNamed(AppRoute.quizLevelScreen);
  //   update();
  // }

  nextQuizLevel() async {
    nextLevel = result.level + 1;
    prefs = await SharedPreferences.getInstance();
    var value = prefs.setInt("level", nextLevel);
    print("shared pre :${value.toString()}");

    update();
  }
}
