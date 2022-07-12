import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/home_view_mode.dart';
import 'package:kindergarten/ui/messages/custom_message_template.dart';
import 'package:kindergarten/ui/messages/send_message_bottom_dailog.dart';
import 'package:kindergarten/ui/widgets/custom_message.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';
import 'package:kindergarten/utils/constaince.dart';

class MessageLayout extends GetWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          child: Obx(() {
            if (controller.isMassesageLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              return ListView(
                children: [
                  const Center(
                    child: CustomText(
                        text: "Messages",
                        color: Colors.black,
                        alignment: Alignment.center,
                        fontSize: 18,
                        weight: FontWeight.bold),
                  ),
                  for (var i = 0;
                      i < controller.messageResponse.value.length;
                      i++)
                    if (i >=0 && i <4)
                      for (var msg
                          in controller.messageResponse.value[i])
                        CustomMessage(message: msg)

                    else if (i == 4)
                      for (var msg
                          in controller.messageResponse.value[i])
                        MessageTemplate(
                          message: msg,
                          onTap: () async => await controller.sendSMSTo(msg),
                          toSend: true,
                          isSent: false,
                        ),
                  for (var msg in controller.sentLocalMessages)
                    MessageTemplate(
                      message: msg,
                      onTap: () {},
                      toSend: true,
                      
                    ),
                ],
              );
            }
          }),
        ),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          child: FloatingActionButton.small(
            onPressed: () async {
              await controller.getLocalMessageFromDatabase();
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
