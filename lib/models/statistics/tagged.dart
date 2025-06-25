import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import '../shop/shopdata_calculations.dart';
import '../shop/shops_data.dart';

@immutable
class Tagged<T> extends Equatable {
  final T tag;
  final List<ItemModel> items;
  final List<PaymentModel> payments;
  //List<ShopModel> shops;
  Tagged(
      {required this.tag,
      // required this.shops,
      required this.items,
      required this.payments});

  /// get date from tag
  DateTime get date => DateTime.tryParse(tag.toString()) ?? DateTime.now();

  /// get a list of shopData
  List<ShopData> get shopsDataList {
    List<ShopData> list = [];
    // for (var shop in shops) {
    //   list.add(ShopData(
    //     shop: shop,
    //     items: items,
    //     payments: payments,
    //   ));
    // }
    return list;
  }

  /// get a random color as rgb for the tag
  Color get randomColor {
    return Color.fromARGB(
        150, Random().nextInt(255), Random().nextInt(255), (167));
  }

  /// shopDataCalculations
  ShopDataCalculations get shopDataCalculations =>
      ShopDataCalculations(items: items, payments: payments);

  @override
  List<Object> get props => [tag!, items, payments];
}
