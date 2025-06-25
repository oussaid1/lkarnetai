part of 'kitchen_element_bloc.dart';

enum KitchenElementStatus {
  initial,
  loading,
  loaded,
  error,
  added,
  updated,
  deleted,
}

class KitchenElementState extends Equatable {
  final KitchenElementStatus status;
  final List<KitchenElementModel> kitchenElements;
  final KitchenElementModel? kitchenElement;
  final String error;
  KitchenElementState({
    required this.status,
    required this.kitchenElements,
    this.kitchenElement,
    required this.error,
  });
  KitchenElementState copyWith({
    KitchenElementStatus? status,
    List<KitchenElementModel>? kitchenElements,
    KitchenElementModel? kitchenElement,
    String? error,
  }) {
    return KitchenElementState(
      status: status ?? this.status,
      kitchenElements: kitchenElements ?? this.kitchenElements,
      kitchenElement: kitchenElement ?? this.kitchenElement,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, kitchenElements, error];
}
