import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkarnet/blocs/itemsbloc/items_bloc.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/utils.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:lkarnet/widgets/quantifier_spinner.dart';
import 'package:lkarnet/widgets/shop_spinner.dart';
import 'package:flutter/material.dart';
import '../../blocs/kitchenitembloc/kitchen_item_bloc.dart';
import '../../components.dart';
import '../../models/kitchen/kitchen_element.dart';
import '../../models/kitchen/kitchen_item.dart';
import '../../widgets/kitchen_elements_spinner.dart';

/// this is used in three places:
/// 1. - when adding new item to kitchen
/// 2. - when editing existing item in kitchen
/// 3. - when adding a normal item to to kitchen items of a selected kitchenElement
class AddKitchenItem extends StatefulWidget {
  AddKitchenItem({
    Key? key,
    this.kitchenItem,
    this.kitchenElement,
    this.item,
  }) : super(key: key);
  final ItemModel? item;
  final KitchenItemModel? kitchenItem;
  final KitchenElementModel? kitchenElement;

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddKitchenItem> {
  double _quantity = 1;
  String? _shop;
  String? _quantifier = 'واحدة';

  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPrice = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  KitchenElementModel? _kitchenElement;

  DateTime _dateBought = DateTime.now();
  DateTime? _dateExpired;

  bool _canSave = false;

  void _init() {
    // check if we have a kitchen item then update the fields
    if (widget.kitchenItem != null) {
      _itemNameController.text = widget.kitchenItem!.itemName.toString();
      _itemPriceController.text = (widget.kitchenItem!.itemPrice).toString();
      _quantity = widget.kitchenItem!.quantity;
      _shop = widget.kitchenItem!.shopName!;
      _quantifier = widget.kitchenItem!.quantifier!;
      _dateBought = widget.kitchenItem!.dateBought;
      _dateExpired = widget.kitchenItem!.dateExpired;
    }

    // check if we have an item then set all the variables to the values of the item
    if (widget.item != null) {
      _itemNameController.text = widget.item!.itemName.toString();
      _itemPriceController.text = (widget.item!.itemPrice).toString();
      _quantity = widget.item!.quantity;
      _shop = widget.item!.shopName;
      _quantifier = widget.item!.quantifier!;
      _dateBought = widget.item!.dateBought;
    }
  }

  void clearFields() {
    setState(() {
      _itemNameController.clear();
      _itemPriceController.clear();
      _quantity = 1;
      _shop = "";
      _quantifier = "";
      _dateBought = DateTime.now();
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    clearFields();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _itmBloc = context.read<KitchenItemBloc>();
    _itmBloc..add(GetKitchenItemsEvent());
    Iterable<ItemModel> _kOptions = context.watch<ItemsBloc>().state.items;
    // List<ItemModel> _kOptions = _itmBloc.state.kitchenItems;

    return GlassMaterial(
      circleWidgets: [
        Positioned(
          width: 100,
          height: 100,
          left: 10,
          top: 120,
          child: AppAssets.pinkCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          right: 80,
          top: 200,
          child: AppAssets.purpleCircleWidget,
        ),
        Positioned(
          width: 140,
          height: 140,
          left: 30,
          bottom: 80,
          child: AppAssets.blueCircleWidget,
        ),
      ],
      gradientColors: AppConstants.myGradients,
      centerWidget: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(context),
        body: BluredContainer(
          margin: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTitle(context),
                widget.item != null
                    ? _buildKitchenElementSpinner()
                    : SizedBox.shrink(),
                _buildShopSpinner(),
                _buildItemNameAutoComplete(context, _kOptions),
                _buildItemPrice(),
                _buildSelectDateBought(),
                _buildQuantityFier(),
                SizedBox(
                  height: 40,
                ),
                _buildSave(context, _itmBloc)
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      shadowColor: Colors.transparent,
      excludeHeaderSemantics: true,
      toolbarHeight: 40,
      backgroundColor: AppConstants.whiteOpacity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radius),
          bottom: Radius.circular(AppConstants.radius),
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        widget.kitchenElement != null ? "تعديل المادة" : "اضافة مادة",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  _buildSave(BuildContext context, _itmBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 120,
          child: ElevatedButton(
              child: Text(
                'Cancel',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: MThemeData.raisedButtonStyleCancel),
        ),
        Container(
          width: 120,
          child: ElevatedButton(
              child: Text(widget.item != null ? 'Update' : 'Save'),
              onPressed: !_canSave
                  ? null
                  : () {
                      GlobalFunctions.showLoadingSnackBar(context, 'Saving...');
                      if (_formKeyName.currentState!.validate() &&
                          _formKeyPrice.currentState!.validate()) {
                        widget.kitchenItem == null
                            ? _save(_itmBloc)
                            : _update(_itmBloc);
                        setState(() {
                          _canSave = false;
                        });
                      }
                    },
              style: MThemeData.raisedButtonStyleSave),
        ),
      ],
    );
  }

  Padding _buildQuantityFier() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: AppConstants.whiteOpacity,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer(builder: (context, ref, child) {
              return Container(
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: Icon(
                          CupertinoIcons.minus_circle,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) _quantity -= 0.5;
                            _quantity = _quantity;
                          });
                        }),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(_quantity.toString()),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          CupertinoIcons.plus_circle,
                        ),
                        onPressed: () {
                          setState(() {
                            _quantity += 0.5;
                            _quantity = _quantity;
                          });
                        }),
                  ],
                ),
              );
            }),
            QuantifierSpinner(
              onValueChanged: (value) {
                setState(() {
                  _quantifier = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildSelectDateBought() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: AppConstants.whiteOpacity,
        ),
        child: Row(
          children: [
            SelectDate(
              initialDate: _dateBought,
              onDateSelected: (DateTime date) {
                setState(() {
                  _dateBought = date;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Padding _buildItemPrice() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Form(
        key: _formKeyPrice,
        child: SizedBox(
          height: 50,
          child: TextFormField(
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [
              //  FilteringTextInputFormatter.allow(RegExp("0-9]"))
              FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)')),
            ],
            controller: _itemPriceController,
            validator: (text) {
              if (text!.isEmpty) {
                return '';
              } else if (text.contains(RegExp(r'[A-Z]'))) {
                return '';
              } else {
                return null;
              }
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: ' 00.00',
              hintStyle: GoogleFonts.robotoSlab(),
              contentPadding: EdgeInsets.only(top: 4),
              suffix: IconButton(
                icon: Icon(
                  Icons.clear_outlined,
                  size: 18,
                ),
                onPressed: () {
                  _itemPriceController.clear();
                },
              ),
              prefixIcon: Icon(
                Icons.monetization_on_outlined,
              ),
              fillColor: AppConstants.whiteOpacity,
              filled: true,
              labelText: 'Price',
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildItemNameAutoComplete(
      BuildContext context, Iterable<ItemModel> _kOptions) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Form(
        key: _formKeyName,
        child: SizedBox(
          height: 50,
        ),
      ),
    );
  }

  Row _buildShopSpinner() {
    return Row(
      children: [
        ShopSpinner(
          initialValue: _shop,
          onShopSelected: (shp) {
            setState(() {
              _shop = shp!.shopName;
            });

            // ref.read(pickedShop.state).state = s;
          },
        ),
      ],
    );
  }

  Row _buildKitchenElementSpinner() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(4),
          child: KitchenElementsSpinner(
            onSelected: (KitchenElementModel? e) {
              _kitchenElement = e;
            },
          ),
        ),
      ],
    );
  }

  Padding _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add Kitchen Item to :',
                style: Theme.of(context).textTheme.bodyLarge),
            widget.kitchenElement != null
                ? Text('${widget.kitchenElement!.title}',
                    style: Theme.of(context).textTheme.headlineMedium)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  /// build save function
  _save(_itmBloc) {
    final _kitchenItem = KitchenItemModel(
      besoinTitle: '',
      dateBought: _dateBought,
      itemName: _itemNameController.text.trim(),
      itemPrice: double.parse(_itemPriceController.text.trim()),
      quantifier: _quantifier,
      quantity: _quantity,
      shopName: _shop,
      dateExpired: _dateExpired,
      kitchenElementId: widget.item == null
          ? widget.kitchenElement!.id!
          : _kitchenElement!.id!,
    );
    // _kitchenItem.toPrint();

    setState(() {
      _canSave = true;
    });
    _itmBloc.add(UpdateKitchenItemEvent((_kitchenItem)));
  }

  /// build update function

  _update(_itmBloc) {
    final _kitchenItem = KitchenItemModel(
      id: widget.item!.id,
      besoinTitle: '',
      dateBought: _dateBought,
      itemName: _itemNameController.text.trim(),
      itemPrice: double.parse(_itemPriceController.text.trim()),
      quantifier: _quantifier,
      quantity: _quantity,
      shopName: _shop,
      dateExpired: _dateExpired,
      kitchenElementId: widget.item == null
          ? widget.kitchenElement!.id!
          : _kitchenElement!.id!,
    );

    setState(() {
      _canSave = true;
    });
    _itmBloc.add(UpdateKitchenItemEvent((_kitchenItem)));
  }
}
