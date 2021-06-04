import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/routs/app_routs.dart';
import 'package:quize_app_elaunch/screen/result_page/result_model.dart';

import 'dynamic_quiz_controller.dart';
import 'package:quize_app_elaunch/common/widget.dart';

class DynamicQuiz extends StatelessWidget {
  final DynamicQuizController dynamicQuizController = Get.put(DynamicQuizController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.dialog<bool>(
        AlertDialog(
          title: Text("Quiz App E launch"),
          content: Text("Really Exit Application"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(result: true);
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Get.back(result: false);
              },
              child: Text("No"),
            ),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                checkAnswerCircle(color: Colors.red[300], title: "${dynamicQuizController.start}"),
                checkAnswerCircle(
                    color: Colors.indigo,
                    title: "${dynamicQuizController.currentIndex.value + 1}/${dynamicQuizController.getData.length}"),
              ],
            ),
          ),
        ),
        body: Obx(
          () => dynamicQuizController.getData.isNotEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${dynamicQuizController.currentIndex.value + 1} . ",
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                                fontSize: 18.0,
                              ),
                            ),
                            Expanded(
                              child: new Text(
                                dynamicQuizController.getData[dynamicQuizController.currentIndex.value].question,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Center(child: dynamicQuizController.questionSeparated()),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              checkAnswerCircle(
                                color: Colors.green,
                                title: dynamicQuizController.correctAns.value.toString(),
                              ),
                              checkAnswerCircle(
                                color: Colors.red,
                                title: dynamicQuizController.wrongAns.value.toString(),
                              ),
                              TextButton(
                                onPressed: () {
                                  dynamicQuizController.checkAnswer();
                                },
                                child: Text(
                                  "Next",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }
}
