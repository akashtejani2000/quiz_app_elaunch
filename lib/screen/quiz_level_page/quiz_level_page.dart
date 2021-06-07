import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/screen/quiz_level_page/quiz_level_controller.dart';

class QuizLevel extends StatelessWidget {
  // final QuizLevelController levelController = Get.put(QuizLevelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select The Level'),
      ),
      body: GetBuilder<QuizLevelController>(
        init: QuizLevelController(),
        builder: (levelController) => Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemCount: levelController.imageLevel.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      levelController.unlockLevelStag(index);
                      print(index);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(levelController.imageLevel[index].levelImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: levelController.imageLevel[index].unLockLevel == true
                                ? LinearGradient(
                                    colors: [
                                      Colors.green[200],
                                      Colors.green[200].withOpacity(0.5),
                                    ],
                                    end: Alignment.topCenter,
                                    begin: Alignment.bottomCenter,
                                  )
                                : LinearGradient(
                                    colors: [Colors.red[200].withOpacity(0.8), Colors.red[200].withOpacity(0.5)],
                                    end: Alignment.topCenter,
                                    begin: Alignment.bottomCenter,
                                  )),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget levelBox({String levelImage, Function onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(levelImage),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
