import 'package:flutter/material.dart';
import 'package:kindergarten/models/payment_response.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';

class CustomPayment extends StatelessWidget {
  final Payment payment;

  const CustomPayment({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Directionality(
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
                      text: "رقم الايصال :",
                      alignment: Alignment.topRight,
                      fontSize: 18,
                      weight: FontWeight.bold,
                    ),
                    Flexible(
                      child: CustomText(
                        text: payment.payNum,
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
                      text: "المبلغ المدفوع :",
                      alignment: Alignment.topRight,
                      fontSize: 18,
                      weight: FontWeight.bold,
                    ),
                    CustomText(
                      text: payment.amountPaid.toString(),
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
                      text: "تاريخ الدفع",
                      alignment: Alignment.topRight,
                      fontSize: 18,
                      weight: FontWeight.bold,
                    ),
                    CustomText(
                      text: payment.convertedDate,
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
    );
  }
}
