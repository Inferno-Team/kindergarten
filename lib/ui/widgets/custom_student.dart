import 'package:flutter/material.dart';
import 'package:kindergarten/models/student.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';

class CustomStudent extends StatelessWidget {
  final Student student;
  final Function()? onTap;

  const CustomStudent({Key? key, required this.student, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final studentName = student.gender == 1 ? "اسم الطالب" : "اسم الطالبة";
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Transform.scale(
          child: child,
          scale: value,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Card(
          elevation: 8,
          color: const Color(0xFF73AEF5),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
              bottomRight: Radius.circular(18.0),
              bottomLeft: Radius.circular(75.0),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              splashColor: Colors.blue.withOpacity(0.1),
              child: Container(
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomText(
                      text: "$studentName :  ${student.name}",
                      alignment: Alignment.topRight,
                      color: Colors.white,
                      fontSize: 18,
                      weight: FontWeight.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: student.divisionName,
                          alignment: Alignment.centerRight,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        const CustomText(
                          text: ": الشعبة ",
                          alignment: Alignment.centerRight,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    CustomText(
                      text: "الطفولة :  ${student.levelName}",
                      fontSize: 18,
                      alignment: Alignment.centerRight,
                      color: Colors.white,
                      weight: FontWeight.w300,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
