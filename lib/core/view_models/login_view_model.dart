import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kindergarten/core/services/data_service.dart';
import 'package:kindergarten/models/login_response.dart';
import 'package:kindergarten/ui/home/home_layout.dart';
import 'package:kindergarten/ui/login/login_layout.dart';
import 'package:kindergarten/ui/main_layout/main_layout.dart';
import 'package:kindergarten/utils/cache_manager.dart';
import 'package:get/get.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class LoginViewModel extends GetxController with CacheManager {
  final email = "".obs, password = "".obs;
  final _service = DataService();
  final loginResponse = LoginResponse.empty().obs;
  final _loading = 0.obs;
  final remamberMe = false.obs;
  final isLogged = false.obs;
  final visibilityIcon = true.obs;
  get loading => _loading.value;

  void login() async {
    _loading.value = 1;
    loginResponse.value = await _service.login(email.value, password.value);
    // loginResponse.value = await _service.fakeLogin();
    _loading.value = 2;
    
    if (loginResponse.value.status) {
      await saveToken(loginResponse.value.parent.token,
          loginResponse.value.parent.id, remamberMe.value);
      email.value = "";
      password.value = "";
      Get.offAll(() => MainLayout());
    } else {
      Fluttertoast.showToast(
        msg: loginResponse.value.message,
      );
    }
  }

  Future<void> checkLoginStatus() async {
    final token = getToken();
    final re = isRemamberMe();
    print('remamber me :$re');
    if (token != null && re != null && re != false) {
      isLogged.value = true;
    } else {
      isLogged.value = false;
    }
    return await null;
  }

  Future<void> scanQR() async {
    try {
      String? value = await scanner.scan();

      if (value != null) {
        var scannedValue = value.split(",");
        email.value = scannedValue[0];
        password.value = scannedValue[1];
        login();
      } else {}
      // var data = scannedQRcode.split(",");
      // email = data[0];
      // password = data[1];

    } on PlatformException {
      Get.snackbar('Error', "Something Went wrong.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    return await null;
  }
}
