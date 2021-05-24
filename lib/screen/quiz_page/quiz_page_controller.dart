import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/floor/dao/quiz_dao.dart';
import 'package:quize_app_elaunch/floor/database/quiz_database.dart';
import 'package:quize_app_elaunch/floor/db_helper.dart';
import 'package:quize_app_elaunch/floor/model/quiz_data.dart';
import 'package:quize_app_elaunch/routs/app_routs.dart';

class QuizPageController extends GetxController {
  QuizDatabase quizDatabase;
  QuizDao quizDao;

  RxInt timer = 10.obs;
  RxString showTimer = "10".obs;
  RxBool cancelTimer = false.obs;
  Color rightAnsColor = Colors.green;
  Color wrongAnsColor = Colors.red;
  RxInt currentQuestion = 0.obs;
  RxBool disableAnswer = false.obs;
  RxInt rightAns = 0.obs;
  RxInt wrongAns = 0.obs;

  RxBool onTap = false.obs;

  Timer time;

  Stream<List<QuizDetails>> dataStream;

  // ignore: cancel_subscriptions
  StreamSubscription subscription;
  List<QuizDetails> quizData = [];

  RxList<OptionMenu> optionMenu = RxList<OptionMenu>();

  @override
  void onInit() {
    super.onInit();
    copyDB();

    builder();

    update();
  }

  builder() async {
    quizDatabase = await $FloorQuizDatabase.databaseBuilder('quiz.db').build();
    quizDao = quizDatabase.quizDao;
    dataStream = quizDao?.getAllData();
    try {
      subscription = quizDao.getAllData().listen((event) {
        print("stream updated");
        quizData = event;

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

        startTimer();
      });
    } catch (e) {
      print(e);
    }
    update();
  }

  checkAnswer(int index) async {
    if (!onTap.value) {
      onTap.value = true;
      var op = optionMenu[index];
      if (optionMenu[index].title.toString() == quizData[currentQuestion.value].answer) {
        op.color = rightAnsColor;
        optionMenu[index] = op;
        rightAns += 1;
      } else {
        op.color = wrongAnsColor;
        optionMenu[index] = op;
        wrongAns += 1;
      }
      cancelTimer.value = true;
      disableAnswer.value = true;
      Timer(Duration(seconds: 2), quizPositionNext);
      update();
    }
  }

  quizPositionNext() async {
    optionMenu.clear();
    cancelTimer.value = false;

    if (currentQuestion.value < quizData.length - 1) {
      timer.value = 10;
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
      startTimer();
      print("current : ${currentQuestion.value}");
    } else {
      time?.cancel();
      Get.toNamed(AppRoute.resultPage);
    }
  }

  void startTimer() async {
    time?.cancel();
    const oneSecond = Duration(seconds: 1);
    if (onTap.value) {
      onTap.value = false;
      update();
    }
    time = Timer.periodic(oneSecond, (Timer t) {
      if (timer < 1) {
        t.cancel();
        cancelTimer.value = true;
        disableAnswer.value = true;
        wrongAns++;
        quizPositionNext();
      } else if (cancelTimer.value == true) {
        t.cancel();
      } else {
        timer = timer - 1;
        update();
      }
      showTimer.value = timer.string;
    });
    update();
  }
}

class OptionMenu {
  String title;
  Color color;

  OptionMenu({this.color, this.title});
}
