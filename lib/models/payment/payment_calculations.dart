import 'payment_model.dart';

class PaymentCalculations {
  List<PaymentModel> payments;
  PaymentCalculations({required this.payments});
  /////////////////////////////////////////////////////////////////
  /// count payments
  int get countPayments =>
      payments.fold(0, (sum, payment) => sum + payment.count);

  ///sum of all payments
  double get paymentsSum =>
      payments.fold(0, (sum, payment) => sum + payment.paidAmount);
}
