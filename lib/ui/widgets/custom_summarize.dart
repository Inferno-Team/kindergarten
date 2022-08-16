import 'package:flutter/material.dart';
import 'package:kindergarten/models/payment_response.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';

class CustomSummarize extends StatelessWidget {
  final PaymentSummarize summarize;

  CustomSummarize({required this.summarize});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: child,
          ),
        );
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Card(
            elevation: 8,
            color: const Color(0xFF73AEF5),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
            ),
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "المبلغ الكلي :",
                        alignment: Alignment.topRight,
                        fontSize: 18,
                        weight: FontWeight.bold,
                      ),
                      Flexible(
                        child: CustomText(
                          text: summarize.money.toString(),
                          alignment: Alignment.topRight,
                          fontSize: 18,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "كل المبلغ المدفوع :",
                        alignment: Alignment.topRight,
                        fontSize: 18,
                        weight: FontWeight.bold,
                      ),
                      CustomText(
                        text: summarize.sum.toString(),
                        alignment: Alignment.topRight,
                        fontSize: 18,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "المبلغ المتبقي",
                        alignment: Alignment.topRight,
                        fontSize: 18,
                        weight: FontWeight.bold,
                      ),
                      CustomText(
                        text: (summarize.money - int.parse(summarize.sum))
                            .toString(),
                        alignment: Alignment.topRight,
                        fontSize: 18,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
