import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/payment/payment_model.dart';

class OperationsAdapter {
  ItemModel? item;
  PaymentModel? payment;
  OperationsAdapter.fromItemsAndPayments({this.item, this.payment}) {
    if (item != null) {
      title = item!.itemName;
      date = item!.dateBought;
      amount = item!.itemPrix;
      quantity = item!.quantity;
      quantifier = item!.quantifier!.isEmpty ? "One" : item!.quantifier;
    } else if (payment != null) {
      title = payment!.paidShopName;
      date = payment!.datePaid;
      amount = payment!.paidAmount;
      quantity = 1;
      quantifier = 'paid';
    }
  }
  OperationsAdapter({
    this.title,
    required this.date,
    required this.amount,
    this.quantifier,
    this.quantity,
  });
  String? title;
  DateTime? date;
  double? amount;
  bool get isItem => item != null;
  double? quantity;
  String? quantifier;
}

class RecentOperation {
  List<ItemModel> items;
  List<PaymentModel> payments;
  RecentOperation(this.items, this.payments);

  /// take the last  items for current day else take the last items for the previous day
  List<ItemModel> get recentItems {
    var list = items;
    if (list.isNotEmpty) {
      list.sort((a, b) => b.dateBought.compareTo(a.dateBought));
      DateTime date = list[0].dateBought;
      list = list
          .where((element) =>
              element.dateBought.day == date.day &&
              element.dateBought.month == date.month &&
              element.dateBought.year == date.year)
          .toList();
    }
    return list;
  }

  /// take the last payments for current day else take the last payments for the previous day
  List<PaymentModel> get recentPayments {
    var list = payments;
    if (list.isNotEmpty) {
      list.sort((a, b) => b.datePaid.compareTo(a.datePaid));
      DateTime date = list[0].datePaid;
      list = list
          .where((element) =>
              element.datePaid.day == date.day &&
              element.datePaid.month == date.month &&
              element.datePaid.year == date.year)
          .toList();
    }
    return list;
  }

  // get a list of OperationsAdapter.fromItemsAndPayments for current shop
  List<OperationsAdapter> get recentOperationsList {
    List<OperationsAdapter> _list = [];
    recentItems.forEach((item) {
      _list.add(new OperationsAdapter.fromItemsAndPayments(item: item));
    });
    recentPayments.forEach((payment) {
      _list.add(OperationsAdapter.fromItemsAndPayments(payment: payment));
    });
    // sort by date
    _list.sort((a, b) => b.date!.compareTo(a.date!));
    return _list;
  }
}
