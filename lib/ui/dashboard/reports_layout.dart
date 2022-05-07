import 'package:flutter/material.dart';
import 'package:kindergarten/models/student.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';

class ReportsPage extends StatelessWidget {
  final Student student;

  const ReportsPage({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CustomText(
            text: student.name,
          ),
        ),
      ],
    );
  }
}
