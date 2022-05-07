import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/home_view_mode.dart';
import 'package:kindergarten/core/view_models/login_view_model.dart';
import 'package:kindergarten/core/view_models/student_view_model.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => StudentViewModel());
  }
}
