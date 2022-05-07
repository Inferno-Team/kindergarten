import 'package:get/get.dart';
import 'package:kindergarten/core/services/data_service.dart';
import 'package:kindergarten/core/services/database.dart';
import 'package:kindergarten/models/message_response.dart';
import 'package:kindergarten/models/student.dart';

class HomeViewModel extends GetxController {
  final _service = DataService();
  final _index = 0.obs;
  final _studentList = <Student>[].obs;
  final _arguments = Object().obs;
  final pageRoute = "/".obs;
  final messageResponse = <MessageType>[].obs;
  final DatabaseHelper _database = DatabaseHelper();
  final localMessages = <Message>[].obs;

  get args => _arguments.value;
  get index => _index.value;
  List<Student> get studentList => _studentList.value;

  final _titles = [
    "Home",
    "Messages",
    "Settings",
  ];

  getMessages() async {
    // var token  = getToken()!;
    messageResponse.value = [];
    await Future.delayed(Duration(milliseconds: 300));
    messageResponse.value = (await (_service.getMessages(''))).messages;
  }

  final _tabName = "Home".obs;
  get title => _tabName.value;
  onTab(int index) {
    _index.value = index;
    _tabName.value = _titles[index];
    if (index == 1) getMessages();
  }

  moveToStudentPage(Student student) {
    // [ /dashboard ]
    pageRoute.value += "dashboard";
    _tabName.value = student.name;
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
    routes.remove(routes[routes.length - 1]); // //dasboard
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
    _tabName.value = "Home";
  }

  getMyStudents() async {
    _studentList.value = await _service.getMyStudents();
  }

  getLocalMessageFromDatabase() async {
    final futureMsg = await _database.queryAllRows();
    localMessages.value = futureMsg.map((e) => Message.fromJson(e)).toList();
  }

  sendMessage(Message msg) {
    msg.createdAt = DateTime.now();
    List<MessageType> response = messageResponse.value;
    MessageType type = MessageType(type: 'send', messages: [msg]);
    var found = false;
    for (var element in response) {
      if (element.type == 'send') {
        found = true;
        element.messages.add(msg);
        break;
      }
    }
    if (!found) response.add(type);
    messageResponse.value = response;
    Get.close(1);
  }
}
