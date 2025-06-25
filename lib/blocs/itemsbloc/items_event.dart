part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

///  get items from database
class GetItemsEvent extends ItemsEvent {}

/// load items event
class LoadItemsEvent extends ItemsEvent {
  final List<ItemModel> items;
  LoadItemsEvent(this.items);
  @override
  List<Object> get props => [items];
}

/// add item to database
class AddItemEvent extends ItemsEvent {
  final ItemModel item;

  AddItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

/// Delete item from database
class DeleteItemEvent extends ItemsEvent {
  final ItemModel item;

  DeleteItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

/// Update item in database
class UpdateItemEvent extends ItemsEvent {
  final ItemModel item;

  UpdateItemEvent(this.item);

  @override
  List<Object> get props => [item];
}
