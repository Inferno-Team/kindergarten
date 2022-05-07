import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kindergarten/core/services/data_service.dart';
import 'package:kindergarten/models/login_response.dart';
import 'package:kindergarten/ui/main_layout/main_layout.dart';
import 'package:kindergarten/utils/cache_manager.dart';
import 'package:get/get.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class LoginViewModel extends GetxController with CacheManager {
  String? email, password;
  final _service = DataService();
  final loginResponse = LoginResponse().obs;
  final _loading = 0.obs;
  final isLogged = true.obs;
  final visibilityIcon = true.obs;
  get loading => _loading.value;

  void logOut() {
    isLogged.value = false;
    removeToken();
  }

  void login() async {
    _loading.value = 1;
    loginResponse.value = await _service.login(email!, password!);
    _loading.value = 2;
    if (loginResponse.value.code == 200) {
      await saveToken(loginResponse.value.token);
      Get.offAll(() =>  MainLayout());
    } else {
      Fluttertoast.showToast(
        msg: loginResponse.value.message,
      );
    }
  }

  Future<void> checkLoginStatus() async {
    final token = getToken();
    print(token);
    if (token != null) {
      isLogged.value = true;
    }
    return await null;
  }

  Future<void> scanQR() async {
    try {
      String? value = await scanner.scan();
      
      if (value != null) {
        var scannedValue = value.split(",");
        email = scannedValue[0];
        password = scannedValue[1];
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
