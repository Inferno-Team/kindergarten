import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final Alignment alignment;
  final FontWeight weight;

  const CustomText({
    Key? key,
    this.text = '',
    this.color = Colors.black,
    this.fontSize = 16,
    this.alignment = Alignment.topLeft,
    this.weight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      margin: const EdgeInsets.all(12.0),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: 'OpenSans',
          fontWeight: weight,
        ),
      ),
    );
  }
}
