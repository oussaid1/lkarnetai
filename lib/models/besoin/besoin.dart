import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lkarnet/models/shop/shop_model.dart';

class BesoinModel {
  String? id;
  int count = 1;
  DateTime timeStamp = DateTime.now();
  String title = '';
  String? categoryTitle;
  String? image;
  double limit = 0;
  List<ShopModel> shops = [];

  String get imageFullPath => 'assets/images/$image';

  BesoinModel({
    this.id,
    this.categoryTitle,
    required this.timeStamp,
    required this.title,
    this.image,
    required this.limit,
    count = 1,
  });

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  Map<String, dynamic> toMap() {
    return {
      'timeStamp': timeStamp,
      'title': title,
      'image': image,
      'count': count,
      'limit': limit,
      'categoryTitle': categoryTitle,
    };
  }

  BesoinModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    categoryTitle = documentSnapshot['categoryTitle'];
    image = documentSnapshot['image'] ?? '';
    title = documentSnapshot['title'];
    limit = double.parse(documentSnapshot['limit'].toString());
    Timestamp f = documentSnapshot['timeStamp'];
    timeStamp = f.toDate();
    count = documentSnapshot['count'];
  }

  static var sample = BesoinModel(
    limit: 0,
    timeStamp: DateTime.now(),
    categoryTitle: "اساسي",
    image: "logo.png",
    title: "سوق",
  );
}
