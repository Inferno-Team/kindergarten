class WeeklyCourse {
  final String day;
  final List<String> courses;

  WeeklyCourse(this.day, this.courses);
  factory WeeklyCourse.fromJson(dynamic json) {
    var day = json['day'] ?? "";
    var courseList = (json['courses'] ?? "").split(' ');
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
    var status = json['stauts'] ?? false;
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
