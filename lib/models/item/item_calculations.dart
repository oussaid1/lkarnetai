import 'package:lkarnet/models/item/item.dart';

class ItemCalculations {
  List<ItemModel> items;
  ItemCalculations({required this.items});

  ////////////////////////////////////////////////////////////////
  ///gettter for items ///////////////////////////////////////////
  List<ItemModel> get itemz =>
      items..sort((a, b) => a.dateBought.compareTo(b.dateBought));
  ////////////////////////////////////////////////////////////////

  /// get total count of items
  int get totalCount => itemz.fold(0, (sum, item) => sum + item.count);

  /// get total price of items
  double get totalPrice => itemz.fold(0.0, (sum, item) => sum + item.itemPrix);

  /// get total quantity of items
  double get totalQuantity =>
      itemz.fold(0.0, (sum, item) => sum + item.quantity);
}
