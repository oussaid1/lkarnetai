part of 'payments_bloc.dart';

abstract class PaymentsEvent extends Equatable {
  const PaymentsEvent();

  @override
  List<Object> get props => [];
}

/// load payments event
class LoadPaymentsEvent extends PaymentsEvent {
  final List<PaymentModel> payments;

  const LoadPaymentsEvent(this.payments);

  @override
  List<Object> get props => [payments];
}

/// get payments event
class GetPaymentsEvent extends PaymentsEvent {}

/// add payment event
class AddPaymentEvent extends PaymentsEvent {
  final PaymentModel payment;

  const AddPaymentEvent(this.payment);

  @override
  List<Object> get props => [payment];
}

/// delete payment event
class DeletePaymentEvent extends PaymentsEvent {
  final PaymentModel payment;

  const DeletePaymentEvent(this.payment);

  @override
  List<Object> get props => [payment];
}

/// update payment event
class UpdatePaymentEvent extends PaymentsEvent {
  final PaymentModel payment;

  const UpdatePaymentEvent(this.payment);

  @override
  List<Object> get props => [payment];
}
