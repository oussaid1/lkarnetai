part of 'kitchen_element_bloc.dart';

abstract class KitchenElementEvent extends Equatable {
  const KitchenElementEvent();

  @override
  List<Object> get props => [];
}

class GetKitchenElementsEvent extends KitchenElementEvent {}

class LoadKitchenElementsEvent extends KitchenElementEvent {
  final List<KitchenElementModel> kitchenElements;
  LoadKitchenElementsEvent({required this.kitchenElements});
  @override
  List<Object> get props => [kitchenElements];
}

class AddKitchenElementEvent extends KitchenElementEvent {
  final KitchenElementModel kitchenElement;
  AddKitchenElementEvent({required this.kitchenElement});
  @override
  List<Object> get props => [kitchenElement];
}

class UpdateKitchenElementEvent extends KitchenElementEvent {
  final KitchenElementModel kitchenElement;
  UpdateKitchenElementEvent({required this.kitchenElement});
  @override
  List<Object> get props => [kitchenElement];
}

class DeleteKitchenElementEvent extends KitchenElementEvent {
  final KitchenElementModel kitchenElement;
  DeleteKitchenElementEvent({required this.kitchenElement});
  @override
  List<Object> get props => [kitchenElement];
}
