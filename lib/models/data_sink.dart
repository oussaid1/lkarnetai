import 'package:lkarnet/models/statistics/tagged.dart';

import 'item/item.dart';
import 'payment/payment_model.dart';
import 'shop/shop_model.dart';
import 'shop/shops_data.dart';

class DataSink {
  final List<ShopModel> shops;
  final List<ItemModel> items;
  final List<PaymentModel> payments;
  DataSink({required this.shops, required this.items, required this.payments});

  /// copy with
  DataSink copyWith({
    List<ShopModel>? shops,
    List<ItemModel>? items,
    List<PaymentModel>? payments,
  }) {
    return DataSink(
      shops: shops ?? this.shops,
      items: items ?? this.items,
      payments: payments ?? this.payments,
    );
  }

  // get all shopsData
  List<ShopData> get allShopsData {
    List<ShopData> list = [];
    for (var shop in shops) {
      list.add(ShopData(
        shop: shop,
        items: items.where((item) => item.shopName == shop.shopName).toList(),
        payments: payments
            .where((payment) => payment.paidShopName == shop.shopName)
            .toList(),
      ));
    }
    return list;
  }

  /////////////////////////////////////////////////////////////////

  //// get distinct item names ///////////////////////////////////////////////
  List<String> get distinctItemNames =>
      items.map((item) => item.itemName).toSet().toList();

  // get distinct ddmmyyyy
  List<DateTime> get distinctDays => items
      .map((item) => DateTime(
          item.dateBought.day, item.dateBought.month, item.dateBought.year))
      .toSet()
      .toList()
    ..addAll(
      payments
          .map((payment) => DateTime(payment.datePaid.day,
              payment.datePaid.month, payment.datePaid.year))
          .toSet()
          .toList(),
    );

  // get distinct mmyyy from items
  List<DateTime> get distinctMonths => items
      .map((item) => DateTime(1, item.dateBought.month, item.dateBought.year))
      .toSet()
      .toList()
    ..addAll(
      payments
          .map((payment) =>
              DateTime(1, payment.datePaid.month, payment.datePaid.year))
          .toSet()
          .toList(),
    );

// get distinct yyyy
  List<DateTime> get distinctYears =>
      items.map((item) => DateTime(1, 1, item.dateBought.year)).toSet().toList()
        ..addAll(
          payments
              .map((payment) => DateTime(1, 1, payment.datePaid.year))
              .toSet()
              .toList(),
        );

  /// get filtered items
  //ItemsFiltered get filteredItems => ItemsFiltered(items: items);

  // get filtered payments
  //PaymentsFiltered get filteredPayments => PaymentsFiltered(payments: payments);

  /// /////////////////////////////////////////////////////////////////
  /// distinct shopnames
  List<String> get shopNames =>
      shops.map((shop) => shop.shopName.toString()).toList();

  /// get a list of distinct dates from payments and items
  List<DateTime> get distinctDayDates {
    List<DateTime> list = [];
    list.addAll(distinctDays);
    return list..toSet().toList();
  }

  // get distinct months from items and payments

  List<DateTime> get distinctMonthDates {
    List<DateTime> list = [];
    list.addAll(distinctMonths);
    return list..toSet().toList();
  }

  // get distinct years from items and payments
  List<DateTime> get distinctYearDates {
    List<DateTime> list = [];
    list.addAll(distinctYears);

    return list..toSet().toList();
  }

  /////////////////////////////////////////////////////////////////
  ///get a list of tagged distinct dates from payments and items
  List<Tagged> get taggedDistinctDates {
    List<Tagged> list = [];
    for (var i = 0; i < distinctDays.length; i++) {
      list.add(Tagged(
        tag: distinctDays[i],
        // shops: shops,
        items: items
            .where((item) =>
                item.dateBought.day == distinctDays[i].day &&
                item.dateBought.month == distinctDays[i].month &&
                item.dateBought.year == distinctDays[i].year)
            .toList(),
        payments: payments
            .where((payment) =>
                payment.datePaid.day == distinctDays[i].day &&
                payment.datePaid.month == distinctDays[i].month &&
                payment.datePaid.year == distinctDays[i].year)
            .toList(),
      ));
    }

    return list;
  }

  // get tagged distinct months from items and payments
  List<Tagged> get taggedDistinctMonths {
    List<Tagged> list = [];
    // for (var i = 0; i < distinctMonths.length; i++) {
    //   list.add(Tagged(
    //     tag: distinctMonths[i],
    //     shops: shops,
    //     items: filteredItems.itemsForMonth(distinctMonths[i]),
    //     payments: filteredPayments.paymentsForMonth(distinctMonths[i]),
    //   ));
    // }

    return list;
  }

  // get tagged distinct years from items and payments
  List<Tagged> get taggedDistinctYears {
    List<Tagged> list = [];
    for (var i = 0; i < distinctYears.length; i++) {
      list.add(Tagged(
        tag: distinctYears[i],
        // shops: shops,
        items: items
            .where((item) => item.dateBought.year == distinctYears[i].year)
            .toList(),
        payments: payments
            .where((payment) => payment.datePaid.year == distinctYears[i].year)
            .toList(),
      ));
    }

    return list;
  }

  /// get a list of tagged for each shop
  List<Tagged> get taggedShops {
    List<Tagged<String>> list = [];
    for (var i = 0; i < shopNames.length; i++) {
      list.add(Tagged(
        tag: shops[i].shopName!,
        //  shops: shops,
        items: items
            .where((element) => element.shopName.trim() == shopNames[i].trim())
            .toList(),
        payments: payments
            .where((element) =>
                element.paidShopName!.trim() == shopNames[i].trim())
            .toList(),
      ));
    }

    return list;
  }
}
