import 'package:firebase_auth/firebase_auth.dart';
import 'package:lkarnet/database/database.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/models/kitchen/kitchen_item.dart';
import 'package:lkarnet/models/kitchen/kitchen_element.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/besoin/besoin.dart';
import 'package:lkarnet/models/user/user.dart';

class DatabaseOperations implements Database {
  final Database _database;
  DatabaseOperations(this._database);

  @override
  void setUserUid(String uid) => _database.setUserUid(uid);

  /// create user in database
  Future<void> createUser(UserModel user) async =>
      await _database.createNewUser(user);

  /// get user from database
  Future<UserModel?> getUser() async {
    return await _database.getUser();
  }

  /// update user in database
  // Future<void> updateUser(UserModel user) async {
  //   await _database.updateUser(user);
  // }

/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////ADD/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////
  /// add item to database
  Future<void> addItem(ItemModel item) async {
    await _database.addItem(item);
  }

  /// add shop to database
  Future<void> addShop(ShopModel shop) async {
    await _database.addShop(shop);
  }

  /// add payment to database
  Future<void> addPayment(PaymentModel payment) async {
    await _database.addPayment(payment);
  }

  /// add kitchen element to database
  Future<void> addKitchenElement(KitchenElementModel kitchenElement) async {
    await _database.addKitchenElement(kitchenElement);
  }

  /// add kitchen item to database
  Future<void> addKitchenItem(KitchenItemModel kitchenItem) async {
    await _database.addKitchenItem(kitchenItem);
  }

  @override
  String? uid;

  @override
  Future<void> addBesoin(BesoinModel besoin, String uid) {
    return _database.addBesoin(besoin, uid);
  }

  @override
  Future<bool> createNewUser(UserModel user) => _database.createNewUser(user);

  @override
  Future<double> dayLimitFuture() => _database.dayLimitFuture();

  @override
  Future<bool> insertToken(String token) => _database.insertToken(token);

  /// add besoin to database

/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////READ/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Stream<List<ItemModel>> archiveItemStream() => _database.archiveItemStream();

  @override
  Stream<List<BesoinModel>> besoinStream(String uid) =>
      _database.besoinStream(uid);

  @override
  Stream<List<ItemModel>> itemStream() => _database.itemStream();

  @override
  Stream<List<KitchenElementModel>> kitchenElementsStream() =>
      _database.kitchenElementsStream();

  @override
  Stream<List<KitchenItemModel>> kitchenItemsStream() =>
      _database.kitchenItemsStream();

  @override
  Stream<List<ShopModel>> shopsStream() => _database.shopsStream();
  @override
  Stream<List<PaymentModel>> paymentsStream() => _database.paymentsStream();

/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////Update/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<void> updateBesoin(BesoinModel itemToUpdate, String uid) =>
      _database.updateBesoin(itemToUpdate, uid);

  @override
  Future<void> updateItem(ItemModel itemToUpdate) =>
      _database.updateItem(itemToUpdate);

  @override
  Future<void> updateKitchenElement(KitchenElementModel kitchenElement) =>
      _database.updateKitchenElement(kitchenElement);

  @override
  Future<void> updateKitchenItem(KitchenItemModel kitchenItem) =>
      _database.updateKitchenItem(kitchenItem);
  @override
  Future<void> updatePayment(PaymentModel itemToUpdate) =>
      _database.updatePayment(itemToUpdate);

  @override
  Future<void> updateShop(ShopModel shopToUpdate) =>
      _database.updateShop(shopToUpdate);

  @override
  Future<bool> updateUser(UserModel user) => _database.updateUser(user);

/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////Delete/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<void> deleteItem(ItemModel item) => _database.deleteItem(item);

  @override
  Future<void> deleteKitchenElement(KitchenElementModel kitchenElement) =>
      _database.deleteKitchenElement(kitchenElement);

  @override
  Future<void> deleteKitchenItem(KitchenItemModel kitchenItem) =>
      _database.deleteKitchenItem(kitchenItem);

  @override
  Future<void> deletePayment(PaymentModel payment) =>
      _database.deletePayment(payment);
  @override
  Future<void> deleteShop(ShopModel shopToDelete) =>
      _database.deleteShop(shopToDelete);

  @override
  Future<void> deleteShopData(ShopData shopsData) =>
      _database.deleteShopData(shopsData);

  @override
  Future<void> deleteItems(List<ItemModel> items) =>
      _database.deleteItems(items);

  @override
  Future<void> deleteKitchenItems(List<KitchenItemModel> kitchenItems) =>
      _database.deleteKitchenItems(kitchenItems);

  @override
  Future<void> deletePayments(List<PaymentModel> payments) =>
      _database.deletePayments(payments);

  @override
  // TODO: implement user
  User? get user => throw UnimplementedError();
}
