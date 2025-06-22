import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add an item
  Future<void> addItem(ItemModel item) async {
    await _firestore.collection(DBTables.items).add(item.toMap());
  }

  // Get all items (as a stream)
  Stream<List<ItemModel>> getItems() {
    return _firestore
        .collection(DBTables.items)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => ItemModel.fromFirestore(doc)).toList(),
        );
  }

  // Update an item
  Future<void> updateItem(String id, Map<String, dynamic> data) async {
    await _firestore.collection(DBTables.items).doc(id).update(data);
  }

  // Delete an item
  Future<void> deleteItem(String id) async {
    await _firestore.collection(DBTables.items).doc(id).delete();
  }
}

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
