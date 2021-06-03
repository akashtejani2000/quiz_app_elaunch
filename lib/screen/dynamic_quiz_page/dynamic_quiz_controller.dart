import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/Database/floor/dao/dynamic_quiz_dao.dart';
import 'package:quize_app_elaunch/Database/floor/database/dynamic_quiz_database.dart';
import 'package:quize_app_elaunch/Database/floor/model/dynamic_quiz_model.dart';
import 'package:quize_app_elaunch/common/db_helper.dart';
import 'package:quize_app_elaunch/common/quiz_type_enum.dart';
import 'package:quize_app_elaunch/common/widget.dart';
import 'package:quize_app_elaunch/routs/app_routs.dart';

String enumToString(Object o) => o.toString().split('.').last;

T enumFromString<T>(String key, List<T> values) => values.firstWhere((v) => key == enumToString(v), orElse: () => null);

class DynamicQuizController extends GetxController {
  DynamicQuizDao dynamicQuizDao;
  DynamicQuizDatabase dynamicQuizDatabase;

  RxInt currentIndex = 0.obs;

  TextEditingController answerController = TextEditingController();

  Stream<List<QuizData>> streamData;
  RxList<QuizData> getData = <QuizData>[].obs;
  StreamSubscription subscription;
  RxBool checkLength = false.obs;

  RxString checkString = "".obs;

  Color rightAnsColor = Colors.green;
  Color wrongAnsColor = Colors.red;

  Color colorShow = Colors.indigo;
  Color opBrgAns1 = Colors.indigo;
  Color opBrgAns2 = Colors.indigo;
  Color opBrgAns3 = Colors.indigo;
  Color opBrgAns4 = Colors.indigo;

  RxInt correctAns = 0.obs;

  RxInt wrongAns = 0.obs;

  RxBool onTapClick = false.obs;

  RadioEnum selectRadioGroup = RadioEnum.none;

  RxBool isSelectOp1 = false.obs;
  RxBool isSelectOp2 = false.obs;
  RxBool isSelectOp3 = false.obs;
  RxBool isSelectOp4 = false.obs;

  List<dynamic> isChecked = [];

  RxBool isShown = true.obs;

