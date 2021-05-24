import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quize_app_elaunch/screen/quiz_page/quiz_page_controller.dart';
import 'package:quize_app_elaunch/widget/quiz_app_widget.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizPageController quizPageController = Get.put(QuizPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.indigo,
                  ),
                  height: 50,
                  width: 50,
                  child: Obx(() => Center(
                        child: Text(
                          quizPageController.currentQuestion.value.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      body: quizPageController.quizData.isNotEmpty
          ? Obx(() => Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(),
                    Card(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 5,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        //   color: Colors.deepOrangeAccent[100],
                        child: Text(
                          quizPageController.quizData[quizPageController.currentQuestion.value].question,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.alegreya(fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: quizPageController.optionMenu.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    quizPageController.checkAnswer(index);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100.0),
                                        color: quizPageController.optionMenu[index].color,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                                          child: Text(
                                            quizPageController.optionMenu[index].title.toString(),
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.indigo,
                              ),
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Text(
                                  quizPageController.showTimer.value,
                                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            answerCheckBox(
                                title: quizPageController.rightAns.value.toString(),
                                backGroundColor: Colors.green,
                                icon: Icons.check),
                            answerCheckBox(
                                title: quizPageController.wrongAns.value.toString(),
                                backGroundColor: Colors.red,
                                icon: Icons.close),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
