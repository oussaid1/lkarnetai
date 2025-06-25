import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lkarnet/components.dart';

import '../item/item.dart';
import 'kitchen_element.dart';

//import '../item/item.dart';

class KitchenItemModel {
  String? id;
  String kitchenElementId = "";
  String? besoinTitle;
  String? shopName;
  String? itemName;
  String? quantifier;
  double quantity = 1;
  double itemPrice = 0;
  int count = 1;
  KitchenItemModel({
    this.id,
    this.besoinTitle,
    required this.shopName,
    required this.itemName,
    this.quantifier,
    required this.quantity,
    required this.itemPrice,
    this.count = 1,
    required this.kitchenElementId,
    required this.dateBought,
    required this.dateExpired,
  });
  DateTime dateBought = DateTime.now();
  DateTime? dateExpired; // double get itemPrix => itemPrice * quantity;
// is expired
  bool get isExpired {
    return dateExpired != null; // && dateExpired!.isBefore(DateTime.now());
  }

  double get itemPrix => itemPrice * quantity;
  KitchenItemModel copyWith({
    String? id,
    String? besoinTitle,
    String? shopName,
    String? itemName,
    String? quantifier,
    double? quantity,
    double? itemPrice,
    int? count,
    DateTime? dateBought,
    DateTime? dateExpired,
    String? kitchenElementId,
  }) {
    return KitchenItemModel(
        id: id ?? this.id,
        besoinTitle: besoinTitle ?? this.besoinTitle,
        shopName: shopName ?? this.shopName,
        itemName: itemName ?? this.itemName,
        quantifier: quantifier ?? this.quantifier,
        quantity: quantity ?? this.quantity,
        itemPrice: itemPrice ?? this.itemPrice,
        count: count ?? this.count,
        dateBought: dateBought ?? this.dateBought,
        dateExpired: dateExpired,
        kitchenElementId: kitchenElementId ?? this.kitchenElementId);
  }

  Map<String, dynamic> toMap() {
    return {
      'besoinTitle': besoinTitle,
      'shopName': shopName,
      'itemName': itemName,
      'quantifier': quantifier,
      'quantity': quantity,
      'itemPrice': itemPrice,
      'count': count,
      'dateBought': dateBought,
      'dateExpired': dateExpired,
      'kitchenElementId': kitchenElementId,
    };
  }

  KitchenItemModel.fromItem(
      ItemModel item, KitchenElementModel kitchenElement) {
    this.besoinTitle = item.besoinTitle;
    this.shopName = item.shopName;
    this.itemName = item.itemName;
    this.quantifier = item.quantifier;
    this.quantity = item.quantity;
    this.itemPrice = item.itemPrice;
    this.count = item.count;
    this.dateBought = item.dateBought;
    this.dateExpired = null;
    this.kitchenElementId = kitchenElement.id!;
  }
  KitchenItemModel.fromDocumentSnapShot(
      QueryDocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    besoinTitle = documentSnapshot['besoinTitle'];
    itemName = documentSnapshot['itemName'].trim();
    quantifier = documentSnapshot['quantifier'];
    quantity = documentSnapshot['quantity'].toDouble();
    itemPrice = (documentSnapshot['itemPrice']).toDouble() ?? 0;
    shopName = documentSnapshot['shopName'] ?? '';
    Timestamp f1 = documentSnapshot['dateBought'];
    dateBought = f1.toDate();
    // f = documentSnapshot['dateExpired'];
    if (documentSnapshot['dateExpired'] != null) {
      Timestamp f2 = documentSnapshot['dateExpired'];
      dateExpired = f2.toDate();
    } else {
      dateExpired = documentSnapshot['dateExpired'];
    }
    kitchenElementId = documentSnapshot['kitchenElementId'] ?? '';
  }

  String get toDDMMYY {
    return dateBought.ddmmyyyy();
  }

