import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/floor/dao/quiz_dao.dart';
import 'package:quize_app_elaunch/floor/database/quiz_database.dart';
import 'package:quize_app_elaunch/floor/db_helper.dart';
import 'package:quize_app_elaunch/floor/model/quiz_data.dart';

class QuizPageController extends GetxController {
  QuizDatabase quizDatabase;
  QuizDao quizDao;

  RxInt timer = 30.obs;
  RxString showTimer = "30".obs;
  RxBool cancelTimer = false.obs;
  Color rightAnsColor = Colors.green;
  Color wrongAnsColor = Colors.red;
  RxInt currentQuestion = 0.obs;
  RxBool disableAnswer = false.obs;
  RxInt rightAns = 0.obs;
  RxInt wrongAns = 0.obs;

  Timer time;

  Stream<List<QuizDetails>> dataStream;
  StreamSubscription subscription;
  List<QuizDetails> quizData = [];

  // RxList<Color> buttonColor = [
  //   Colors.indigo,
  //   Colors.indigo,
  //   Colors.indigo,
  //   Colors.indigo,
  // ].obs;

  RxList<OptionMenu> optionMenu = RxList<OptionMenu>();

  @override
  void onInit() {
    super.onInit();
    copyDB();
    builder();
    startTimer();
    optionMenu.add(
      OptionMenu(color: Colors.indigo, title: quizData[currentQuestion.value].option1),
    );
    optionMenu.add(
      OptionMenu(color: Colors.indigo, title: quizData[currentQuestion.value].option2),
    );
    optionMenu.add(
      OptionMenu(color: Colors.indigo, title: quizData[currentQuestion.value].option3),
    );
    optionMenu.add(
      OptionMenu(color: Colors.indigo, title: quizData[currentQuestion.value].option4),
    );

    print(optionMenu);
    update();
  }

  builder() async {
    quizDatabase = await $FloorQuizDatabase.databaseBuilder('quiz.db').build();
    quizDao = quizDatabase.quizDao;
    dataStream = quizDao?.getAllData();
    try {
      subscription = quizDao.getAllData().listen((event) {
        quizData = event;
      });
    } catch (e) {
      print(e);
    }
    update();
  }

  checkAnswer(int index) async {
    if (optionMenu[index].title.toString() == quizData[currentQuestion.value].answer) {
      var op = optionMenu[index];
      op.color = rightAnsColor;
      optionMenu[index] = op;
      rightAns++;
      print("Color : Green");
    } else {
      var op = optionMenu[index];
      op.color = wrongAnsColor;
      optionMenu[index] = op;
      wrongAns++;
      print("color : Red");
    }
    cancelTimer.value = true;
    disableAnswer.value = true;
    Timer(Duration(seconds: 1), quizPositionNext);
    update();
  }

  quizPositionNext() async {
    optionMenu.clear();
    cancelTimer.value = false;
    timer.value = 30;
    startTimer();
    if (currentQuestion.value < quizData.length - 1) {
      currentQuestion.value++;
      optionMenu.add(
        OptionMenu(color: Colors.indigo, title: quizData[currentQuestion.value].option1),
      );
      optionMenu.add(
        OptionMenu(color: Colors.indigo, title: quizData[currentQuestion.value].option2),
      );
      optionMenu.add(
        OptionMenu(color: Colors.indigo, title: quizData[currentQuestion.value].option3),
      );
      optionMenu.add(
        OptionMenu(color: Colors.indigo, title: quizData[currentQuestion.value].option4),
      );
    } else {
      openAndCloseLoadingDialog();
    }
    update();
  }

  void startTimer() async {
    time?.cancel();
    const oneSecond = Duration(seconds: 1);
    time = Timer.periodic(oneSecond, (Timer t) {
      if (timer < 1) {
        t.cancel();
        quizPositionNext();
      } else if (cancelTimer.value == true) {
        t.cancel();
      } else {
        timer = timer - 1;
        update();
      }
      showTimer.value = timer.string;
      print(showTimer);
    });
    update();
  }

  Future<void> openAndCloseLoadingDialog() async {
    showDialog(
      context: Get.overlayContext,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 10,
            ),
          ),
        ),
      ),
    );
    await Future.delayed(Duration(seconds: 1));
    Get.dialog(
      AlertDialog(
        title: Text("Finish Game"),
        content: Text("This should not be closed automatically"),
        actions: <Widget>[
          FlatButton(
            child: Text("CLOSE"),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
      barrierDismissible: false,
    );

    await Future.delayed(Duration(seconds: 3));

    Navigator.of(Get.overlayContext).pop();
  }
}

class OptionMenu {
  String title;
  Color color;

  OptionMenu({this.color, this.title});
}
