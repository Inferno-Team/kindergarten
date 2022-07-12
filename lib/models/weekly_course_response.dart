class WeeklyCourse {
  final String day;
  final List<String> courses;

  WeeklyCourse(this.day, this.courses);
  factory WeeklyCourse.fromJson(dynamic json) {
    var day = json['day'] ?? "";

    var course1 = json['course1'] ?? '';
    var course2 = json['course2'] ?? '';
    var course3 = json['course3'] ?? '';
    var course4 = json['course4'] ?? '';
    var course5 = json['course5'] ?? '';
    var courseList = <String>[course1, course2, course3, course4, course5];
    return WeeklyCourse(day, courseList);
  }
}

class WeeklyCoursesResponse {
  final bool status;
  final String errorNumber;
  final String msg;
  final List<WeeklyCourse> weeklyCourses;

  WeeklyCoursesResponse(
      {this.status = false,
      this.errorNumber = "",
      this.msg = "",
      required this.weeklyCourses});
  factory WeeklyCoursesResponse.fromJson(dynamic json) {
    var status = json['status'] ?? false;
    var errorNumber = json['errNum'] ?? "";
    var msg = json['msg'] ?? "";
    var weeklyCourses = (json['weekly_courses'] as List)
        .map((day) => WeeklyCourse.fromJson(day))
        .toList();
    return WeeklyCoursesResponse(
        status: status,
        errorNumber: errorNumber,
        msg: msg,
        weeklyCourses: weeklyCourses);
  }
}
