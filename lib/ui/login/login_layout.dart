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
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
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
            SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const  AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: 'Sign In',
                      fontSize: 30.0,
                      color: Colors.white,
                      alignment: Alignment.center,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    
                    CustomInput(
                      text: 'Email',
                     
                      type: TextInputType.emailAddress,
                      
                      onChange: (input) {
                        controller.email = input;
                      },
                      suffixIcon: null,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Obx(() {
                      if (controller.visibilityIcon.value) {
                        return CustomInput(
                          text: 'Password',
                          type: TextInputType.visiblePassword,
                          obscureText: true,
                          icon: Icons.lock,
                          onChange: (input) {
                            controller.password = input;
                          },
                          suffixIcon: Icons.visibility_off,
                        );
                      } else {
                        return CustomInput(
                          text: 'Password',
                          hint: 'Enter Your Password',
                          type: TextInputType.visiblePassword,
                          obscureText: false,
                          icon: Icons.lock,
                          onChange: (input) {
                            controller.password = input;
                          },
                          suffixIcon: Icons.visibility,
                        );
                      }
                    }),
                    const SizedBox(
                      height: 5.0,
                    ),
                    RemamberMe(
                      onChange: (bool? value) {},
                    ),
                    CustomButton(
                      text: 'LOGIN',
                      icon: Icons.login,
                      onPressed: () => controller.login(),
                    ),
                    CustomButton(
                      text: 'QR',
                      icon: Icons.qr_code,
                      onPressed: () => controller.scanQR(),
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
          ],
        ),
      ),
    );
  }
}
