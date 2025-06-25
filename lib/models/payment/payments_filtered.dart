import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/item/items_filtered.dart';
import 'package:lkarnet/models/payment/payment_model.dart';

class PaymentsFiltered {
  List<PaymentModel> payments = [];
  DateFilter? dateFilterType;
  PaymentsFiltered({required this.payments, this.dateFilterType});

  /// get filtered payments by dateFilter
  List<PaymentModel> get paymentsByDateFilter {
    if (dateFilterType == null) {
      return payments;
    }
    return payments;
  }

  /// get payments today
  List<PaymentModel> get paymentsToday {
    return payments.where((payment) {
      return payment.datePaid.day == DateTime.now().day;
    }).toList();
  }

  /// get payments this month
  List<PaymentModel> get paymentsThisMonth {
    return payments
        .where((payment) => payment.datePaid.isMatchMonth(DateTime.now()))
        .toList();
  }

  /// get payments this year
  List<PaymentModel> get paymentsThisYear {
    return payments
        .where((payment) => payment.datePaid.isMatchYear(DateTime.now()))
        .toList();
  }

  /////////////////////////////////////////////////////////////////
  /// get distinct dates
  List<DateTime> get distinctDates {
    return payments
        .map((payment) => DateTime(payment.datePaid.day, payment.datePaid.month,
            payment.datePaid.year))
        .toSet()
        .toList();
  }

  /////////////////////////////////////////////////////////////////
  /// get distinct months
  List<DateTime> get distinctMonths {
    return payments
        .map((payment) =>
            DateTime(payment.datePaid.year, payment.datePaid.month, 1))
        .toSet()
        .toList();
  }

  /////////////////////////////////////////////////////////////////
  /// get distinct years
  List<DateTime> get distinctYears {
    return payments
        .map((payment) => DateTime(payment.datePaid.year, 1, 1))
        .toSet()
        .toList();
  }

  /////////////////////////////////////////////////////////////////
  /// methods with parameters
  List<PaymentModel> paymentsForDate(DateTime date) {
    return payments
        .where((payment) => payment.datePaid.isMatchDay(date))
        .toList();
  }

  /// methods with parameters
  List<PaymentModel> paymentsForMonth(DateTime date) {
    return payments
        .where((payment) => payment.datePaid.isMatchMonth(date))
        .toList();
  }

  /// methods with parameters
  List<PaymentModel> paymentsForYear(DateTime date) {
    return payments
        .where((payment) => payment.datePaid.isMatchYear(date))
        .toList();
  }
}
