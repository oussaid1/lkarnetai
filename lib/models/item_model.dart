import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  final String? id;
  final String itemName;
  String? besoinTitle;
  String? quantifier;
  final int quantity;
  final num itemPrice;
  final String shopName;
  final DateTime dateBought;
  int count;

  ItemModel({
    this.id,
    required this.itemName,
    this.besoinTitle,
    this.quantifier,
    required this.quantity,
    this.itemPrice = 0,
    required this.shopName,
    required this.dateBought,
    this.count = 1,
  }) {
    if (quantifier == null || quantifier!.trim().isEmpty) {
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
  // Your existing ItemModel class code here

  // Add this static method to your ItemModel class
  factory ItemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ItemModel.fromMap(data);
  }

  static ItemModel fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      itemName: map['itemName'] ?? '',
      besoinTitle: map['besoinTitle'],
      quantifier: map['quantifier'],
      quantity: map['quantity'] ?? 0,
      itemPrice: map['itemPrice'] ?? 0,
      shopName: map['shopName'] ?? '',
      dateBought: (map['dateBought'] is Timestamp)
          ? (map['dateBought'] as Timestamp).toDate()
          : (map['dateBought'] is DateTime)
          ? map['dateBought']
          : DateTime.now(),
      count: map['count'] ?? 1,
    );
  }
}
