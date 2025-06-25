import 'package:lkarnet/models/besoin/besoin.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components.dart';
import '../models/kitchen/kitchen_element.dart';
import '../models/kitchen/kitchen_item.dart';
import '../providers/authproviders/auth_services.dart';

class DBTables {
  static const String users = 'users';
  static const String variables = 'Variables';
  static const String shops = 'Shops';
  static const String items = 'items';
  static const String goods = 'Goods';
  static const String kitchenItems = 'KitchenItems';
  static const String kitchenElements = 'KitchenElements';
  static const String besoins = 'Besoins';
  static const String kitchen = 'kitchen';
  static const String payments = 'Payments';
  static const String archiveGoods = 'ArchiveGoods';
  static const String categories = 'Categories';
  static const String incomes = 'Incomes';
}

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get user {
    final FirebaseAuthService _firebaseAuth = FirebaseAuthService();
    return _firebaseAuth.currentUser ?? null;
  }

  var _setOptions = SetOptions(merge: true);
  final String _collectionKitchenElements = "KitchenElements";
  final String _collectionKitchenItems = "KitchenItems";

  /// set uid of current user
  void setUserUid(String uid) => this.uid = uid;
  ///////////////////////////////////////////////////////////////////////////////
  ///////// user CRUD  //////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  DocumentReference get _users =>
      _firestore.collection(DBTables.users).doc(user?.uid);
  String? uid = '';
  Database({required this.uid});

  // create user in firebase
  Future<bool> createNewUser(UserModel user) async {
    bool _done = false;
    await _firestore
        .collection(DBTables.users)
        .doc(user.id)
        .set(user.toMap(), _setOptions)
        .then((value) => _done = true)
        .catchError((error) {
      print("Failed to add user: $error");
      return _done = false;
    });
    return _done;
  }

  // insert token in firebase
  Future<bool> insertToken(String token) async {
    bool _done = false;
    await _firestore
        .collection(DBTables.users)
        .doc(uid)
        .set({'token': token}, _setOptions)
        .then((value) => _done = true)
        .catchError((error) {
          print("Failed to add token: $error");
          return _done = false;
        });
    return _done;
  }

  Future<UserModel?> getUser() async {
    UserModel? _user;
    await _users.get().then((value) =>
        _user = UserModel.fromDocumentSnapshot(documentSnapshot: value));
    return _user;
  }

  /// update user in firebase
  Future<bool> updateUser(UserModel user) async {
    bool _done = false;
    await _firestore
        .collection(DBTables.users)
        .doc(user.id)
        .set(user.toMap(), _setOptions)
        .then((value) => _done = true)
        .catchError((error) {
      print("Failed to update user: $error");
      return _done = false;
    });
    return _done;
  }

  ////////////////////////////////////////////////////////////////////////////////
  ///////// get / read  //////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
  Stream<List<BesoinModel>> besoinStream(String uid) {
    return _users
        .collection(DBTables.besoins)
        .snapshots()
        .map((QuerySnapshot query) {
      List<BesoinModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(BesoinModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<ShopModel>> shopsStream() {
    return _users
        .collection(DBTables.shops)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ShopModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(ShopModel.fromDocumentSnapShot(element));
      });
      return retVal;
    });
  }

  Future<double> dayLimitFuture() async {
    return _users
        .collection(DBTables.variables)
        .doc('dayLimit')
        .get()
        .then((value) => value['dayLimit']);
  }

  Stream<List<ItemModel>> itemStream() {
    return _users
        .collection(DBTables.goods)
        .orderBy("dateBought", descending: true)
        .snapshots()
        .map((QuerySnapshot query) => query.docs
            .map((element) => ItemModel.fromDocumentSnapshot(element))
            .toList());
  }

// get kitchenElements
  Stream<List<KitchenElementModel>> kitchenElementsStream() {
    return _users
        .collection(DBTables.kitchenElements)
        .snapshots()
        .map((QuerySnapshot query) {
      List<KitchenElementModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(KitchenElementModel.fromDocumentSnapShot(element));
      });
      return retVal;
    });
  }

  // get kitchenItems
  Stream<List<KitchenItemModel>> kitchenItemsStream() {
    return _users
        .collection(_collectionKitchenItems)
        .snapshots()
        .map((QuerySnapshot query) {
      List<KitchenItemModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(KitchenItemModel.fromDocumentSnapShot(element));
      });
      return retVal;
    });
  }

  Stream<List<ItemModel>> archiveItemStream() {
    return _users.collection(DBTables.archiveGoods).snapshots().map(
        (QuerySnapshot query) => query.docs
            .map((element) => ItemModel.fromDocumentSnapshot(element))
            .toList());
  }

  Stream<List<PaymentModel>> paymentsStream() {
    return _users
        .collection(DBTables.payments)
        .snapshots()
        .map((QuerySnapshot query) {
      List<PaymentModel> retVal = [];
      for (var element in query.docs) {
        // logger.d(element.data());
        retVal.add(PaymentModel.fromDocumentSnapshot(element));
      }
      // logger.d(retVal);
      // logger.d(retVal.length);
      return retVal;
    });
  }

