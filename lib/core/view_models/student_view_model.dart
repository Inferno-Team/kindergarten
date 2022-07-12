import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/services/data_service.dart';
import 'package:kindergarten/models/payment_response.dart';
import 'package:kindergarten/models/student_evaluation.dart';
import 'package:kindergarten/models/weekly_course_response.dart';
import 'package:kindergarten/utils/cache_manager.dart';

class StudentViewModel extends GetxController with CacheManager {
  final service = DataService();
  final cameraIP = "".obs;
  final weeklyCourses = <WeeklyCourse>[].obs;
  final evaluation = EvaluationResponse.empty().obs;
  final annualEvaluation = AnnualEvaluationResponse.empty().obs;
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  final paymentResponse = PaymentResponse(payments: []).obs;
  final Rx<VlcPlayerController> _liveController =
      VlcPlayerController.network('').obs;
  VlcPlayerController get liveController => _liveController.value;

  getCameraIP(int studentId) async {
    final response = await service.getCameraIP(getToken()!, studentId);
    if (response.status) {
      cameraIP.value = response.cameraIP;
      _liveController.value.dispose();

      _liveController.value = VlcPlayerController.network(
          "rtsp://${cameraIP.value}:8080/h264_ulaw.sdp");
    } else {
      Fluttertoast.showToast(msg: response.msg);
    }
  }

  getWeeklyCourses(int studentId) async {
    final response = await service.getWeeklyCourses("", studentId);
    print(response.status);
    print(response.status);
    if (response.status) {
      weeklyCourses.value = response.weeklyCourses;
    } else {
      Fluttertoast.showToast(msg: response.msg);
    }
  }

  getStudentEvaluation(int studentId) async {
    _isLoading.value = true;
    final token = getToken() ?? "";
    final response = await service.getStudentEvaluation(token, studentId);
    evaluation.value = response;
    if (!response.status) Fluttertoast.showToast(msg: response.msg);
    _isLoading.value = false;
  }

  getStudentAnnualEvaluation(int studentId) async {
    _isLoading.value = true;
    final token = getToken() ?? "";
    final response = await service.getStudentAnnualEvaluation(token, studentId);
    annualEvaluation.value = response;
    if (!response.status) Fluttertoast.showToast(msg: response.msg);
    _isLoading.value = false;
    
  }

  getStudentPayment(int studentId) async {
    _isLoading.value = true;
    String token = getToken() ?? "";
    paymentResponse.value = await service.getStudentPayment(token, studentId);
    _isLoading.value = false;
  }
}
