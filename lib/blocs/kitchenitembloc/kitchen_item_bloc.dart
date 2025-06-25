import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lkarnet/models/kitchen/kitchen_item.dart';
import 'package:lkarnet/repository/database_operations.dart';

part 'kitchen_item_event.dart';
part 'kitchen_item_state.dart';

class KitchenItemBloc extends Bloc<KitchenItemEvent, KitchenItemState> {
  late final DatabaseOperations _databaseOperations;
  StreamSubscription? _kitchenItemsSubscription;
  KitchenItemBloc(DatabaseOperations databaseOperations)
      : super(KitchenItemState(
          status: KitchenItemStatus.initial,
          kitchenItems: [],
          error: '',
        )) {
    _databaseOperations = databaseOperations;
    on<GetKitchenItemsEvent>(_getKitchenItems);
    on<LoadKitchenItemsEvent>(_loadKitchenItems);
    //////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////
    /// crud operations
    on<AddKitchenItemEvent>(_addKitchenItem);
    on<UpdateKitchenItemEvent>(_updateKitchenItem);
    on<DeleteKitchenItemEvent>(_deleteKitchenItem);
    //////////////////////////////////////////////////////////////
    on<DeleteAllKitchenItems>(_deleteAllKitchenItems);
  }

  /// on Get kitchen items from the database.
  _getKitchenItems(
      GetKitchenItemsEvent event, Emitter<KitchenItemState> emit) async {
    _kitchenItemsSubscription?.cancel();
    _kitchenItemsSubscription =
        _databaseOperations.kitchenItemsStream().listen((kitchenItems) {
      add(LoadKitchenItemsEvent(kitchenItems));
    });
  }

  /// on Load kitchen items from the database.
  _loadKitchenItems(
      LoadKitchenItemsEvent event, Emitter<KitchenItemState> emit) async {
    emit(
      KitchenItemState(
        status: KitchenItemStatus.loaded,
        kitchenItems: event.kitchenItems,
        error: '',
      ),
    );
  }

  /// on Add kitchen item to the database.
  /// This will also add the kitchen item to the kitchen element.
  _addKitchenItem(
      AddKitchenItemEvent event, Emitter<KitchenItemState> emit) async {
    try {
      await _databaseOperations.addKitchenItem(event.kitchenItem);
      emit(state.copyWith(
        status: KitchenItemStatus.added,
        kitchenItem: event.kitchenItem,
      ));
    } catch (e) {
      emit(
          state.copyWith(status: KitchenItemStatus.error, error: e.toString()));
    }
  }

  /// on Update kitchen item in the database.

  _updateKitchenItem(
      UpdateKitchenItemEvent event, Emitter<KitchenItemState> emit) async {
    try {
      await _databaseOperations.updateKitchenItem(event.kitchenItem);
      emit(state.copyWith(
        status: KitchenItemStatus.updated,
        kitchenItem: event.kitchenItem,
      ));
    } catch (e) {
      emit(
          state.copyWith(status: KitchenItemStatus.error, error: e.toString()));
    }
  }

  /// on Delete kitchen item from the database.
  _deleteKitchenItem(
      DeleteKitchenItemEvent event, Emitter<KitchenItemState> emit) async {
    try {
      await _databaseOperations.deleteKitchenItem(event.kitchenItem);
      emit(state.copyWith(
        status: KitchenItemStatus.deleted,
        kitchenItem: event.kitchenItem,
      ));
    } catch (e) {
      emit(
          state.copyWith(status: KitchenItemStatus.error, error: e.toString()));
    }
  }

///////////////////////////////////////////////!/
  /// delete all kitchen items from the database.
  _deleteAllKitchenItems(
      DeleteAllKitchenItems event, Emitter<KitchenItemState> emit) async {
    try {
      await _databaseOperations.deleteKitchenItems(event.kitchenItems);
      emit(state.copyWith(
        status: KitchenItemStatus.deleted,
      ));
    } catch (e) {
      emit(
          state.copyWith(status: KitchenItemStatus.error, error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _kitchenItemsSubscription?.cancel();
    return super.close();
  }
}
