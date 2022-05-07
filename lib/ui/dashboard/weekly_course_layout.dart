import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/student_view_model.dart';
import 'package:kindergarten/models/student.dart';
import 'package:kindergarten/models/weekly_course_response.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';

class WeeklyLayout extends GetWidget<StudentViewModel> {
  final Student student;

  const WeeklyLayout({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getWeeklyCourses(student.id);
    return Obx(() => Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: createCoursesTable(controller.weeklyCourses.value),
            ),
          ),
        )));
  }

  Widget createCoursesTable(List<WeeklyCourse> value) {
    final columns = [
      "days",
      "08:00-08:45",
      "09:00-09:45",
      "10:00-10:45"
    ]; // مواقيت الدروس
    return DataTable(
      columns: getColumns(columns),
      rows: getRows(value),
    );
  }

  List<DataColumn> getColumns(List<String> value) =>
      value.map((e) => DataColumn(label: Text(e))).toList();

  List<DataRow> getRows(List<WeeklyCourse> value) =>
      value.map((WeeklyCourse course) {
        final List<String> cells = [course.day];
        for (var item in course.courses) {
          cells.add(item);
        }
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<String> cells) => cells
      .map(
        (e) => DataCell(
          Text(
            e,
          ),
        ),
      )
      .toList();
}
