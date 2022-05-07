import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/home_view_mode.dart';
import 'package:kindergarten/models/message_response.dart';
import 'package:kindergarten/ui/messages/custom_message_template.dart';

class MessageBottomDialog extends StatelessWidget {
  final Size size;
  final List<Message> messages;
  final HomeViewModel controller;
  MessageBottomDialog(
      {Key? key,
      required this.size,
      required this.messages,
      required this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        height: size.height * 0.667,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
              child: ListView(
                children: [
                  for (var msg in messages)
                    MessageTemplate(
                      message: msg,
                      toSend: false,
                      onTap: () => controller.sendMessage(msg),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
