import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/components.dart';
import 'package:flutter/material.dart';
import '../blocs/shopsbloc/shops_bloc.dart';
import '../repository/database_operations.dart';

class ShopSpinner extends StatelessWidget {
  const ShopSpinner({
    Key? key,
    required this.onShopSelected,
    this.focusNode,
    this.initialValue,
  }) : super(key: key);
  final void Function(ShopModel?) onShopSelected;
  final FocusNode? focusNode;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopsBloc(
        GetIt.I<DatabaseOperations>(),
      )..add(GetShopsEvent()),
      child: ShopDropDown(
        onShopSelected: onShopSelected,
        focusNode: focusNode,
        initialValue: initialValue,
      ),
    );
  }
}

class ShopDropDown extends StatefulWidget {
  const ShopDropDown({
    Key? key,
    required this.onShopSelected,
    this.focusNode,
    this.initialValue,
  }) : super(key: key);
  final void Function(ShopModel?) onShopSelected;
  final FocusNode? focusNode;
  final String? initialValue;
  @override
  State<ShopDropDown> createState() => _ShopDropDownState();
}

class _ShopDropDownState extends State<ShopDropDown> {
  ShopModel? _selectedShop;
  List<ShopModel> _shops = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopsBloc, ShopsState>(
      builder: (context, state) {
        if (state.shops.isNotEmpty) {
          _shops = state.shops;
          if (widget.initialValue != null &&
              _shops.any((shop) => shop.shopName == widget.initialValue)) {
            _selectedShop = _shops
                .where(
                  (shop) => shop.shopName == widget.initialValue,
                )
                .toList()[0];
          }
          // else {
          //   _selectedShop = _shops.isNotEmpty ? _shops[0] : null;
          //   widget.onShopSelected.call(_selectedShop);
          // }
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppConstants.whiteOpacity,
          ),
          margin: EdgeInsets.all(8),
          height: 45,
          width: 300,
          child: ButtonTheme(
            // focusColor: Colors.red,
            //highlightColor: Colors.red,
            alignedDropdown: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.radius),
            ),
            child: DropdownButtonFormField<ShopModel>(
              alignment: Alignment.center,
              borderRadius: BorderRadius.circular(AppConstants.radius),
              dropdownColor:
                  Color.fromARGB(108, 255, 255, 255).withOpacity(0.6),
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,

              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              elevation: 4,
              iconSize: 30,
              validator: (value) {
                if (value == null) {
                  return 'please select shop first !';
                }
                return null;
              },
              icon: Icon(Icons.arrow_drop_down),
              isExpanded: false,
              // hint: Text(
              //   "Select Shop",
              //   textAlign: TextAlign.center,
              //   style: Theme.of(context).textTheme.subtitle2,
              // ),
              value: _selectedShop,
              focusColor: AppConstants.primaryColor,
              onChanged: (value) {
                widget.onShopSelected(value);

                widget.focusNode != null
                    ? widget.focusNode!.requestFocus()
                    : null;
              },
              items: _shops.map((shop) {
                return DropdownMenuItem<ShopModel>(
                  value: shop,
                  child: Text(
                    shop.shopName ?? '',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
