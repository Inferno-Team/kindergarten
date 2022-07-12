import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/student_view_model.dart';
import 'package:kindergarten/models/student.dart';
import 'package:kindergarten/models/student_evaluation.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';
import 'package:kindergarten/utils/constaince.dart';

class AnnualEvaluaionLayout extends GetWidget<StudentViewModel> {
  final Student student;

  AnnualEvaluaionLayout({required this.student});
  @override
  Widget build(BuildContext context) {
    controller.getStudentAnnualEvaluation(student.id);
    return Directionality(
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
          Obx(() {
            var res = controller.annualEvaluation.value;
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (!res.status) {
              return Center(
                  child: CustomText(
                text: res.msg,
                alignment: Alignment.center,
                weight: FontWeight.bold,
                fontSize: 17,
                color: Colors.white,
              ));
            } else {
              return Container(
                margin: const EdgeInsets.only(top: 32.0),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      const CustomText(
                        text: "تقرير المواد السنوي",
                        alignment: Alignment.topCenter,
                        color: Colors.white,
                        fontSize: 21,
                        weight: FontWeight.w900,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: createCoursesTable(res.evaluation),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}

Widget createCoursesTable(List<StudentAnnualEvaluation> evaluation) {
  final columns = [
    "اسم المادة",
    "العلامة",
    "الامتحان\nالاخير",
    "العلامة\nالكلية",
  ];
  var rows = getRows(evaluation);
  var colms = getColumns(columns);
  return DataTable(
    columns: colms,
    rows: rows,
  );
}

List<DataRow> getRows(List<StudentAnnualEvaluation> value) =>
    value.map((course) {
      final List<String> cells = [];

      cells.add(course.courseName);
      cells.add(course.mark.toString());
      cells.add(course.finalExam.toString());
      cells.add(course.finalMark.toString());

      return DataRow(cells: getCells(cells));
    }).toList();
List<DataColumn> getColumns(List<String> value) =>
    value.map((e) => DataColumn(label: Text(e))).toList();
List<DataCell> getCells(List<String> cells) =>
    cells.map((e) => DataCell(Text(e))).toList();
