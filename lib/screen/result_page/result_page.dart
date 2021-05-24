import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/screen/result_page/result_page_controller.dart';
import 'package:scratcher/widgets.dart';

class ResultPage extends StatelessWidget {
  final ResultPageController controller = Get.put(ResultPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Scratcher(
              brushSize: 50,
              threshold: 75,
              color: Colors.red,
              image: Image.asset(
                "assets/scretcher/outerimage.png",
                fit: BoxFit.fill,
              ),
              onChange: (value) => print("Scratch progress: $value%"),
              onThreshold: () => controller.controller.play(),
              child: Container(
                height: 300,
                width: 300,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/scretcher/newimage.png",
                      fit: BoxFit.contain,
                      width: 150,
                      height: 150,
                    ),
                    Column(
                      children: [
                        ConfettiWidget(
                          blastDirectionality: BlastDirectionality.explosive,
                          confettiController: controller.controller,
                          particleDrag: 0.10,
                          emissionFrequency: 0.10,
                          numberOfParticles: 100,
                          gravity: 0.10,
                          shouldLoop: false,
                          colors: [
                            Colors.green,
                            Colors.red,
                          ],
                        ),
                        Text(
                          "Right Answer is ",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "${controller.quizPage.rightAns}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.reSetGame();
            },
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }
}
