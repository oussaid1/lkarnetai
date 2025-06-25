import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/blocs/itemsbloc/items_bloc.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/repository/database_operations.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:lkarnet/widgets/quantifier_spinner.dart';
import 'package:lkarnet/widgets/shop_spinner.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../widgets/add_to_kitchen_from_item.dart';
import '../../widgets/item_listtile.dart';
import '../../widgets/number_incrementer.dart';

class AddItem extends ConsumerStatefulWidget {
  final ItemModel? item;
  const AddItem({Key? key, this.item});
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddItem>
    with SingleTickerProviderStateMixin {
  double _quantity = 1;
  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPrice = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  FocusNode _itemNameFocusNode = FocusNode();
  DateTime _dateBought = DateTime.now();
//  KitchenElement? _kitchenElement;
  String? _quantifier = 'واحدة';
  String _shop = 'unknown';
  bool _isUpdate = false, _canSave = false;
  ItemModel? _localItem;
  void clear() {
    setState(() {
      _dateBought = DateTime.now();
      _itemNameController.clear();
      _itemPriceController.clear();
      _quantity = 1;
    });
  }

  void _update() {
    if (widget.item != null) {
      _isUpdate = true;
      _shop = widget.item!.shopName;
      _itemNameController.text = widget.item!.itemName;
      _itemPriceController.text = (widget.item!.itemPrice).toString();
      _quantity = widget.item!.quantity;
      _quantifier = widget.item!.quantifier;
      _dateBought = widget.item!.dateBought;
    }
  }

  AnimationController? _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _update();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  final _itmBloc =
      ItemsBloc(databaseOperations: GetIt.I.get<DatabaseOperations>());
  @override
  Widget build(BuildContext context) {
    _itmBloc..add(GetItemsEvent());
    // Iterable<ItemModel> _kOptions = _itmBloc.state.items;
    // var items = GetIt.instance.get<ItemsBloc>().state.items;
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
        appBar: AppBar(
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
            widget.item != null ? "تعديل المادة" : "اضافة مادة",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BluredContainer(
                    height: 460, // MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,

                    child: Column(
                      children: [
                        _buildShopSpinner(),
                        BlocBuilder<ItemsBloc, ItemsState>(
                          bloc: _itmBloc,
                          builder: (context, state) {
                            return _buildItemName(context, state.items);
                          },
                        ),
                        //  MyAutocomplete(),
                        _buildItemPrice(),
                        _buildSelectDateBought(),
                        _buildQuantityFier(),
                        SizedBox(height: 50),
                        _buildUpdateButton(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildUpdateButton(BuildContext context) {
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
              child: Text(_isUpdate ? 'Update' : 'Add'),
              onPressed: !_canSave
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(_isUpdate ? 'updating...' : 'Saving...'),
                      ));

                      if (_formKeyName.currentState!.validate() &&
                          _formKeyPrice.currentState!.validate()) {
                        setState(() {
                          _canSave = false;
                        });
                        _isUpdate ? update() : save(context);
                      }
                    },
              style: MThemeData.raisedButtonStyleSave),
        ),
      ],
    );
  }

