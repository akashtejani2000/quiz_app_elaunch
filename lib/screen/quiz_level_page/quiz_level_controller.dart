import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/Database/floor/dao/dynamic_quiz_dao.dart';
import 'package:quize_app_elaunch/Database/floor/database/dynamic_quiz_database.dart';
import 'package:quize_app_elaunch/Database/floor/model/dynamic_quiz_model.dart';
import 'package:quize_app_elaunch/routs/app_routs.dart';
import 'package:quize_app_elaunch/screen/quiz_level_page/quiz_level_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizLevelController extends GetxController {
  DynamicQuizDao dynamicQuizDao;
  DynamicQuizDatabase dynamicQuizDatabase;

  Stream<List<QuizData>> streamData;
  RxList<QuizData> getData = <QuizData>[].obs;
  StreamSubscription subscription;

  List levelSeparated = [];

  bool isUnlockLevel = false;

  Color unlockLevel = Colors.green[200];
  Color lockLevel = Colors.red[200];

  SharedPreferences pref;
  int getLevelData = 1;
  List<Level> imageLevel = [];

  builders() async {
    dynamicQuizDatabase = await $FloorDynamicQuizDatabase.databaseBuilder("Quiz.db").build();
    dynamicQuizDao = dynamicQuizDatabase.dynamicQuizDao;
    streamData = dynamicQuizDao?.getAllData();

    imageLevel = [
      Level(id: 1, levelImage: "assets/quiz_level/1.png", unLockLevel: getLevelData >= 1),
      Level(id: 2, levelImage: "assets/quiz_level/2.png", unLockLevel: getLevelData >= 2),
      Level(id: 3, levelImage: "assets/quiz_level/3.png", unLockLevel: getLevelData >= 3),
    ];

    update();
  }

  void unlockLevelStag(int index) {
    if (imageLevel[index].unLockLevel == false) {
      Get.dialog(
        AlertDialog(
          content: Text("First Level Not Completed"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('ok'),
            ),
          ],
        ),
      );
    } else {
      Get
        ..delete<int>(tag: "level_data")
        ..put<int>(getLevelData, tag: "level_data")
        ..offAndToNamed(AppRoute.dynamicQuizPage);
    }
    update();
  }

  @override
  void onInit() async {
    super.onInit();

    pref = await SharedPreferences.getInstance();
    getLevelData = pref.getInt("level") ?? 1;
    print("get value : ${getLevelData.toString()}");

    builders();

    update();
  }
}
