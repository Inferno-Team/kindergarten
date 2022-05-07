import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kindergarten/core/view_models/login_view_model.dart';
import 'package:kindergarten/ui/dashboard/dashboard_layout.dart';
import 'package:kindergarten/ui/home/home_layout.dart';
import 'package:kindergarten/ui/login/login_layout.dart';
import 'package:kindergarten/ui/main_layout/main_layout.dart';
import 'package:kindergarten/ui/settings/settings_layout.dart';
import 'package:kindergarten/utils/binding.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  MyApp({Key? key}) : super(key: key);

  final LoginViewModel _loginViewModel = Get.put(LoginViewModel());

  Future<void> checkLogin() async {
    await _loginViewModel
        .checkLoginStatus()
        .timeout(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      home: Scaffold(
        body: FutureBuilder(
            future: checkLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return waitingView();
              } else {
                if (snapshot.hasError) {
                  return errorView(snapshot);
                } else {
                  return Obx(() {
                    print(_loginViewModel.isLogged.value);
                    return _loginViewModel.isLogged.value
                        ? MainLayout()
                        : const Login();
                  });
                }
              }
            }),
      ),
    );
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(
      body: Center(
        child: Text('Error: ${snapshot.error}'),
      ),
    );
  }

  Scaffold waitingView() {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
