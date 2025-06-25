part of 'kitchen_item_bloc.dart';

enum KitchenItemStatus {
  initial,
  loading,
  loaded,
  added,
  updated,
  deleted,
  allDeleted,
  error,
}

class KitchenItemState extends Equatable {
  final KitchenItemStatus status;
  final List<KitchenItemModel> kitchenItems;
  final KitchenItemModel? kitchenItem;
  final String error;
  const KitchenItemState(
      {required this.status,
      required this.kitchenItems,
      this.kitchenItem,
      required this.error});

  /// copyWith() is used to create a new instance of the state.
  /// This is used to avoid changing the state of the bloc.
  KitchenItemState copyWith(
      {KitchenItemStatus? status,
      List<KitchenItemModel>? kitchenItems,
      KitchenItemModel? kitchenItem,
      String? error}) {
    return KitchenItemState(
        status: status ?? this.status,
        kitchenItem: kitchenItem ?? this.kitchenItem,
        kitchenItems: kitchenItems ?? this.kitchenItems,
        error: error ?? this.error);
  }

  @override
  List<Object> get props => [status, kitchenItems, error];
}
