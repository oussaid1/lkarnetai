part of 'shops_bloc.dart';

abstract class ShopsEvent extends Equatable {
  const ShopsEvent();

  @override
  List<Object> get props => [];
}

/// load shops event
class LoadShopsEvent extends ShopsEvent {
  final List<ShopModel> shops;

  LoadShopsEvent(this.shops);

  @override
  List<Object> get props => [shops];
}

/// get shops event
class GetShopsEvent extends ShopsEvent {}

/// add shop event
class AddShopEvent extends ShopsEvent {
  final ShopModel shop;

  AddShopEvent(this.shop);

  @override
  List<Object> get props => [shop];
}

/// delete shop event
class DeleteShopEvent extends ShopsEvent {
  final ShopModel shop;

  DeleteShopEvent(this.shop);

  @override
  List<Object> get props => [shop];
}

/// update shop event
class UpdateShopEvent extends ShopsEvent {
  final ShopModel shop;

  UpdateShopEvent(this.shop);

  @override
  List<Object> get props => [shop];
}
