
import 'package:lkarnet/models/shop/shop_model.dart';

abstract class ShopDbInterface {
  void addShop(ShopModel shopModel);
  bool deleteShop(ShopModel shopModel);
  bool updateShop(ShopModel shopModel);
  Stream<List<ShopModel>> getShops();
}
