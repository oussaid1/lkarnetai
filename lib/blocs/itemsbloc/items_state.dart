part of 'items_bloc.dart';

enum ItemsStatus {
  initial,
  loading,
  loaded,
  added,
  updated,
  deleted,
  error,
}

/// ItemsState is the state of the ItemsBloc.
class ItemsState extends Equatable {
  final ItemsStatus status;
  final List<ItemModel> items;
  final ItemModel? item;
  final String error;
  const ItemsState(
      {required this.status,
      required this.items,
      this.item,
      required this.error});

  /// copyWith() is used to create a new instance of the state.
  /// This is used to avoid changing the state of the bloc.
  ItemsState copyWith(
      {ItemsStatus? status,
      List<ItemModel>? items,
      ItemModel? item,
      String? error}) {
    return ItemsState(
        status: status ?? this.status,
        item: item ?? this.item,
        items: items ?? this.items,
        error: error ?? this.error);
  }

  @override
  List<Object> get props => [status, items, error];
}