///////////////////////////////////////////////////////////////////////////////
  ///////// ADD / Create  //////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  Future<void> addBesoin(BesoinModel besoin, String uid) async {
    try {
      await _users.collection(DBTables.besoins).add(besoin.toMap());
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  Future<void> addShop(
    ShopModel shop,
  ) async {
    try {
      await _users.collection(DBTables.shops).add(shop.toMap());
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  Future<void> addItem(
    ItemModel item,
  ) async {
    try {
      _users.collection(DBTables.goods).add(item.toMap());
    } catch (e) {
      Exception(e);
    }
  }

  Future<void> addPayment(
    PaymentModel payment,
  ) async {
    try {
      await _users.collection(DBTables.payments).add(payment.toMap());
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

// add KitchenElement to the kitchen
  Future<void> addKitchenElement(
    KitchenElementModel kitchenElement,
  ) async {
    try {
      await _users
          .collection(_collectionKitchenElements)
          .add(kitchenElement.toMap());
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

// add KitchenItem to the kitchen
  Future<void> addKitchenItem(KitchenItemModel kitchenItem) async {
    try {
      await _users.collection(_collectionKitchenItems).add(kitchenItem.toMap());
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

////////////////////////////////////////////////////////////////////////////////
  ///////// Update  //////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
// update KitchenElement
  Future<void> updateKitchenElement(
    KitchenElementModel kitchenElement,
  ) async {
    try {
      await _users
          .collection(_collectionKitchenElements)
          .doc(kitchenElement.id)
          .update(kitchenElement.toMap());
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

// update KitchenItem
  Future<void> updateKitchenItem(
    KitchenItemModel kitchenItem,
  ) async {
    try {
      await _users
          .collection(_collectionKitchenItems)
          .doc(kitchenItem.id!.trim().toString())
          .update(kitchenItem.toMap());
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  Future<void> updateShop(
    ShopModel shopToUpdate,
  ) async {
    try {
      _users
          .collection(DBTables.shops)
          .doc(shopToUpdate.id)
          .update(shopToUpdate.toMap());
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  Future<void> updateItem(
    ItemModel itemToUpdate,
  ) async {
    try {
      _users
          .collection(DBTables.goods)
          .doc(
            itemToUpdate.id,
          )
          .update(itemToUpdate.toMap());
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  Future<void> updatePayment(
    PaymentModel itemToUpdate,
  ) async {
    try {
      _users
          .collection(DBTables.payments)
          .doc(itemToUpdate.id)
          .update(itemToUpdate.toMap());
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  Future<void> updateBesoin(
    BesoinModel itemToUpdate,
    String uid,
  ) async {
    try {
      _users
          .collection(DBTables.besoins)
          .doc(itemToUpdate.id)
          .update(itemToUpdate.toMap());
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

///////////////////////////////////////////////////////////////////////////////
  ///////// Delete  //////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
// delete KitchenElement
  Future<void> deleteKitchenElement(
    KitchenElementModel kitchenElement,
  ) async {
    try {
      await _users
          .collection(_collectionKitchenElements)
          .doc(kitchenElement.id)
          .delete();
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  // delete KitchenItem
  Future<void> deleteKitchenItem(
    KitchenItemModel kitchenItem,
  ) async {
    try {
      await _users
          .collection(_collectionKitchenItems)
          .doc(kitchenItem.id)
          .delete();
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  /// delete bulk of kitchen items
  Future<void> deleteKitchenItems(List<KitchenItemModel> kitchenItems) async {
    try {
      for (var item in kitchenItems) {
        await _users.collection(_collectionKitchenItems).doc(item.id).delete();
      }
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  Future<void> deleteShop(ShopModel shopToDelete) async {
    try {
      _users.collection(DBTables.shops).doc(shopToDelete.id).delete();
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  /// delete item in db
  Future<void> deleteItem(ItemModel item) async {
    try {
      _users.collection(DBTables.goods).doc(item.id).delete();
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  /// dlete bulk of items in db
  Future<void> deleteItems(List<ItemModel> items) async {
    try {
      for (var item in items) {
        _users.collection(DBTables.goods).doc(item.id).delete();
      }
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  /// delete payment in db
  Future<void> deletePayment(PaymentModel payment) async {
    try {
      _users.collection(DBTables.payments).doc(payment.id).delete();
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  /// delete bulk of payments in db
  Future<void> deletePayments(List<PaymentModel> payments) async {
    try {
      for (var payment in payments) {
        _users.collection(DBTables.payments).doc(payment.id).delete();
      }
    } catch (e) {
      Exception(e);
      rethrow;
    }
  }

  Future<void> deleteShopData(ShopData shopsData) async {
    /// delete all the items of the shop
    for (var item in shopsData.items)
      try {
        _users.collection(DBTables.shops).doc(item.id).delete();
      } catch (e) {
        Exception(e);
        rethrow;
      }

    /// delete all the payments of the shop
    for (var payment in shopsData.payments)
      try {
        _users.collection(DBTables.payments).doc(payment.id).delete();
      } catch (e) {
        Exception(e);
        rethrow;
      }
  }
}
