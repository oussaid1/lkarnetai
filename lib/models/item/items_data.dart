import '../statistics/statistics_model.dart';
import 'item.dart';
import 'package:lkarnet/components.dart';

class ItemsData {
  final List<ItemModel> items;
  ItemsData({required this.items});
  // int countIterations = 0;

  /// a setter for the items list
  /// a getter for the items list
  List<ItemModel> get itemz => items;
  // compare two Strings and check number of matching letters
  int compareStrings(String a, String b) {
    int count = 0;
    for (int i = 0; i < a.length; i++) {
      if (a[i] == b[i]) {
        count++;
      }
    }
    return count;
  }

  //// get distinct item names ///////////////////////////////////////////////
  List<String> get distinctItemNames {
    List<String> distinctItemNames = [];
    for (var it in items) {
      distinctItemNames.add(it.itemName);
    }
    return distinctItemNames.toSet().toList();
  }

  // get distinct ddmmyyyy
  List<DateTime> get distinctDays {
    List<DateTime> ddmmyyyys = [];
    for (var it in items) {
      ddmmyyyys.add(
        DateTime(it.dateBought.year, it.dateBought.month, it.dateBought.day),
      );
    }
    return ddmmyyyys.toSet().toList();
  }

  // get distinct mmyyy from items
  List<DateTime> get distinctMonths {
    var list = <DateTime>[];
    for (var item in items) {
      list.add(DateTime(item.dateBought.year, item.dateBought.month));
    }
    return list.toSet().toList();
  }

  // get distinct yyyy
  List<DateTime> get distinctYears {
    var list = <DateTime>[];
    for (var item in items) {
      list.add(DateTime(item.dateBought.year));
    }

    return list.toSet().toList();
  }

  // get mmyyy ItemsData
  List<ItemsChartData<DateTime>> get dailyItemsChartData {
    var list = <ItemsChartData<DateTime>>[];
    for (var date in distinctDays) {
      list.add(
        ItemsChartData<DateTime>(
          tag: date,
          items: items
              .where((element) => element.dateBought.isMatchDay(date))
              .toList(),
        ),
      );
    }
    return list;
  }

  // get mmyyy ItemsData
  List<ItemsChartData<DateTime>> get monthlyItemsChartData {
    var list = <ItemsChartData<DateTime>>[];
    for (var it in distinctMonths) {
      list.add(
        ItemsChartData<DateTime>(
          tag: it,
          items: items
              .where((element) => element.dateBought.isMatchMonth(it))
              .toList(),
        ),
      );
    }
    return list;
  }

  // get yyyy ItemsData
  List<ItemsChartData<DateTime>> get yearlyItemsChartData {
    var list = <ItemsChartData<DateTime>>[];
    for (var it in distinctYears) {
      list.add(
        ItemsChartData<DateTime>(
          tag: it,
          items: items
              .where((element) => element.dateBought.isMatchYear(it))
              .toList(),
        ),
      );
    }
    return list;
  }

  //// get chartData for each item name
  List<ItemsChartData> get itemsByNameChartData {
    var list = <ItemsChartData>[];
    for (var it in distinctItemNames) {
      list.add(
        ItemsChartData(
          tag: it,
          items: items
              .where((element) => element.itemName.trim() == it.trim())
              .toList(),
        ),
      );
    }
    return list;
  }

  //// get chartData for each item name Daily
  List<ItemsChartData> get itemsByNameDailyChartData {
    var list = <ItemsChartData>[];
    for (var element in distinctDays) {
      element;
    }
    for (var it in distinctItemNames) {
      list.add(
        ItemsChartData(
          tag: it,
          items: items
              .where((element) => element.itemName.trim() == it.trim())
              .toList(),
        ),
      );
    }
    return list;
  }

  ////////////////////////////////////////////////////
  ///////////////////////////////////////////////////
  /// get this most recent items bought
  List<ItemModel> get mostRecentItems {
    if (items.isEmpty) {
      return [];
    }
    DateTime mostRecent = items[0].dateBought;
    return items
        .where((element) => element.dateBought.isMatchDay(mostRecent))
        .toList();
  }
}
