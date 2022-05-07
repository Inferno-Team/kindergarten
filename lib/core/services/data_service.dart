import 'dart:convert';

import 'package:kindergarten/models/camera_response.dart';
import 'package:kindergarten/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:kindergarten/models/message_response.dart';
import 'package:kindergarten/models/student.dart';
import 'package:kindergarten/models/weekly_course_response.dart';

class DataService {
  static final DataService _singleton = DataService._internal();
  factory DataService() {
    return _singleton;
  }
  DataService._internal();

  // final String apiUrl = "http://192.168.43.113:8000";
  // final String route = "/api";
  final String apiUrl = "http://192.168.43.113";
  final String route = "/api";

  Future<LoginResponse> login(String email, String password) async {
    var loginRoute = '/login';

    final Uri uri = Uri.parse(apiUrl + route + loginRoute);

    try {
      http.Response response = await http.post(uri, body: {
        'email': email,
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
      return LoginResponse(code: 400, token: '', message: "Login Error");
    }
  }

  Future<List<Student>> getMyStudents() async {
    // perform a http request with header
    List<Student> list = [];
    var gender = 1;
    for (var i = 0; i < 10; i++) {
      list.add(Student(
          id: -1,
          name: "محمد",
          gender: 1,
          divisionName: "صف الأول",
          levelName: "المتميزون"));
      gender = gender == 1 ? 0 : 1;
    }
    await Future.delayed(const Duration(seconds: 2));
    return list;
  }

  Future<CameraResponse> getCameraIP(String token, int studentId) async {
    var cameraRoute = '/get-camera';

    final Uri uri = Uri.parse(apiUrl + route + cameraRoute);
    try {
      http.Response response = await http
          .post(uri, body: {'id': studentId}, headers: {'auth-token': token});
      print(response.body);
      return CameraResponse.fromJson(await json.decode(response.body));
    } catch (e) {
      print('something wrong $e');
      return CameraResponse(
          status: false, msg: '', cameraIP: '', errorNumber: "");
    }
  }

  Future<MessageResponse> getMessages(String token) async {
    var messageRoute = 'http://192.168.43.113/kinder/get-message.json';

    final Uri uri = Uri.parse(messageRoute);
    try {
      http.Response response =
          await http.post(uri, headers: {'auth-token': token});
      var _json = await json.decode(response.body);

      return MessageResponse.fromJson(_json);
    } catch (e) {
      print('somethig wrong catch : $e');
      return MessageResponse(messages: []);
    }
  }

  Future<WeeklyCoursesResponse> getWeeklyCourses(
      String token, int studentId) async {
    var routeName = '/get-camera';

    final Uri uri =
        Uri.parse("http://192.168.43.113/kinder/get-weekly-courses.json");
    try {
      http.Response response = await http
          .post(uri);
      var body = await json.decode(response.body);
      return WeeklyCoursesResponse.fromJson(body);
    } catch (e) {
      print('something wrong $e');
      return WeeklyCoursesResponse(
          status: false, msg: '', errorNumber: '', weeklyCourses: []);
    }
  }
}
