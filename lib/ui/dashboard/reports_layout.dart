import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/home_view_mode.dart';
import 'package:kindergarten/core/view_models/student_view_model.dart';
import 'package:kindergarten/models/student.dart';
import 'package:kindergarten/ui/widgets/report_kind.dart';
import 'package:kindergarten/utils/constaince.dart';

class ReportsPage extends GetWidget<StudentViewModel> {
  final Student student;

  const ReportsPage({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeViewModel _homeViewModel = Get.find(tag: "HomeViewModel");
    final size = MediaQuery.of(context).size;

    return Stack(
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
        Container(
          margin: EdgeInsets.only(top: size.height * 0.30),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
            childAspectRatio: 1.105,
            children: [
              CustomReportItem(
                text: 'تقرير سنوي',
                isBordered: false,
                onTap: () => _homeViewModel.moveToAnnualeportPage(student),
              ),
              CustomReportItem(
                  text: 'تقرير مواد',
                  isBordered: true,
                  onTap: () => _homeViewModel.moveToCourseReportPage(student)),
            ],
          ),
        ),
      ],
    );
  }
}