  void toPrint() {
    print('-------------------------------');
    print('id: $id');
    print('name : $itemName');
    print('quantifier : $quantifier');
    print('quantity : $quantity');
    print('itemPrice : $itemPrice');
    print('besoinTitle : $besoinTitle');
    print('shopName : $shopName');
    print('dateBought : $toDDMMYY');
    print('dateExpired : $dateExpired');
    print('kitchenElementId : $kitchenElementId');
    print('-------------------------------');
  }

// from map
  factory KitchenItemModel.fromMap(Map<String, dynamic> map) {
    return KitchenItemModel(
      id: map['id'],
      besoinTitle: map['besoinTitle'],
      shopName: map['shopName'],
      itemName: map['itemName'],
      quantifier: map['quantifier'],
      quantity: map['quantity'],
      itemPrice: map['itemPrice'],
      count: map['count'],
      dateBought: map['dateBought'],
      dateExpired: map['dateExpired'],
      kitchenElementId: map['kitchenElementId'],
    );
  }
  String toJson() => json.encode(toMap());

  factory KitchenItemModel.fromJson(String source) =>
      KitchenItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KitchenItem(id: $id, besoinTitle: $besoinTitle,  shopName: $shopName, itemName: $itemName, quantifier: $quantifier, quantity: $quantity, itemPrice: $itemPrice, count: $count, dateBought: $dateBought, dateExpired: $dateExpired, kitchenElementId: $kitchenElementId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KitchenItemModel &&
        other.id == id &&
        other.besoinTitle == besoinTitle &&
        other.shopName == shopName &&
        other.itemName == itemName &&
        other.quantifier == quantifier &&
        other.quantity == quantity &&
        other.itemPrice == itemPrice &&
        other.count == count &&
        other.dateBought == dateBought &&
        other.dateExpired == dateExpired &&
        other.kitchenElementId == kitchenElementId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        besoinTitle.hashCode ^
        shopName.hashCode ^
        itemName.hashCode ^
        quantifier.hashCode ^
        quantity.hashCode ^
        itemPrice.hashCode ^
        count.hashCode ^
        dateBought.hashCode ^
        dateExpired.hashCode ^
        kitchenElementId.hashCode;
  }

  // list of fake data
  static List<KitchenItemModel> fakeKitchenitems() {
    return [
      KitchenItemModel(
        besoinTitle: 'test',
        shopName: 'مومو',
        itemName: 'test',
        quantifier: 'واحدة',
        quantity: 1,
        itemPrice: 1,
        count: 1,
        dateBought: DateTime.now(),
        dateExpired: DateTime.now(),
        kitchenElementId: 'VtRluxV8Sy7tQaa6yoNO',
      ),
      KitchenItemModel(
        besoinTitle: 'test',
        shopName: 'مومو',
        itemName: 'test',
        quantifier: 'واحدة',
        quantity: 1,
        itemPrice: 1,
        count: 1,
        dateBought: DateTime.now(),
        dateExpired: DateTime.now(),
        kitchenElementId: 'VtRluxV8Sy7tQaa6yoNO',
      ),
      KitchenItemModel(
        besoinTitle: 'test',
        shopName: 'مومو',
        itemName: 'test',
        quantifier: 'test',
        quantity: 1,
        itemPrice: 1,
        count: 1,
        dateBought: DateTime.now(),
        dateExpired: DateTime.now(),
        kitchenElementId: 'VtRluxV8Sy7tQaa6yoNO',
      ),
      KitchenItemModel(
        besoinTitle: 'test',
        shopName: 'مومو',
        itemName: 'test',
        quantifier: 'واحدة',
        quantity: 1,
        itemPrice: 1,
        count: 1,
        dateBought: DateTime.now(),
        dateExpired: DateTime.now(),
        kitchenElementId: 'I7ebCrvYuGKPL79sUhFl',
      ),
      KitchenItemModel(
        besoinTitle: 'test',
        shopName: 'مومو',
        itemName: 'test',
        quantifier: 'واحدة',
        quantity: 1,
        itemPrice: 1,
        count: 1,
        dateBought: DateTime.now(),
        dateExpired: DateTime.now(),
        kitchenElementId: 'I7ebCrvYuGKPL79sUhFl',
      ),
    ];
  }
}
