import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/repository/database_operations.dart';
import 'dart:async';
import '../../models/item/item.dart';
part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  /// stream subscription to get the items from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<ItemModel>>? _itemsSubscription;
  ItemsBloc({required DatabaseOperations databaseOperations})
    : super(ItemsState(status: ItemsStatus.initial, items: [], error: '')) {
    _databaseOperations = databaseOperations;
    on<GetItemsEvent>(_getItems);
    on<LoadItemsEvent>(_loadItems);

    /// crud operations
    on<AddItemEvent>(_addItem);
    on<UpdateItemEvent>(_updateItem);
    on<DeleteItemEvent>(_deleteItem);
  }

  /// on Get items from the database.
  _getItems(GetItemsEvent event, Emitter<ItemsState> emit) async {
    _itemsSubscription?.cancel();
    _itemsSubscription = _databaseOperations.itemStream().listen((items) {
      add(LoadItemsEvent(items));
    });
  }

  /// on Load items from the database.
  _loadItems(LoadItemsEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsState(status: ItemsStatus.loaded, items: event.items, error: ''));
  }

  /// on Add item to the database.
  _addItem(AddItemEvent event, Emitter<ItemsState> emit) async {
    try {
      await _databaseOperations.addItem(event.item);
      emit(state.copyWith(status: ItemsStatus.added, item: event.item));
    } catch (e) {
      emit(state.copyWith(status: ItemsStatus.error, error: e.toString()));
    }
  }

  /// add the item to the kitchen element
  _updateItem(UpdateItemEvent event, Emitter<ItemsState> emit) async {
    try {
      await _databaseOperations.updateItem(event.item);
      emit(state.copyWith(status: ItemsStatus.updated, item: event.item));
    } catch (e) {
      emit(state.copyWith(status: ItemsStatus.error, error: e.toString()));
    }
  }

  /// on Update item in the database.
  _deleteItem(DeleteItemEvent event, Emitter<ItemsState> emit) async {
    try {
      await _databaseOperations.deleteItem(event.item);
      emit(state.copyWith(status: ItemsStatus.deleted, item: event.item));
    } catch (e) {
      emit(state.copyWith(status: ItemsStatus.error, error: e.toString()));
    }
  }

  @override
  Future<void> close() async {
    _itemsSubscription?.cancel();
    super.close();
  }
}
