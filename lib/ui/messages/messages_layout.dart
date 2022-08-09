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
                        text: "الرسائل",
                        color: Colors.white,
                        alignment: Alignment.center,
                        fontSize: 18,
                        weight: FontWeight.bold),
                  ),
                  for (var i = 0;
                      i < controller.messageResponse.value.length;
                      i++)
                    if (i >= 0 && i < 4)
                      for (var msg in controller.messageResponse.value[i])
                        CustomMessage(message: msg)
                    else if (i == 4)
                      for (var msg in controller.messageResponse.value[i])
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
        Positioned(
          top: 30.0,
          left: 8.0,
          child: FloatingActionButton.extended(
            onPressed: () async {
              // show bottom sheet with input field to edit saved phone number
              Get.bottomSheet(editNumberDialog(size),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent);
            },
            elevation: 0,
            label: const Text(
              "تعديل رقم",
              style: TextStyle(
                fontSize: 11,
              ),
            ),
            icon: const Icon(
              Icons.edit,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget editNumberDialog(Size size) {
    return Container(
      height: size.height * 0.334,
      width: size.width * 0.8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: loginColors,
          stops: [0.1, 0.4, 0.7, 0.9],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomText(
            text: "تعديل رقم الجوال",
            alignment: Alignment.center,
            fontSize: 18,
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            onSubmitted: (value) {
              controller.phoneNumber.value = value;
            },
            controller: TextEditingController()
              ..text = controller.phoneNumber.value,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "رقم الجوال",
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RaisedButton(
            onPressed: () =>controller.updatePhoneNumber(),
            color: Colors.white,
            child: const Text(
              "تعديل",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
