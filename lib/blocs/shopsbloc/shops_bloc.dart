import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lkarnet/models/shop/shop_model.dart';

import '../../repository/database_operations.dart';

part 'shops_event.dart';
part 'shops_state.dart';

class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  late final DatabaseOperations _databaseOperations;
  // ignore: unused_field
  StreamSubscription<List<ShopModel>>? _itemsSubscription;
  ShopsBloc(DatabaseOperations databaseOperations)
      : super(ShopsState(
          status: ShopsStatus.initial,
          shops: [],
          error: '',
        )) {
    this._databaseOperations = databaseOperations;

    on<GetShopsEvent>(_onGetShops);
    on<LoadShopsEvent>(_onLoadShops);

    /// crud operations
    on<AddShopEvent>(_onAddShop);
    on<UpdateShopEvent>(_onUpdateShop);
    on<DeleteShopEvent>(_onDeleteShop);
    ////////////////
  }

  /// onloadshops event
  void _onLoadShops(LoadShopsEvent event, Emitter<ShopsState> emit) async {
    emit(state.copyWith(status: ShopsStatus.loading, shops: event.shops));
  }

  /// on get shops event
  Future<void> _onGetShops(ShopsEvent event, Emitter<ShopsState> emit) async {
    _itemsSubscription = _databaseOperations
        .shopsStream()
        .listen((shops) => add(LoadShopsEvent(shops)));
  }

  /// on add shop event
  Future<void> _onAddShop(AddShopEvent event, Emitter<ShopsState> emit) async {
    try {
      await _databaseOperations.addShop(event.shop);
      emit(state.copyWith(status: ShopsStatus.added));
    } catch (error) {
      emit(state.copyWith(status: ShopsStatus.error, error: '$error'));
    }
  }

  /// on update shop event
  Future<void> _onUpdateShop(
      UpdateShopEvent event, Emitter<ShopsState> emit) async {
    try {
      await _databaseOperations.updateShop(event.shop);
      emit(state.copyWith(status: ShopsStatus.updated));
    } catch (error) {
      emit(state.copyWith(status: ShopsStatus.error, error: '$error'));
    }
  }

  /// on delete shop event
  Future<void> _onDeleteShop(
      DeleteShopEvent event, Emitter<ShopsState> emit) async {
    try {
      await _databaseOperations.deleteShop(event.shop);
      emit(state.copyWith(status: ShopsStatus.deleted));
    } catch (error) {
      emit(state.copyWith(status: ShopsStatus.error, error: '$error'));
    }
  }

  @override
  Future<void> close() {
    _itemsSubscription?.cancel();
    return super.close();
  }
}
