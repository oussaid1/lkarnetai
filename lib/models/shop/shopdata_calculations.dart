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
    int x = 0;
    for (var element in items) {
      x += element.count;
    }
    return x;
  }

  double get paymentsSum {
    return payments.fold(0, (sum, payment) => sum + payment.paidAmount);
  }

  int get countPayments {
    int x = 0;
    for (var element in payments) {
      x += element.count;
    }
    return x;
  }

  // get percentage between paymentsSum and itemsSum
  double get spendingsUnitinterval {
    double percentage = 0;
    if (itemsSum > 0) {
      percentage = paymentsSum / itemsSum;
    }
    if (percentage > 1) {
      return 1.0;
    }
    if (percentage < 0) {
      return 0;
    }
    return percentage;
  }

  double get spendingsPecentage {
    double percentage = 0;
    if (itemsSum > 0) {
      percentage = (paymentsSum * 100) / itemsSum;
    }
    percentage;
    if (percentage > 100) {
      return 1.0;
    }
    if (percentage < 0) {
      return 0;
    }
    return percentage.toPrecision(2);
  }
}
