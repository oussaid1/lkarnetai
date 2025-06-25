import 'package:lkarnet/components.dart';

import '../item/item.dart';
import '../payment/payment_model.dart';

class ShopDataCalculations {
  List<ItemModel> items;
  List<PaymentModel> payments;
  ShopDataCalculations({required this.items, required this.payments});
  /////////////////////////////////////////////////////////////////

  double get itemsSum {
    return items.fold(0, (sum, item) => sum + item.itemPrix);
  }

  double get itemsSumAfterPayment {
    return itemsSum - paymentsSum;
  }

  int get countItems {
    int _x = 0;
    items.forEach((element) => _x += element.count);
    return _x;
  }

  double get paymentsSum {
    return payments.fold(0, (sum, payment) => sum + payment.paidAmount);
  }

  int get countPayments {
    int _x = 0;
    payments.forEach((element) => _x += element.count);
    return _x;
  }

  // get percentage between paymentsSum and itemsSum
  double get spendingsUnitinterval {
    double _percentage = 0;
    if (itemsSum > 0) {
      _percentage = paymentsSum / itemsSum;
    }
    if (_percentage > 1) {
      return 1.0;
    }
    if (_percentage < 0) {
      return 0;
    }
    return _percentage;
  }

  double get spendingsPecentage {
    double _percentage = 0;
    if (itemsSum > 0) {
      _percentage = (paymentsSum * 100) / itemsSum;
    }
    _percentage;
    if (_percentage > 100) {
      return 1.0;
    }
    if (_percentage < 0) {
      return 0;
    }
    return _percentage.toPrecision(2);
  }
}
