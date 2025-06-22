// TODO Implement this library.

class ItemModel {
  // Example fields (replace with your actual fields)
   ({this.id,
      required this.itemName,
      this.besoinTitle,
      this.quantifier,
      required this.quantity,
      this.itemPrice = 0,
      required this.shopName,
      required this.dateBought,
      count = 1}) {
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
}

