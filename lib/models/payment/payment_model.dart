import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as df;

class PaymentModel {
  String? id;
  int count = 1;
  String? image = "logo.png";
  String? besoinTitle;
  double paidAmount = 0;
  String? paidShopName;
  DateTime datePaid = DateTime.now();
  String? get fullImage {
    return 'assets/images/$image';
  }

  double get paid {
    double s = 0.0;
    s = paidAmount;
    return s;
  }

  String get formattedDate {
    final df.DateFormat _formatter = df.DateFormat('MMMEd');
    return _formatter.format(datePaid).toString();
  }

  PaymentModel(
      {this.id,
      this.besoinTitle,
      this.paidAmount = 0.0,
      this.paidShopName,
      required this.datePaid,
      this.count = 1});
  Map<String, dynamic> toMap() {
    return {
      'paidAmount': paidAmount,
      'paidShopName': paidShopName,
      'datePaid': datePaid,
      'besoinTitle': besoinTitle,
      'count': count,
    };
  }

  String get toMMYY {
    final df.DateFormat _formatter = df.DateFormat('MM-yy');
    return _formatter.format(datePaid);
  }

  String get toYY {
    final df.DateFormat _formatter = df.DateFormat('yy');
    return _formatter.format(datePaid);
  }

  String get toDDMMYY {
    final df.DateFormat _formatter = df.DateFormat('dd-MM-yy');
    return _formatter.format(datePaid);
  }

  PaymentModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    besoinTitle = documentSnapshot['besoinTitle'];
    paidAmount = documentSnapshot['paidAmount'] / 1;
    paidShopName = documentSnapshot['paidShopName'];
    datePaid = documentSnapshot['datePaid'].toDate();
    count = documentSnapshot['count'];
  }
}
