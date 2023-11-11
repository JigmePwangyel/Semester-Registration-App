class PaymentResponse {
  final List<PaymentDetail> paymentDetail;
  final String scholarshipType;
  final List<dynamic> feeBreakdown;
  final int totalFee;

  PaymentResponse({
    required this.scholarshipType,
    required this.feeBreakdown,
    required this.paymentDetail,
    required this.totalFee,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> paymentDetailData = json['paymentDetail'];
    final List<dynamic> feeBreakdownData = json['feeBreakdown'];
    final String scholarshipType = json['scholarshipType'];
    final int totalFee = json['totalFee'];
    print(feeBreakdownData);
    final List<PaymentDetail> paymentDetail =
        paymentDetailData.map((item) => PaymentDetail.fromJson(item)).toList();

    return PaymentResponse(
      scholarshipType: scholarshipType,
      feeBreakdown: feeBreakdownData,
      totalFee: totalFee,
      paymentDetail: paymentDetail,
    );
  }
}

class FeeBreakdown {
  final int? tuition;
  final int? hostel;

  FeeBreakdown({
    required this.tuition,
    required this.hostel,
  });

  factory FeeBreakdown.fromJson(Map<String, dynamic> json) {
    return FeeBreakdown(
      tuition: json['Tuition'],
      hostel: json['Hostel'],
    );
  }
}

class PaymentDetail {
  final String? paymentDate;
  final int? amount;
  final String? receiptNumber;
  final String? journalNumber;

  PaymentDetail({
    required this.paymentDate,
    required this.amount,
    required this.receiptNumber,
    required this.journalNumber,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) {
    return PaymentDetail(
      paymentDate: json['payment_date'],
      amount: json['amount'],
      receiptNumber: json['paymentID'].toString(),
      journalNumber: json['journal_number'],
    );
  }
}

// class PaymentResponse {
//   final String scholarshipType;
//   final List<dynamic> feeBreakdown;
//   final int totalFee;
//   final Map<String, dynamic> paymentDetail;

//   PaymentResponse({
//     required this.scholarshipType,
//     required this.feeBreakdown,
//     required this.totalFee,
//     required this.paymentDetail,
//   });

//   factory PaymentResponse.fromJson(Map<String, dynamic> json) {
//     final int totalFee = json['totalFee'];

//     final String scholarshipType = json['scholarshipType'];
//     final List<dynamic> feeBreakdownData = json['feeBreakdown'];

//     final Map<String, dynamic> paymentDetailData = json['paymentDetail'];
//     final Map<String, dynamic> paymentDetail =
//         Map<String, dynamic>.from(paymentDetailData);

//     return PaymentResponse(
//       scholarshipType: scholarshipType,
//       feeBreakdown: feeBreakdownData,
//       totalFee: totalFee,
//       paymentDetail: paymentDetail,
//     );
//   }
// }
