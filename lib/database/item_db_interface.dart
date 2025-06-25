import 'package:lkarnet/models/item/item.dart';

abstract class ItemDbInterface {
  void addItem(ItemModel item);
  bool deleteItem(ItemModel item);
  bool updateItem(ItemModel item);
  Stream<List<ItemModel>> getItems();
}
