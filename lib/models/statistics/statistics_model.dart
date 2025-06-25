import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

import '../item/item.dart';
import '../item/item_calculations.dart';

class ItemsChartData<T> {
  ItemsChartData(
      {required this.tag, this.value, required this.items, this.color});
  final T tag;
  final double? value;
  final List<ItemModel> items;
  final Color? color;
  DateTime get date {
    if (tag is DateTime) {
      return tag as DateTime;
    } else if (tag is String) {
      return DateTime.parse(tag.toString());
    } else {
      throw Exception('tag is not DateTime or String');
    }
  }

  num get total {
    return Random().nextInt(100);
  }

  /// get a random color as rgb for the tag
  Color get randomColor {
    return Color.fromARGB(
        150, Random().nextInt(255), Random().nextInt(255), (167));
  }

  //////// get ItemCalculations /////////////////////////////////
  ItemCalculations get itemCalculations => ItemCalculations(items: items);
}

// class ShopsChartData {
//   ShopsChartData(
//       {required this.tag, this.value, required this.shops, this.color});
//   final String tag;
//   final double? value;
//   final List<ShopModel>? shops;
//   final Color? color;
//   DateTime? date;
// }

var d = Color.fromARGB(151, 255, 167, 167);
