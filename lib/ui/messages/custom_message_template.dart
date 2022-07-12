import 'package:flutter/material.dart';
import 'package:kindergarten/models/message_response.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';
import 'package:kindergarten/utils/constaince.dart';

class MessageTemplate extends StatelessWidget {
  final Message message;
  final Function() onTap;
  final bool toSend;
  final bool isSent;
  const MessageTemplate(
      {Key? key,
      required this.message,
      required this.onTap,
      required this.toSend,
      this.isSent = true})
      : super(key: key);
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
        time = "${diff.inDays} dayes";
      }
    } else {
      if (diff.inHours > 0) {
        time = "${diff.inHours} hours";
        if (diff.inMinutes > 0) {
          time += " , ${diff.inMinutes - (diff.inHours * 60)} minutes";
        }
      } else {
        time = "${diff.inMinutes} minutes";
      }
    }
    time += " ago";
    Gradient? gradient;
    Color? background;
    Color textColor;
    double width = 0;
    if (message.text.length > 31) {
      width = 35 * size.width * 9 / 16 * 0.045;
    } else {
      width = message.text.length * size.width * 9 / 16 * 0.045;
    }
    if (toSend) width += 20;
    // final width = message.text.length * size.width * 9 / 16 * 0.1;

    if (!toSend) {
      gradient = const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: loginColors,
        stops: [0.1, 0.4, 0.7, 0.9],
      );
      textColor = Colors.white;
    } else {
      background = Colors.white.withAlpha(155);
      textColor = Colors.black87;
    }

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: background,
                ),
                child: SizedBox(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            CustomText(
                              text: message.text,
                              fontSize: 13,
                              color: textColor,
                              alignment: Alignment.topLeft,
                            ),
                            toSend && !isSent
                                ? GestureDetector(
                                    onTap: onTap,
                                    child: const Icon(Icons.send, size: 14),
                                  )
                                : Container()
                          ],
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
      ),
    );
  }
}
