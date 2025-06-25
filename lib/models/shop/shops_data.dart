import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import '../item/items_data.dart';
import 'shop_model.dart';
import 'shopdata_calculations.dart';

class ShopData {
  ShopModel shop;
  List<ItemModel> items;
  List<PaymentModel> payments;
  ShopData({required this.shop, required this.items, required this.payments});
  /////////////////////////////////////////////////////////////////
  /// get an inctance of shopdata calculations
  ShopDataCalculations get shopDataCalculations =>
      ShopDataCalculations(items: items, payments: payments);

///////////////////////////////////////////////////////////////
  // get itemsData
  ItemsData get itemsDataForAll {
    return ItemsData(items: items);
  }
}
