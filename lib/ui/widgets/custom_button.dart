import 'package:kindergarten/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:kindergarten/utils/constaince.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final IconData? icon;
  final double height;
  final double width;
  final Color background;
  final double angle;

  const CustomButton(
      {Key? key,
      this.text = "",
      required this.onPressed,
      this.icon,
      this.angle = 0.0,
      this.height = double.infinity,
      this.background = Colors.white,
      this.width = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        width: width,
        height: height,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: background,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Transform.rotate(
                  angle: angle,
                  child: Icon(
                    icon,
                    color: const Color(0xFF88AFDA),
                  ),
                ),
              ),
              CustomText(
                text: text,
                color: const Color(0xFF527DAA),
                fontSize: 18.0,
                alignment: Alignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
