import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/services/data_service.dart';
import 'package:kindergarten/models/weekly_course_response.dart';
import 'package:kindergarten/utils/cache_manager.dart';

class StudentViewModel extends GetxController with CacheManager {
  final service = DataService();
  final cameraIP = "".obs;
  final weeklyCourses = <WeeklyCourse>[].obs;

  getCameraIP(int studentId) async {
    final response = await service.getCameraIP(getToken()!, studentId);
    if (response.status) {
      cameraIP.value = response.cameraIP;
    } else {
      Fluttertoast.showToast(msg: response.msg);
    }
  }

  getWeeklyCourses(int studentId) async {
    final response = await service.getWeeklyCourses("", studentId);
    print(response.status);
    if (response.status) {
      weeklyCourses.value = response.weeklyCourses;
    } else {
      Fluttertoast.showToast(msg: response.msg);
    }
  }
}
