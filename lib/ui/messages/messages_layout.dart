import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/home_view_mode.dart';
import 'package:kindergarten/ui/messages/custom_message_template.dart';
import 'package:kindergarten/ui/messages/send_message_bottom_dailog.dart';
import 'package:kindergarten/ui/widgets/custom_message.dart';
import 'package:kindergarten/utils/constaince.dart';

class MessageLayout extends GetWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    controller.getLocalMessageFromDatabase();
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: loginColors,
              stops: [0.1, 0.4, 0.7, 0.9],
            ),
          ),
          child: Obx(
            () => ListView(
              children: [
                for (var list in controller.messageResponse.value)
                  if (list.type != 'send')
                    for (var msg in list.messages) CustomMessage(message: msg),
                for (var list in controller.messageResponse.value)
                  if (list.type == 'send')
                    for (var msg in list.messages)
                      MessageTemplate(
                        message: msg,
                        onTap: () {},
                        toSend: true,
                      ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          child: FloatingActionButton.small(
            onPressed: () {
              Get.bottomSheet(
                MessageBottomDialog(
                  size: size,
                  messages: controller.localMessages,
                  controller: controller,
                ),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              );
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
      ],
    );
  }
}
