import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/home_view_mode.dart';
import 'package:kindergarten/core/view_models/login_view_model.dart';
import 'package:kindergarten/core/view_models/settings_view_model.dart';
import 'package:kindergarten/ui/widgets/custom_button.dart';
import 'package:kindergarten/ui/widgets/custom_input.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';
import 'package:kindergarten/utils/constaince.dart';

class LogoutLayout extends GetView<HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
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
        CustomText(
          text: "هل تريد تسجيل الخروج ؟",
          alignment: Alignment.topCenter,
          fontSize: 20,
          color: Colors.white,
          margin:
              EdgeInsets.only(top: (size.height * 0.25), right: 20, left: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              onPressed: () =>controller.logOut(),
              text: "نعم",
              icon: Icons.check,
              height: 105,
              width: size.width * 0.34,
            ),
            CustomButton(
              onPressed: () => controller.onTab(0),
              text: "إلغاء",
              icon: Icons.add,
              angle: 180,
              height: 105,
              width: size.width * 0.34,
            ),
          ],
        ),
      ],
    );
  }
}
