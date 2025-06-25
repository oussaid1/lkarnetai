import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lkarnet/repository/database_operations.dart';

import '../../models/payment/payment_model.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<PaymentModel>>? _itemsSubscription;
  PaymentsBloc(DatabaseOperations databaseOperations)
      : super(PaymentsState(
          status: PaymentsStatus.initial,
          payments: [],
          error: '',
        )) {
    this._databaseOperations = databaseOperations;
    on<GetPaymentsEvent>(_onGetPayments);
    on<LoadPaymentsEvent>(_onLoadPayments);
    on<AddPaymentEvent>(_onAddPayment);
    on<UpdatePaymentEvent>(_onUpdatePayment);
    on<DeletePaymentEvent>(_onDeletePayment);
  }
  void _onLoadPayments(
      LoadPaymentsEvent event, Emitter<PaymentsState> emit) async {
    emit(state.copyWith(
        status: PaymentsStatus.loading, payments: event.payments));
  }

  Future<void> _onGetPayments(
      PaymentsEvent event, Emitter<PaymentsState> emit) async {
    _itemsSubscription = _databaseOperations
        .paymentsStream()
        .listen((payments) => add(LoadPaymentsEvent(payments)));
  }

  Future<void> _onAddPayment(
      AddPaymentEvent event, Emitter<PaymentsState> emit) async {
    try {
      await _databaseOperations.addPayment(event.payment);
      emit(state.copyWith(status: PaymentsStatus.added));
    } catch (error) {
      emit(state.copyWith(status: PaymentsStatus.error, error: '$error'));
    }
  }

  Future<void> _onUpdatePayment(
      UpdatePaymentEvent event, Emitter<PaymentsState> emit) async {
    try {
      await _databaseOperations.updatePayment(event.payment);
      emit(state.copyWith(status: PaymentsStatus.updated));
    } catch (error) {
      emit(state.copyWith(status: PaymentsStatus.error, error: '$error'));
    }
  }

  Future<void> _onDeletePayment(
      DeletePaymentEvent event, Emitter<PaymentsState> emit) async {
    try {
      await _databaseOperations.deletePayment(event.payment);
      emit(state.copyWith(status: PaymentsStatus.deleted));
    } catch (error) {
      emit(state.copyWith(status: PaymentsStatus.error, error: '$error'));
    }
  }

  @override
  Future<void> close() {
    _itemsSubscription?.cancel();
    return super.close();
  }
}
