import 'package:flutter/material.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';
import 'package:kindergarten/utils/constaince.dart';

class DashBoardItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;

  const DashBoardItem(
      {Key? key, required this.text, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 500),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, double? value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: primaryColor,
                size: 42.0,
              ),
              CustomText(
                text: text,
                alignment: Alignment.center,
                weight: FontWeight.w500,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
