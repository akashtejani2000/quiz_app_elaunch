import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/screen/quiz_page/quiz_page_controller.dart';

final QuizPageController controller = Get.put(QuizPageController());

Widget commonBox({String title, Color backGroundColor}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: backGroundColor,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AutoSizeText(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      )),
    ),
  );
}

Widget answerCheckBox({String title, Color backGroundColor, IconData icon}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: backGroundColor,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            AutoSizeText(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 25.0,
            )
          ],
        ),
      ),
    ),
  );
}

Widget quizButton({String title, Color color}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: MaterialButton(
        onPressed: () {
          controller.checkAnswer(title);
          print("Color : ${controller.colorShow.toString()}");
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.indigo,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
