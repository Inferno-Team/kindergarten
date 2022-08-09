import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/login_view_model.dart';
import 'package:kindergarten/ui/widgets/custom_button.dart';
import 'package:kindergarten/ui/widgets/custom_checkbox.dart';
import 'package:kindergarten/ui/widgets/custom_input.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';
import 'package:kindergarten/utils/constaince.dart';

class Login extends GetWidget<LoginViewModel> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: loginColors,
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: SizedBox(
                height: size.height,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: 'تسجيل الدخول',
                        fontSize: 30.0,
                        weight: FontWeight.bold,
                        color: Colors.white,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      CustomInput(
                        text: 'اسم المستخدم',
                        type: TextInputType.text,
                        onChange: (input) {
                          if (input != null) controller.email.value = input;
                        },
                        suffixIcon: null,
                        defaultValue: controller.email.value,
                        icon:Icons.person,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Obx(() => CustomInput(
                            text: 'كلمة السر',
                            type: TextInputType.visiblePassword,
                            obscureText: controller.visibilityIcon.value,
                            icon: Icons.lock,
                            onChange: (input) {
                              if (input != null) {
                                controller.password.value = input;
                              }
                            },
                            onSuffixIconTap: () {
                              controller.visibilityIcon.value =
                                  !controller.visibilityIcon.value;
                            },
                            suffixIcon: controller.visibilityIcon.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            defaultValue: controller.password.value,
                          )),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Obx(() => RemamberMe(
                            onChange: (bool? value) {
                              if (value != null) {
                                controller.remamberMe.value = value;
                              }
                            },
                            isChecked: controller.remamberMe.value,
                          )),
                      CustomButton(
                        text: 'تسجيل الدخول',
                        icon: Icons.login,
                        onPressed: () => controller.login(),
                        width: size.width * 0.667,
                        height: 105,
                      ),
                      CustomButton(
                        text: 'QR',
                        icon: Icons.qr_code,
                        width: size.width*0.667,
                        onPressed: () => controller.scanQR(),
                        height: 105,
                      ),
                      Obx(() {
                        switch (controller.loading) {
                          case 1:
                            return const SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          default:
                            return Container();
                        }
                      }),
                    ],
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
