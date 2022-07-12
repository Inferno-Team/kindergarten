import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/services/data_service.dart';
import 'package:kindergarten/core/services/database.dart';
import 'package:kindergarten/models/message_response.dart';
import 'package:kindergarten/models/student.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:kindergarten/utils/cache_manager.dart';

// import 'package:sms/sms.dart';
class HomeViewModel extends GetxController with CacheManager {
  final _service = DataService();
  final _index = 0.obs;
  final _studentList = <Student>[].obs;
  final _arguments = Object().obs;
  final pageRoute = "/".obs;
  final messageResponse = <List<Message>>[].obs;
  final phoneNumber = ''.obs;
  late DatabaseHelper _database;
  final localMessages = <Message>[].obs;
  final sentLocalMessages = <Message>[].obs;
  final _isMassesageLoading = false.obs;

  get args => _arguments.value;
  get index => _index.value;
  bool get isMassesageLoading => _isMassesageLoading.value;
  List<Student> get studentList => _studentList.value;

  @override
  void onInit() async {
    super.onInit();
    _database = DatabaseHelper();

    await _database.initDatabase();
  }

  getLocalMessageFromDatabase() async {
    final futureMsg = await _database.queryAllRows();

    localMessages.value = futureMsg.map((e) => Message.fromJson(e)).toList();
  }

  getPhoneNumber() async {
    phoneNumber.value = (await _database.getPhoneNumber())[0]['value'];
  }

  getMessages() async {
    var token = getToken() ?? '';
    String userId = getUserId() ?? "-1";

    messageResponse.value = [];
    messageResponse.value =
        (await (_service.getMessages(token, userId))).messages;
    final list = await _database.getAllSentMessages();
    print("getAllSentMessages $list");
    sentLocalMessages.value = list.map((e) => Message.fromJson(e)).toList();
  }

  onTab(int index) {
    _index.value = index;
    if (index == 0) getMyStudents();
    if (index == 1) getMessages();
  }

  moveToStudentPage(Student student) {
    // [ /dashboard ]
    pageRoute.value += "dashboard";
    _arguments.value = student;
  }

  moveToCameraPage(Student student) {
    // [ /dashboard/camera ]
    pageRoute.value += "/camera";
    _arguments.value = student;
  }

  moveToReportPage(Student student) {
    pageRoute.value += "/reports";
    _arguments.value = student;
  }

  moveToWeeklyCourses(Student student) {
    pageRoute.value += "/weekly";
    _arguments.value = student;
  }

  onBackPressed() {
    final routes = pageRoute.value.split("/"); // /dashboard ['']
    final index = routes.length - 1;
    final removedRoute = routes[index];
    routes.remove(removedRoute); // //dasboard
    print(routes);
    String finalRoute = "";
    for (var i = 0; i < routes.length; i++) {
      if (routes[i] != "") {
        finalRoute += "/" + routes[i];
      }
    }
    if (routes.length == 1 && routes[0] == "") {
      finalRoute = "/";
    }
    print(finalRoute);

    pageRoute.value = finalRoute;
  }

  moveToHome() {
    pageRoute.value = "home";
  }

  getMyStudents() async {
    String token = getToken() ?? '';
    String userId = getUserId() ?? "-1";
    _studentList.value = await _service.getMyStudents(token, userId);
  }

  sendMessage(Message msg) {
    msg.createdAt = DateTime.now();

    List<Message> type = messageResponse.last;

    // add new messages array.
    messageResponse.remove(type);
    type.add(msg);
    messageResponse.add(type);

    Get.close(1);
  }

  sendSMSTo(Message msg) async {
    await getPhoneNumber();
    List<String> recipents = [phoneNumber.value]; // numbers
    String _result = await sendSMS(message: msg.text, recipients: recipents)
        .catchError((onError) => print(onError));
    await _database.insertSentMessage(msg);
    Fluttertoast.showToast(msg: _result);
  }

  moveToMapPage(Student student) async {
    pageRoute.value += "/map";
    _arguments.value = student;
  }

  moveToPymentPage(Student student) {
    pageRoute.value += "/payment";
    _arguments.value = student;
  }

  moveToCourseReportPage(Student student) {
    pageRoute.value += "/courses";
    _arguments.value = student;
  }

  moveToAnnualeportPage(Student student) {
    pageRoute.value += "/annual";
    _arguments.value = student;
  }
}
