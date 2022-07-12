class Payment {
  final int id;
  final int studentId;
  final int amountPaid;
  final String type;
  final String payNum;
  final DateTime? createdAt;
  final String name;
  final String convertedDate;

  Payment(
      {this.id = 0,
      this.studentId = 0,
      this.amountPaid = 0,
      this.type = "",
      this.payNum = "",
      this.createdAt,
      this.name = "",
      this.convertedDate = ""});
  factory Payment.fromJson(dynamic json) {
    DateTime? time = (json['created_at'] == null)
        ? null
        : DateTime.parse(json['created_at']);
    var timeString = '';
    if (time != null) {
      timeString += " ${time.hour}:${time.minute} ";
      timeString += "${time.year}/${time.month}/${time.day}";
    }
    return Payment(
      id: json['id'],
      studentId: json['student_id'],
      amountPaid: json['amount_paid'],
      type: json['type'],
      payNum: json['pay_num'],
      createdAt: time,
      convertedDate: timeString,
    );
  }
}

class PaymentResponse {
  final bool status;
  final errorNum;
  final msg;
  final List<Payment> payments;

  PaymentResponse(
      {this.status = false, this.errorNum, this.msg, required this.payments});

  factory PaymentResponse.fromJson(dynamic json) {
    List<Payment> list;
    var msg = json['msg'] ?? "";
    if (json['payments'] == null) {
      list = [];
    } else {
      list = (json['payments'] as List)
          .map((pay) => Payment.fromJson(pay))
          .toList();
    }
    return PaymentResponse(
        payments: list,
        status: json['status'] ?? false,
        errorNum: json['errNum'] ?? "",
        msg: msg);
  }
}
