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
  Color colorShow = Colors.indigo;
  Color rightAns = Colors.green;
  Color wrongAns = Colors.red;
  RxInt currentQuestion = 0.obs;
  RxInt mark = 0.obs;

  Timer time;

  List<QuizQuestionOption> quizOption = [];
  Stream<List<QuizDetails>> dataStream;
  List<QuizDetails> quizDetails = [];
  StreamSubscription subscription;
  List<QuizDetails> quizData = [];

  List<Color> buttonColor = [
    Colors.indigo,
    Colors.indigo,
    Colors.indigo,
    Colors.indigo,
  ];

  @override
  void onInit() {
    super.onInit();
    copyDB();
    builder();
    startTimer();
    print(quizData.length);
    update();
  }

  builder() async {
    quizDatabase = await $FloorQuizDatabase.databaseBuilder('quiz.db').build();
    quizDao = quizDatabase.quizDao;
    dataStream = quizDao.getAllData();
    try {
      subscription = quizDao.getAllData().listen((event) {
        quizData = event;
        print("event : ${quizData.length}");
      });
    } catch (e) {
      print(e);
    }
    update();
  }

  checkAnswer(String ans) async {
    if (quizData[currentQuestion.value].option1 == quizData[currentQuestion.value].answer ||
        quizData[currentQuestion.value].option2 == quizData[currentQuestion.value].answer ||
        quizData[currentQuestion.value].option3 == quizData[currentQuestion.value].answer ||
        quizData[currentQuestion.value].option4 == quizData[currentQuestion.value].answer) {
      colorShow = rightAns;
      mark.value = mark.value + 1;
      quizPositionNext();
      update();
    } else {
      colorShow = wrongAns;
      print("Wrong Color : ${colorShow.toString()}");
    }

    update();
  }

  quizPositionNext() async {
    cancelTimer.value = false;
    timer.value = 30;
    startTimer();
    if (currentQuestion.value < quizData.length - 1) {
      currentQuestion.value++;
      print(currentQuestion.value);
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