  Timer timer;
  RxInt start = 10.obs;
  RxBool cancelTimer = false.obs;

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
    timer?.cancel();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    copyDB().whenComplete(builder);
  }

  builder() async {
    dynamicQuizDatabase = await $FloorDynamicQuizDatabase.databaseBuilder("Quiz.db").build();
    dynamicQuizDao = dynamicQuizDatabase.dynamicQuizDao;
    streamData = dynamicQuizDao?.getAllData();

    subscription = dynamicQuizDao.getAllData().listen((event) {
      getData
        ..clear()
        ..addAll(event);

      startTimer();
    });
  }

  QuestionType questionTypeParser(String action) {
    return enumFromString<QuestionType>(action, QuestionType.values);
  }

  void startTimer() {
    print("start time : ${start.value}");
    timer?.cancel();
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
          cancelTimer.value = true;
          nextPageQuestion();
          wrongAns++;
        } else {
          start--;
          print("start time : ${start.value}");
        }
        update();
      },
    );
  }

  Widget questionSeparated() {
    switch (questionTypeParser(getData[currentIndex.value].type)) {
      case QuestionType.single_selection:
        return Container(
          child: Column(
            children: [
              generalQuestionOption(
                title: getData[currentIndex.value].option1,
                color: opBrgAns1,
                onTap: () {
                  checkString.value = getData[currentIndex.value].option1;
                  checkAnswer();
                  opBrgAns1 = colorShow;
                  update();
                },
              ),
              generalQuestionOption(
                title: getData[currentIndex.value].option2,
                color: opBrgAns2,
                onTap: () {
                  checkString.value = getData[currentIndex.value].option2;
                  checkAnswer();
                  opBrgAns2 = colorShow;

                  update();
                },
              ),
              generalQuestionOption(
                title: getData[currentIndex.value].option3,
                color: opBrgAns3,
                onTap: () {
                  checkString.value = getData[currentIndex.value].option3;
                  checkAnswer();
                  opBrgAns3 = colorShow;
                  update();
                },
              ),
              generalQuestionOption(
                title: getData[currentIndex.value].option4,
                color: opBrgAns4,
                onTap: () {
                  checkString.value = getData[currentIndex.value].option4;
                  checkAnswer();
                  opBrgAns4 = colorShow;
                  update();
                },
              ),
            ],
          ),
        );
        break;
      case QuestionType.general_selection:
        //   if (!onTapClick.value) onTapClick.value = true;
        return Container(
          child: Column(
            children: [
              RadioButtonWidget(
                padding: EdgeInsets.all(5),
                label: getData[currentIndex.value].option1,
                value: RadioEnum.option1,
                groupValue: selectRadioGroup,
                onChanged: (value) {
                  selectRadioGroup = value;
                  print(selectRadioGroup);
                  update();
                },
              ),
              RadioButtonWidget(
                padding: EdgeInsets.all(5),
                label: getData[currentIndex.value].option2,
                value: RadioEnum.option2,
                groupValue: selectRadioGroup,
                onChanged: (value) {
                  selectRadioGroup = value;
                  print(selectRadioGroup);
                  update();
                },
              )
            ],
          ),
        );
        break;
      case QuestionType.multi_selection:
        //   if (!onTapClick.value) onTapClick.value = true;
        return Container(
          child: Column(
            children: [
              CheckBoxWidget(
                label: getData[currentIndex.value].option1,
                value: isSelectOp1.value,
                onChanged: (value) {
                  isSelectOp1.value = value;
                  if (isSelectOp1.value == true) {
                    isChecked.add(getData[currentIndex.value].option1);
                    print(isChecked.length);
                  } else {
                    isChecked.remove(getData[currentIndex.value].option1);
                  }
                  update();
                },
                padding: EdgeInsets.all(5),
              ),
              CheckBoxWidget(
                label: getData[currentIndex.value].option2,
                value: isSelectOp2.value,
                onChanged: (value) {
                  isSelectOp2.value = value;
                  if (isSelectOp2.value == true) {
                    isChecked.add(getData[currentIndex.value].option2);
                    print(isChecked.length);
                  } else {
                    isChecked.remove(getData[currentIndex.value].option2);
                  }
                  update();
                },
                padding: EdgeInsets.all(5),
              ),
              CheckBoxWidget(
                label: getData[currentIndex.value].option3,
                value: isSelectOp3.value,
                onChanged: (value) {
                  isSelectOp3.value = value;
                  if (isSelectOp3.value == true) {
                    isChecked.add(getData[currentIndex.value].option3);
                    print(isChecked.length);
                  } else {
                    isChecked.remove(getData[currentIndex.value].option3);
                  }
                  update();
                },
                padding: EdgeInsets.all(5),
              ),
              CheckBoxWidget(
                label: getData[currentIndex.value].option4,
                value: isSelectOp4.value,
                onChanged: (value) {
                  isSelectOp4.value = value;
                  if (isSelectOp4.value == true) {
                    isChecked.add(getData[currentIndex.value].option4);
                  } else {
                    isChecked.remove(getData[currentIndex.value].option4);
                  }
                  update();
                },
                padding: EdgeInsets.all(5),
              ),
            ],
          ),
        );
        break;
      case QuestionType.fill_answer:
        return Container(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: MediaQuery.of(Get.context).size.width / 2,
                child: TextFormField(
                  controller: answerController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "fill the answer",
                  ),
                ),
              ),
            ),
            fillAnswerQuestion(option: getData[currentIndex.value].option1),
            fillAnswerQuestion(option: getData[currentIndex.value].option2),
            fillAnswerQuestion(option: getData[currentIndex.value].option3),
            fillAnswerQuestion(option: getData[currentIndex.value].option4),
          ],
        ));
      default:
        {
          return Container();
        }
    }
  }

  nextPageQuestion() async {
    cancelTimer.value = false;
    timer?.cancel();
    if (currentIndex.value < getData.length - 1) {
      start.value = 10;
      currentIndex.value++;

      answerController.clear();

      isSelectOp1.value = false;
      isSelectOp2.value = false;
      isSelectOp3.value = false;
      isSelectOp4.value = false;

      selectRadioGroup = RadioEnum.none;

      checkString.value = "";

      opBrgAns1 = Colors.indigo;
      opBrgAns2 = Colors.indigo;
      opBrgAns3 = Colors.indigo;
      opBrgAns4 = Colors.indigo;

      isChecked.clear();
      startTimer();
      update();
    } else {
      timer?.cancel();
      Get.offAndToNamed(AppRoute.resultPage);
    }

    update();
  }

  prePageQuestion() async {
    currentIndex.value--;
    print(currentIndex.value);
    update();
  }

  checkAnswer() async {
    var delayTimer = Timer(Duration(seconds: 1), nextPageQuestion);

    switch (questionTypeParser(getData[currentIndex.value].type)) {
      case QuestionType.single_selection:
        if (checkString.value == getData[currentIndex.value].answer) {
          colorShow = rightAnsColor;
          print("right Color");
          correctAns++;
        } else {
          colorShow = wrongAnsColor;
          print("Wrong Color");
          wrongAns++;
        }
        delayTimer.toString();
        update();
        break;
      case QuestionType.general_selection:
        if (selectRadioGroup == RadioEnum.option1 &&
                getData[currentIndex.value].option1 == getData[currentIndex.value].answer ||
            selectRadioGroup == RadioEnum.option2 &&
                getData[currentIndex.value].option2 == getData[currentIndex.value].answer) {
          print("correct");
          correctAns++;
        } else {
          wrongAns++;
          print("incorrect");
        }
        delayTimer.toString();
        update();
        break;
      case QuestionType.multi_selection:
        List multiAns = getData[currentIndex.value].answer.split(",");
        print("Compare :${listEquals(isChecked, multiAns)}");

        if (listEquals(isChecked, multiAns) == true) {
          correctAns++;
        } else {
          wrongAns++;
          print(isChecked);
        }
        delayTimer.toString();
        update();
        break;
      case QuestionType.fill_answer:
        if (answerController.text == getData[currentIndex.value].answer) {
          print("Right Answer");
          correctAns++;
        } else {
          print("wrong Answer");
          wrongAns++;
        }
        delayTimer.toString();
        update();
        break;
    }
    update();
  }

  resetQuiz() async {
    correctAns.value = 0;
    wrongAns.value = 0;
    getData.clear();
    currentIndex.value = 0;
    getData.clear();
    start.value;

    isSelectOp1.value = false;
    isSelectOp2.value = false;
    isSelectOp3.value = false;
    isSelectOp4.value = false;

    selectRadioGroup = RadioEnum.none;

    checkString.value = "";

    answerController.clear();

    builder();

    isChecked.clear();

    Get.offAndToNamed(AppRoute.dynamicQuizPage);
    update();
  }
}
