import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/login_view_model.dart';
import 'package:kindergarten/core/view_models/settings_view_model.dart';
import 'package:kindergarten/ui/widgets/custom_input.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';
import 'package:kindergarten/utils/constaince.dart';

class SettingsLayout extends GetView<SettingsViewModel> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: loginColors,
              stops: [0.1, 0.4, 0.7, 0.9],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Center(
              child: Obx(
            () => CustomInput(
              onChange: (nV) {
                if (nV != null) controller.phoneNumber.value = nV;
              },
              defaultValue: controller.phoneNumber.value,
            ),
          )),
        ),
        Positioned(
          child: FloatingActionButton(
            child: const Icon(Icons.logout),
            onPressed: () => controller.logOut(),
          ),
          bottom: 8,
          left: 8,
        )
      ],
    );
  }
}
