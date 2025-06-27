import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'database/database.dart';

Future<void> exportAllCollections(BuildContext context) async {
  final firestore = FirebaseFirestore.instance;
  final collections = [
    DBTables.users,
    DBTables.variables,
    DBTables.shops,
    DBTables.items,
    DBTables.goods,
    DBTables.kitchenItems,
    DBTables.kitchenElements,
    DBTables.besoins,
    DBTables.kitchen,
    DBTables.payments,
    DBTables.archiveGoods,
    DBTables.categories,
    DBTables.incomes,
  ];

  Map<String, dynamic> allData = {};

  for (var collectionName in collections) {
    final collection = firestore.collection(collectionName);
    final docs = await collection.get();
    allData[collectionName] = docs.docs
        .map((doc) => {'id': doc.id, ...doc.data()})
        .toList();
  }

  final jsonString = jsonEncode(allData);

  // Save to file
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/firestore_export.json');
  await file.writeAsString(jsonString);

  // Share or let user pick location
  await Share.shareXFiles([XFile(file.path)], text: 'Firestore Export');
}
