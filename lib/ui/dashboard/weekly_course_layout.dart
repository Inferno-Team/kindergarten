import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/student_view_model.dart';
import 'package:kindergarten/models/student.dart';
import 'package:kindergarten/models/weekly_course_response.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';
import 'package:kindergarten/utils/constaince.dart';

class WeeklyLayout extends GetWidget<StudentViewModel> {
  final Student student;

  const WeeklyLayout({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    controller.getWeeklyCourses(student.id);
    return Obx(() => Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: loginColors,
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    CustomText(
                      margin: EdgeInsets.only(top: size.height * 0.15),
                      text: 'جدول الحصص',
                      fontSize: 30.0,
                      color: Colors.white,
                      alignment: Alignment.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomText(
                          text: "الصف : ${student.levelName}",
                          fontSize: 20.0,
                          color: Colors.white,
                          alignment: Alignment.center,
                        ),
                        CustomText(
                          text: "الشعبة : ${student.divisionName}",
                          fontSize: 20.0,
                          color: Colors.white,
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child:
                            createCoursesTable(controller.weeklyCourses.value),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget createCoursesTable(List<WeeklyCourse> value) {
    final columns = [
      "الأيام",
      "الحصة الأولى",
      "الحصة الثانية",
      "الحصة الثالثة",
      "الحصة الرابعة",
      "الحصة الخامسة",
    ]; // مواقيت الدروس
    for (WeeklyCourse courses in value) {
      if (courses.courses.length < 5) {
        int count = 5 - courses.courses.length;
        for (var i = 0; i < count; i++) {
          courses.courses.add('-');
        }
      }
    }

    var rows = getRows(value);
    var colms = getColumns(columns);
    return DataTable(
      columns: colms,
      rows: rows,
    );
  }

  List<DataColumn> getColumns(List<String> value) => value
      .map(
        (e) => DataColumn(
          label: Text(
            e,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      )
      .toList();

  List<DataRow> getRows(List<WeeklyCourse> value) => value.map((course) {
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      )
      .toList();
}
