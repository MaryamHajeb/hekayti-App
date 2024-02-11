import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hikayati_app/features/Regestrion/date/model/userMode.dart';
import '../../../../core/util/Common.dart';

class IntroScreenController extends GetxController {
  UserModel? userModel;
  int selectedCharacter = 0;
  int selectedLevel = 1;
  TextEditingController name = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  saveUserInformation(UserModel data) async {
    print("data.id");
    print(data.id);
    print("data.email");
    print(data.email);
    print("data.passwoed");
    print(data.password);
    await cachedData(
        key: 'UserInformation',
        data: UserModel(
            user_name: data.user_name ?? "",
            email: data.email,
            level: data.level,
            character: data.character,
            update_at: data.update_at,
            password: data.password,
            id: data.id));
  }
}
