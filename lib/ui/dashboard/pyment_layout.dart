import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/student_view_model.dart';
import 'package:kindergarten/models/payment_response.dart';
import 'package:kindergarten/models/student.dart';
import 'package:kindergarten/ui/widgets/custom_payment.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';
import 'package:kindergarten/utils/constaince.dart';

class PaymentLayout extends GetWidget<StudentViewModel> {
  final Student student;

  const PaymentLayout({Key? key, required this.student}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getStudentPayment(student.id);
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
        Obx(() {
          var res = controller.paymentResponse.value;
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (!res.status) {
            return Center(
                child: CustomText(
              text: res.msg,
              alignment: Alignment.center,
              weight: FontWeight.bold,
              fontSize: 17,
              color: Colors.white,
            ));
          } else {
            return ListView(
              children: [
                const CustomText(
                  text: "الدفعات",
                  alignment: Alignment.topCenter,
                  color: Colors.white,
                  fontSize: 21,
                  weight: FontWeight.w900,
                ),
                for (Payment payment in res.payments)
                  CustomPayment(payment: payment)
              ],
            );
          }
        })
      ],
    );
  }
}