  // build bottomsheet for add item
  void mBottomSheet(
    BuildContext context, {
    AnimationController? controller,
    // required Widget child,
  }) {
    showModalBottomSheet(
        transitionAnimationController: controller,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0.5),
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (_) {
          return Container(
            decoration: BoxDecoration(
              //color: Color.fromARGB(255, 189, 110, 110),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            height: 160,
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddToKitchenFromItem(
                item: _localItem!,
              ),
            ),
          );
        });
  }

  Row _buildQuantityFier() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NumberIncrementer(
          initialValue: widget.item?.quantity ?? _quantity,
          onDecrement: (value) {
            setState(() {
              _quantity = value;
            });
          },
          onIncrement: (value) {
            setState(() {
              _quantity = value;
            });
          },
        ),
        Container(
          child: QuantifierSpinner(
            initialQuantifier: widget.item?.quantifier,
            onValueChanged: (value) {
              setState(() {
                _quantifier = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Padding _buildSelectDateBought() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SelectDate(
        initialDate: widget.item?.dateBought ?? _dateBought,
        onDateSelected: (DateTime date) {
          setState(() {
            _dateBought = date;
          });
        },
      ),
    );
  }

  Padding _buildShopSpinner() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: ShopSpinner(
        initialValue: widget.item?.shopName,
        focusNode: _itemNameFocusNode,
        onShopSelected: (value) {
          setState(() {
            _shop = value!.shopName ?? '';

            _canSave = _itemNameController.text.trim().trim().isNotEmpty;
          });
        },
      ),
    );
  }

  Padding _buildItemName(BuildContext context, Iterable<ItemModel> _kOptions) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Form(
        key: _formKeyName,
        child: SizedBox(
          height: 50,
          child: TypeAheadField<ItemModel>(
            // suggestionsBoxDecoration: SuggestionsBoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            //   color: Colors.white,
            // ),
            hideOnEmpty: true,
            controller: _itemNameController,
            autoFlipDirection: true,
            autoFlipMinHeight: 100,

            direction: VerticalDirection.up,
            focusNode: _itemNameFocusNode,
            builder: (context, txtController, focusNode) {
              return TextField(
                focusNode: _itemNameFocusNode,
                onChanged: (value) => setState(() {
                  _canSave = _itemNameController.text.trim().trim().isNotEmpty;
                }),
                controller: _itemNameController,
                autofocus: false,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  //no borders,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 4, right: 4, left: 4),
                  fillColor: AppConstants.whiteOpacity,
                  filled: true,
                  hintText: 'title',
                  //alignLabelWithHint: true,

                  prefixIcon: Icon(
                    Icons.shopping_basket,
                    color: Color.fromARGB(117, 212, 211, 211),
                  ),
                  suffix: IconButton(
                    icon: Icon(
                      Icons.clear_outlined,
                      size: 18,
                    ),
                    onPressed: () {
                      setState(() {
                        _itemNameController.clear();
                      });
                    },
                  ),
                  // border: OutlineInputBorder(),
                ),
              );
            },
            suggestionsCallback: (pattern) async {
              if (_itemNameController.text.length > 1) {
                return _kOptions
                    .where((item) => item.itemName
                        .trim()
                        .toLowerCase()
                        .startsWith(pattern.trim().toLowerCase()))
                    .toList(growable: true);
              }
              return [];
            },

            itemBuilder: (context, suggestion) {
              return SizedBox(
                width: 200,
                //height: 200,
                child: ItemTileWidget(
                  item: suggestion,
                ),
              );
            },
            onSelected: (suggestion) {
              setState(() {
                _itemNameController.text = suggestion.itemName;
                _itemPriceController.text = suggestion.itemPrice.toString();
                _quantity = suggestion.quantity;
                _canSave = _itemNameController.text.trim().trim().isNotEmpty;
              });
              // _dateBought = suggestion.dateBought;
            },
          ),
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
            //autovalidateMode: AutovalidateMode.disabled,
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
            onChanged: (value) {
              setState(() {
                _canSave = _itemNameController.text.trim().trim().isNotEmpty;
              });
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              border: InputBorder.none,
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

  /// save the item to the database
  save(context) {
    setState(() => _canSave = true);
    final ItemModel item = ItemModel(
      itemName: _itemNameController.text.trim(),
      itemPrice: double.parse(_itemPriceController.text.trim()),
      quantity: _quantity,
      dateBought: _dateBought,
      shopName: _shop,
      quantifier: _quantifier,
    );
    _localItem = item;
    _itmBloc.add(AddItemEvent(item));
    //  mBottomSheet(context, controller: _controller);
    clear();
    //  Navigator.of(context).pop();
  }

  /// update the item in the database
  update() {
    setState(() => _canSave = true);
    final ItemModel item = ItemModel(
      id: widget.item?.id,
      itemName: _itemNameController.text.trim(),
      itemPrice: double.parse(_itemPriceController.text.trim()),
      quantity: _quantity,
      dateBought: _dateBought,
      shopName: _shop,
      quantifier: _quantifier,
    );
    // _localItem=item;
    _itmBloc.add(UpdateItemEvent(item));
    //mBottomSheet(context, controller: _controller);
    clear();
    Navigator.of(context).pop();
  }
}

class MyAutocomplete extends StatefulWidget {
  @override
  _MyAutocompleteState createState() => _MyAutocompleteState();
}

class _MyAutocompleteState extends State<MyAutocomplete> {
  final List<String> suggestions = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Fig',
    'Grape'
  ];
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return suggestions.where((String option) =>
            option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (String selection) {
        print('You just selected $selection');
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: _textEditingController,
          focusNode: focusNode,
          onSubmitted: (String value) {
            onFieldSubmitted();
          },
          decoration: InputDecoration(
            labelText: 'Type a fruit',
            border: OutlineInputBorder(),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              width: 200,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(option),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
