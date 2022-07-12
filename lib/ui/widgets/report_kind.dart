import 'package:flutter/material.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';

class CustomReportItem extends StatelessWidget {
  final String text;
  final bool isBordered;
  final Function()? onTap;

  const CustomReportItem(
      {Key? key, required this.text, required this.isBordered, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Card(
            elevation: 8,
            color: !isBordered ? const Color(0xFF73AEF5) : const Color(0xFFCBE3FF),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  alignment: Alignment.center,
                  text: text,
                  color: isBordered ? Colors.black : Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
