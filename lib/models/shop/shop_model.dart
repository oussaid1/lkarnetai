import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lkarnet/components.dart';

class ShopModel {
  String? id;
  int count = 1;
  String? shopName;
  String? besoinTitle;
  String? email;
  String? phone;
  double? limit;
////////////////////////////////////////////////////
  double get dailyLimit =>
      ((limit ?? 1) / (DateTime.now().daysInMonth)).toPrecision(2);

  ///
  double get limitReached => limit! / dailyLimit;

  ShopModel.forMap(
      {this.id,
      this.count = 1,
      this.shopName,
      this.besoinTitle,
      this.email,
      this.phone,
      this.limit});

  ShopModel(
      {this.id,
      this.count = 1,
      this.shopName,
      this.besoinTitle,
      this.email,
      this.limit,
      this.phone});

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'shopName': shopName,
      'besoinTitle': besoinTitle,
      'email': email,
      'phone': phone,
      'limit': limit,
    };
  }

  ShopModel.fromDocumentSnapShot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    count = documentSnapshot['count'];
    shopName = documentSnapshot['shopName'];
    besoinTitle = documentSnapshot['besoinTitle'];
    email = documentSnapshot['email'];
    phone = documentSnapshot['phone'];
    limit = documentSnapshot['limit'];
  }
}
