import 'package:kindergarten/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:kindergarten/utils/constaince.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final IconData? icon;

  const CustomButton(
      {Key? key, this.text = "", required this.onPressed, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onPressed,
        padding: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                icon,
                color: const Color(0xFF88AFDA),
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
    );
  }
}
