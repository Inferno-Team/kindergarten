class Payment {
  final id;
  final studentId;
  final amountPaid;
  final payNum;
  final DateTime? createdAt;
  final name;
  final String convertedDate;

  Payment(
      {this.id = 0,
      this.studentId = 0,
      this.amountPaid = 0,
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
      payNum: json['pay_num'] ?? "",
      createdAt: time,
      convertedDate: timeString,
    );
  }
}

class PaymentSummarize {
  final sum;
  final count;
  final int money;

  PaymentSummarize({this.sum, this.count, this.money =0});

  factory PaymentSummarize.fromJson(dynamic json) {
    return PaymentSummarize(
      sum: json['sum'],
      count: json['count'],
      money: json['money'],
    );
  }

  factory PaymentSummarize.empty() {
    return PaymentSummarize(sum: 0, count: 0, money: 0);
  }
}

class PaymentResponse {
  final bool status;
  final String? errorNum;
  final msg;
  final List<Payment> payments;
  final PaymentSummarize summarize;

  PaymentResponse(
      {this.status = false,
      this.errorNum,
      this.msg = "",
      required this.payments,
      required this.summarize});

  factory PaymentResponse.fromJson(dynamic json) {
    List<Payment> list;
    var _summarize = PaymentSummarize.empty();
    var msg = json['msg'] ?? "";
    if (json['payments'] == null) {
      list = [];
    } else {
      var payments = (json['payments'] as List<dynamic>);
      _summarize = PaymentSummarize.fromJson(payments[0][0]);
      var _dynamicList = payments[1] as List<dynamic>;
      list = _dynamicList.map((p) => Payment.fromJson(p)).toList();
    }
    return PaymentResponse(
        payments: list,
        status: json['status'] ?? false,
        errorNum: json['errNum'] ?? "",
        summarize: _summarize,
        msg: msg);
  }
}
