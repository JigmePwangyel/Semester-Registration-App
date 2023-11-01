import 'dart:convert';

class PaymentData {
  final String scholarshipType;
  final List<PaymentDetail>? paymentDetail;
  final List<FeeBreakdown>? feeBreakdown;

  PaymentData({
    required this.scholarshipType,
    this.paymentDetail,
    this.feeBreakdown,
  });
}

class FeeBreakdown {
  final String? module_code;
  final int? amount;

  FeeBreakdown({this.module_code, this.amount});
}

class PaymentDetail {
  final String? payment_date;
  final int? amount;
  final String? receipt_number;
  final String? journal_number;

  PaymentDetail(
      {this.payment_date,
      this.amount,
      this.receipt_number,
      this.journal_number});
}

PaymentData parsePaymentData(String jsonStr) {
  final jsonData = json.decode(jsonStr);
  List<FeeBreakdown> feeBreakdown = [];
  List<PaymentDetail> paymentDetail = [];

  if (jsonData['feeBreakdown'] != null) {
    feeBreakdown = List<FeeBreakdown>.from(
      jsonData['feeBreakdown'].map((item) => FeeBreakdown(
            module_code: item['module_code'],
            amount: item['amount'],
          )),
    );
  }

  if (jsonData['paymentDetail'] != null) {
    paymentDetail = List<PaymentDetail>.from(
      jsonData['paymentDetail'].map((item) => PaymentDetail(
            payment_date: item['payment_date'],
            amount: item['amount'],
            receipt_number: item['receipt_number'],
            journal_number: item['journal_number'],
          )),
    );
  }

  return PaymentData(
    scholarshipType: jsonData['scholarshipType'],
    feeBreakdown: feeBreakdown,
    paymentDetail: paymentDetail,
  );
}
