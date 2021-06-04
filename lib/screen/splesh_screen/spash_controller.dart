import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/common/db_helper.dart';
import 'package:quize_app_elaunch/routs/app_routs.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await loadJson().whenComplete(
          () => Timer(
            Duration(seconds: 5),
            () {
              Get.offNamed(AppRoute.quizLevelScreen);
            },
          ),
        );
      },
    );
  }

  Future<void> loadJson() async {
    await copyDB();
  }
}
