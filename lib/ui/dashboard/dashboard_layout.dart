import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/home_view_mode.dart';
import 'package:kindergarten/models/student.dart';
import 'package:kindergarten/ui/widgets/custom_dashboard_item.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';

class DashboardLayout extends GetWidget<HomeViewModel> {
  final Student student;
  DashboardLayout({Key? key, required this.student}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final studentName = student.gender == 1 ? "اسم الطالب" : "اسم الطالبة";

    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.33,
          child: SvgPicture.asset(
            'assets/top_iamge.svg',
            fit: BoxFit.fill,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 64.0,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: CustomText(
                    text:
                        "$studentName : ${student.name}", // "$studentName : ${student.name}"
                    alignment: Alignment.topRight,
                    fontSize: 21,
                    color: Colors.white,
                    weight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1.105,
                    children: [
                      DashBoardItem(
                        text: "الدفعات",
                        icon: Icons.money,
                        onTap: () => controller.moveToPymentPage(student),
                      ),
                      DashBoardItem(
                        text: "كاميرا الصف",
                        icon: Icons.camera_alt,
                        onTap: () => controller.moveToCameraPage(student),
                      ),
                      DashBoardItem(
                        text: "جدول الدوام",
                        icon: Icons.calendar_today_rounded,
                        onTap: () => controller.moveToWeeklyCourses(student),
                      ),
                      DashBoardItem(
                        text: "التقارير",
                        icon: Icons.report,
                        onTap: () => controller.moveToReportPage(student),
                      ),
                      DashBoardItem(
                        text: "مكان الباص",
                        icon: Icons.location_on,
                        onTap: () =>controller.moveToMapPage(student),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
