import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lkarnet/components.dart';

class ItemModel {
  // a zero argument constructor
  // Item();
  String? id;
  String? besoinTitle;
  late String shopName;
  late String itemName;
  String? quantifier;
  double quantity = 1;
  double itemPrice = 0;
  int count = 1;
  DateTime dateBought = DateTime.now();

  double get itemPrix => itemPrice * quantity;
  bool isSelected = false;
  ItemModel({
    this.id,
    required this.itemName,
    this.besoinTitle,
    this.quantifier,
    required this.quantity,
    this.itemPrice = 0,
    required this.shopName,
    required this.dateBought,
    count = 1,
  }) {
    if (quantifier!.trim().isEmpty) {
      quantifier = 'piece';
    }
  }
  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'quantifier': quantifier,
      'besoinTitle': besoinTitle,
      'quantity': quantity,
      'itemPrice': itemPrice,
      'shopName': shopName,
      'dateBought': dateBought,
      'count': count,
    };
  }

  Map<String, dynamic> toMapForArch() {
    return {
      // 'id': id,
      'itemName': itemName,
      'quantifier': quantifier,
      'besoinTitle': besoinTitle,
      'quantity': quantity,
      'itemPrice': itemPrice,
      'shopName': shopName,
      'dateBought': dateBought,
      'count': count,
    };
  }

  String get formattedDate {
    return dateBought.formatted();
  }

  ItemModel.fromDocumentSnapshot(QueryDocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    besoinTitle = documentSnapshot['besoinTitle'];
    itemName = documentSnapshot['itemName'].trim();
    quantifier = documentSnapshot['quantifier'];
    quantity = documentSnapshot['quantity'].toDouble();
    itemPrice = (documentSnapshot['itemPrice']).toDouble() ?? 0;
    shopName = documentSnapshot['shopName'];
    Timestamp f = documentSnapshot['dateBought'];
    dateBought = f.toDate();
  }
  String get toDDMMYY {
    return dateBought.ddmmyyyy();
  }

  void toPrint() {
    print('-------------------------------');
    print('name : $itemName');
    print('quantifier : $quantifier');
    print('quantity : $quantity');
    print('itemPrice : $itemPrice');
    print('besoinTitle : $besoinTitle');
    print('shopName : $shopName');
    print('dateBought : $toDDMMYY');
    print('-------------------------------');
  }

  /// to json method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemName': itemName,
      'quantifier': quantifier,
      'besoinTitle': besoinTitle,
      'quantity': quantity,
      'itemPrice': itemPrice,
      'shopName': shopName,
      'dateBought': dateBought.toIso8601String(),
      'count': count,
    };
  }

  /// from json method
  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //itemName = json['itemName'] == 'زيت لعود' ? 'زيت العود' : json['itemName'];
    itemName = json['itemName'];
    quantifier = json['quantifier'];
    besoinTitle = json['besoinTitle'];
    quantity = json['quantity'].toDouble();
    itemPrice = json['itemPrice'].toDouble();
    shopName = json['shopName'];
    dateBought = DateTime.parse(json['dateBought']);
    count = json['count'];
  }
}
