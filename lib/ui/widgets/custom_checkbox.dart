import 'package:flutter/material.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';

class RemamberMe extends StatelessWidget {
  final Function(bool? value) onChange;
  final bool isChecked;

  const RemamberMe({Key? key, required this.onChange, required this.isChecked})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Checkbox(
            onChanged: onChange,
            value: isChecked,
            checkColor: Colors.greenAccent,
            activeColor: Colors.white,
          ),
        ),
        const CustomText(
          text: 'تذكرني',
          color: Colors.white,
          fontSize: 14,
        )
      ],
    );
  }
}
