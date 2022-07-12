import 'package:flutter/material.dart';
import 'package:kindergarten/models/message_response.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';

class CustomMessage extends StatelessWidget {
  final Message message;

  const CustomMessage({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var time = "";
    Duration diff = DateTime.now().difference(message.createdAt);
    if (diff.inDays > 0) {
      if (diff.inDays > 30) {
        time = "${diff.inDays ~/ 30} months";
        if (diff.inDays % 30 > 0) time += " , ${diff.inDays % 30} days";
      } else {
        time = "${diff.inDays} days";
      }
    } else {
      if (diff.inHours > 0) {
        time = "${diff.inHours} hours";
        if (diff.inMinutes % 60 > 0) {
          time += " , ${diff.inMinutes - (diff.inHours * 60)} minutes";
        }
      } else {
        time = "${diff.inMinutes} minutes";
      }
    }
    time += " ago";
    double width = 0;
    if (message.text.length > 31) {
      width = 35 * size.width * 9 / 16 * 0.045;
    } else {
      width = message.text.length * size.width * 9 / 16 * 0.045;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(155),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SizedBox(
                width: width,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      CustomText(
                        text: message.text,
                        fontSize: 14,
                        color: Colors.black87,
                        alignment: Alignment.topLeft,
                      ),
                      CustomText(
                        text: time,
                        fontSize: 11,
                        color: Colors.black26,
                        alignment: Alignment.bottomRight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
