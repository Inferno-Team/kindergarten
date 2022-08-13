import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/home_view_mode.dart';
import 'package:kindergarten/core/view_models/student_view_model.dart';
import 'package:kindergarten/ui/dashboard/annual_evaluation_layout.dart';
import 'package:kindergarten/ui/dashboard/camera_layout.dart';
import 'package:kindergarten/ui/dashboard/courses_evaluation_layout.dart';

import 'package:kindergarten/ui/dashboard/dashboard_layout.dart';
import 'package:kindergarten/ui/dashboard/map_layout.dart';
import 'package:kindergarten/ui/dashboard/pyment_layout.dart';
import 'package:kindergarten/ui/dashboard/reports_layout.dart';
import 'package:kindergarten/ui/dashboard/weekly_course_layout.dart';
import 'package:kindergarten/ui/widgets/custom_student.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';
import 'package:kindergarten/utils/constaince.dart';

class Home extends GetWidget<HomeViewModel> {
  final studentController =
      Get.put(StudentViewModel(), tag: "student_view_model_controller");

//عرفنا بهل طريقة 2 كونترولر
  @override
  Widget build(BuildContext context) {
    const _logoSvg = 'assets/home_logo.svg';
    Get.put(controller, tag: "HomeViewModel");
    controller.pageRoute.value = "/";
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        controller.onBackPressed();
        return false;
      },
      child: Obx(() {
        print(controller.pageRoute.value);
        if (controller.pageRoute.value == "/") {
          return homeLayout(size, _logoSvg);
        } else if (controller.pageRoute.value == "/dashboard") {
          return DashboardLayout(
            student: controller.args,
          );
        } else if (controller.pageRoute.value == "/dashboard/camera") {
          return CameraPage(student: controller.args);
        } else if (controller.pageRoute.value == "/dashboard/reports") {
          return ReportsPage(student: controller.args);
        } else if (controller.pageRoute.value == "/dashboard/weekly") {
          return WeeklyLayout(student: controller.args);
        } else if (controller.pageRoute.value == "/dashboard/map") {
          return MapLayout(student: controller.args);
        } else if (controller.pageRoute.value == "/dashboard/payment") {
          return PaymentLayout(student: controller.args);
        } else if (controller.pageRoute.value == "/dashboard/reports/courses") {
          return CoursesEvaluaionLayout(student: controller.args);
        } else if (controller.pageRoute.value == "/dashboard/reports/annual") {
          return AnnualEvaluaionLayout(student: controller.args);
        } else {
          return Container();
        }
      }),
    );
  }

  Stack homeLayout(Size size, String _logoSvg) {
    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          color: backgroudColor,
        ),
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: 10, top: size.height * 0.1),
          child: SizedBox.fromSize(
            size: size * 0.5,
            child: Container(
              alignment: Alignment.topCenter,
              height: size.height * 0.25,
              width: size.width * 0.25,
              child: SvgPicture.asset(
                _logoSvg,
                alignment: Alignment.center,
                height: size.height * 0.22,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (context, double val, child) {
                return Opacity(opacity: val, child: child);
              },
              child: ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  width: size.width,
                  height: size.height * 0.67,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: loginColors,
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    right: 24,
                  ),
                  child: Obx(() => TweenAnimationBuilder(
                        tween: Tween(begin: 1.0, end: 0.0),
                        duration: Duration(milliseconds: 1000),
                        builder: (context, double value, child) {
                          return Transform.translate(
                              offset: Offset(value * size.width * 0.1, 0),
                              child: child);
                        },
                        child: CustomText(
                          alignment: Alignment.centerRight,
                          text: controller.parentName,
                          weight: FontWeight.w700,
                          fontSize: 21.0,
                          color: Colors.white,
                        ),
                      )),
                ),
                SizedBox(
                  height: size.height * 0.55,
                  child: ListView.builder(
                    itemCount: controller.studentList.length,
                    itemBuilder: (context, index) => CustomStudent(
                      student: controller.studentList[index],
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: controller.studentList[index].name);
                        controller
                            .moveToStudentPage(controller.studentList[index]);
                      },
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;
    double q = w / 3;
    final x4 = q * 2;
    final x5 = q;
    double c1 = 30;
    double c2 = w - 30;
    double c3 = 30;
    double c4 = 30;
    final path = Path();
    path.moveTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w, c1);
    path.quadraticBezierTo(w, 0, c2, 0);
    // path.lineTo(w, 0);
    path.lineTo(x4, 0);
    path.quadraticBezierTo(w * 0.5, 70, x5, 0);
    path.lineTo(c3, 0);
    path.quadraticBezierTo(0, 0, 0, c4);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
