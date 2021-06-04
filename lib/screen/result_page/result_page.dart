import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/screen/result_page/result_page_controller.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Page'),
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<ResultController>(
        init: ResultController(),
        builder: (controller) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
                                  text: "${controller.result.correctAnswer}",
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
                              text: "${controller.result.wrongAnswer}",
                              style: TextStyle(color: Colors.red, fontSize: 25.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.resetQuiz();
                    //   Get.toNamed(AppRoute.splashScreen);
                  },
                  child: Text(
                    'Reset Quiz',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
