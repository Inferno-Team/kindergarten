import 'dart:convert';
import 'dart:io';

// import 'package:kindergarten/core/view_models/student_evaluation.dart';
import 'package:kindergarten/models/camera_response.dart';
import 'package:kindergarten/models/location_response.dart';
import 'package:kindergarten/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:kindergarten/models/message_response.dart';
import 'package:kindergarten/models/payment_response.dart';
import 'package:kindergarten/models/student.dart';
import 'package:kindergarten/models/student_evaluation.dart';
import 'package:kindergarten/models/weekly_course_response.dart';

class DataService {
  static final DataService _singleton = DataService._internal();
  factory DataService() {
    return _singleton;
  }
  DataService._internal();

  final String apiUrl = "http://192.168.43.113:8000";
  // final String route = "/api";
  // final String apiUrl = "http://192.168.1.7:8000";
  final String route = "/api";

  Future<LoginResponse> login(String email, String password) async {
    var loginRoute = '/log-in';

    final Uri uri = Uri.parse(apiUrl + route + loginRoute);

    try {
      http.Response response = await http.post(uri, body: {
        'name': email,
        'password': password
      }).timeout(const Duration(seconds: 5));
      print(response.body);
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(await json.decode(response.body));
      } else {
        print('something wrong $uri');
        return LoginResponse.fromJson(await json.decode(response.body));
      }
    } catch (e) {
      print('something wrong $e');
      return LoginResponse(
          status: false, parent: Parent.empty(), message: "Login Error");
    }
  }

  Future<List<Student>> getMyStudents(String token, String id) async {
    // perform a http request with header
    String routeName = '/get-Students';
    Uri uri = Uri.parse(apiUrl + route + routeName);
    try {
      http.Response response = await http
          .post(uri, headers: {'auth-token': token}, body: {'id': id});
      print(response.body);
      var jsonList = await json.decode(response.body);
      var students = jsonList['student'] as List<dynamic>;
      return students.map((std) => Student.fromJson(std)).toList();
    } catch (e) {
      print('Error on getting students list $e');
      return [];
    }
  }

  Future<CameraResponse> getCameraIP(String token, int studentId) async {
    var cameraRoute = '/get-camera';

    final Uri uri = Uri.parse(apiUrl + route + cameraRoute);
    try {
      http.Response response = await http.post(uri,
          body: {'id': "$studentId"}, headers: {'auth-token': token});
      print(response.body);
      return CameraResponse.fromJson(await json.decode(response.body));
    } catch (e) {
      print('something wrong $e');
      return CameraResponse(
          status: false, msg: '', cameraIP: '', errorNumber: "");
    }
  }

  Future<MessageResponse> getMessages(String token, String id) async {
    // var messageRoute = 'http://192.168.43.113/kinder/get-message.json';
    // var messageRoute = 'http://192.168.1.103/kinder/get-message.json';
    String routeName = '/get-message';

    final Uri uri = Uri.parse(apiUrl + route + routeName);
    try {
      http.Response response = await http
          .post(uri, headers: {'auth-token': token}, body: {'id': id});
      var _json = await json.decode(response.body);

      return MessageResponse.fromJson(_json);
    } catch (e) {
      print('somethig wrong catch : $e');
      return MessageResponse(messages: []);
    }
  }

  Future<WeeklyCoursesResponse> getWeeklyCourses(
      String token, int studentId) async {
    var routeName = '/get-weekly-courses';
    Uri uri = Uri.parse(apiUrl + route + routeName);

    // final Uri uri =
    //     Uri.parse("http://192.168.43.113/kinder/get-weekly-courses.json");
    try {
      http.Response response = await http.post(uri,
          headers: {'auth-token': token}, body: {'id': "$studentId"});
      dynamic utf8Json = utf8.decode(response.bodyBytes);
      var body = await json.decode(utf8Json);
      return WeeklyCoursesResponse.fromJson(body);
    } catch (e) {
      print('something wrong $e');
      return WeeklyCoursesResponse(
          status: false, msg: '', errorNumber: '', weeklyCourses: []);
    }
  }

  Future<EvaluationResponse> getStudentEvaluation(
      String token, int studentId) async {
    var routeName = '/get-evaluation';

    final Uri uri = Uri.parse(apiUrl + route + routeName);
    // Uri.parse("http://192.168.43.113/kinder/get-evaluation.json");
    try {
      http.Response response = await http.post(uri,
          body: {"id": "$studentId"}, headers: {"auth-token": token});
      dynamic utf8Json = utf8.decode(response.bodyBytes);
      var body = await json.decode(utf8Json);
      return EvaluationResponse.fromJson(body);
    } catch (e) {
      print('something wrong $e');
      return EvaluationResponse.empty();
    }
  }

  Future<LocationResponse> getBusLocation(String token, int studentId) async {
    var routeName = "/get-GPS";
    var uri = Uri.parse(
        apiUrl + route + routeName); // http://192.168.43.113/api/get-GPS
    try {
      http.Response response = await http.post(uri,
          headers: {'auth-token': token}, body: {'id': "$studentId"});
      print(response.body);
      var _json = await json.decode(response.body);
      print(response.body);
      return LocationResponse.fromJson(_json);
    } catch (e) {
      print("Error $e");
      return LocationResponse.empty();
    }
  }

  Future<PaymentResponse> getStudentPayment(String token, int studentId) async {
    var routeName = '/get-payment';
    Uri uri = Uri.parse(apiUrl + route + routeName);
    http.Response response = await http
        .post(uri, headers: {'auth-token': token}, body: {'id': studentId.toString()});
    var body = response.body;
    try {
      var bodyJson = await json.decode(body);
      return PaymentResponse.fromJson(bodyJson);
    } catch (e) {
      print('Error $e');
      return PaymentResponse(payments: []);
    }
  }

  Future<AnnualEvaluationResponse> getStudentAnnualEvaluation(
      String token, int studentId) async {
    var routeName = '/get-annual-eval';

    final Uri uri = Uri.parse(apiUrl + route + routeName);
    try {
      http.Response response = await http.post(uri,
          body: {"id": "$studentId"}, headers: {"auth-token": token});
      dynamic utf8Json = utf8.decode(response.bodyBytes);
      print(utf8Json);
      var body = await json.decode(utf8Json);
      return AnnualEvaluationResponse.fromJson(body);
    } catch (e) {
      print('something wrong $e');
      return AnnualEvaluationResponse.empty();
    }
  }
}
