import 'package:lkarnet/models/payment/payment_model.dart';

abstract class PaymentDbInterface {
  void addPayment(PaymentModel payment);
  bool deletePayment(PaymentModel payment);
  bool updatePayments(PaymentModel payment);
  Stream<List<PaymentModel>> getPayments();
}
