import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/routs/app_routs.dart';
import 'package:quize_app_elaunch/screen/dynamic_quiz_page/dynamic_quiz_controller.dart';

class ResultPage extends StatelessWidget {
  final DynamicQuizController dynamicQuizController = Get.put(DynamicQuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Page'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Correct Answer : ",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                        children: [
                          TextSpan(
                              text: "${dynamicQuizController.correctAns.value.toString()}",
                              style: TextStyle(color: Colors.green, fontSize: 25.0)),
                        ]),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Wrong Answer : ",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                        children: [
                          TextSpan(
                              text: "${dynamicQuizController.wrongAns.value.toString()}",
                              style: TextStyle(color: Colors.green, fontSize: 25.0))
                        ]),
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  dynamicQuizController.resetQuiz();
                  Get.offAndToNamed(AppRoute.dynamicQuizPage);
                },
                child: Text(
                  'Reset Quiz',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
