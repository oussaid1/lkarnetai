part of 'shops_bloc.dart';

enum ShopsStatus {
  initial,
  loading,
  loaded,
  added,
  updated,
  deleted,
  error,
}

class ShopsState extends Equatable {
  final ShopsStatus status;
  final List<ShopModel> shops;
  final ShopModel? shop;
  final String error;
  ShopsState({
    required this.status,
    required this.shops,
    this.shop,
    required this.error,
  });

  /// Copy object for use in Bloc
  ShopsState copyWith({
    ShopsStatus? status,
    List<ShopModel>? shops,
    ShopModel? shop,
    String? error,
  }) {
    return ShopsState(
      status: status ?? this.status,
      shops: shops ?? this.shops,
      shop: shop ?? this.shop,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, shops, error];
}
