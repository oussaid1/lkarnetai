import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/blocs/shopsbloc/shops_bloc.dart';
import 'package:lkarnet/components.dart';

import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/repository/database_operations.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:flutter/material.dart';

class AddShop extends ConsumerStatefulWidget {
  final ShopModel? shop;
  const AddShop({
    Key? key,
    this.shop,
  }) : super(key: key);
  @override
  _AddShopState createState() => _AddShopState();
}

class _AddShopState extends ConsumerState<AddShop> {
  final GlobalKey<FormState> _formKeyShop = GlobalKey<FormState>();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _shopEmailController = TextEditingController();
  final TextEditingController _shopPhoneController = TextEditingController();
  final TextEditingController _shopLimitController = TextEditingController();
  final TextEditingController _shopBesoinController = TextEditingController();
  bool _canSave = false;
  void _updateControllers() {
    if (widget.shop != null) {
      _shopNameController.text = widget.shop!.shopName.toString();
      _shopEmailController.text = widget.shop!.email.toString();
      _shopLimitController.text = (widget.shop!.limit.toString());
      _shopBesoinController.text = widget.shop!.besoinTitle.toString();
      _shopPhoneController.text = widget.shop!.phone.toString();
    }
  }

  void clear() {
    _shopNameController.clear();
    _shopEmailController.clear();
    _shopLimitController.clear();
    _shopBesoinController.clear();
    _shopPhoneController.clear();
  }

  @override
  void initState() {
    _updateControllers();
    _canSave = _shopNameController.text.isNotEmpty;
    super.initState();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  final _shopBloc = ShopsBloc((GetIt.I.get<DatabaseOperations>()));
  @override
  Widget build(BuildContext context) {
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
            widget.shop != null ? "تعديل " : "اضافة ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: BluredContainer(
            margin: EdgeInsets.all(20),
            height: 460, // MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKeyShop,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    buildShopName(),
                    buildEmail(),
                    buildPhoneNumber(),
                    buildCategory(),
                    buildLimit(),
                    SizedBox(height: 50),
                    buildSaveButton(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildSaveButton(BuildContext context) {
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
            style: MThemeData.raisedButtonStyleCancel,
          ),
        ),
        Container(
          width: 120,
          child: ElevatedButton(
              child: Text(
                widget.shop == null ? 'Save' : 'Update',
              ),
              onPressed: !_canSave
                  ? null
                  : () {
                      if (_formKeyShop.currentState!.validate()) {
                        if (widget.shop == null) {
                          _saveShop();
                        } else {
                          _updateShop();
                        }
                      }
                    },
              style: MThemeData.raisedButtonStyleSave),
        ),
      ],
    );
  }

  Padding buildLimit() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [
          //  FilteringTextInputFormatter.allow(RegExp("0-9]"))
          FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)')),
        ],
        validator: (text) {
          if (text!.isEmpty) {
            return '';
          } else if (text.contains(RegExp(r'[A-Z]'))) {
            return '';
          } else {
            return null;
          }
        },
        controller: _shopLimitController,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.center,
        maxLength: 10,
        decoration: InputDecoration(
          counterText: '',
          hintText: ' 00.00',
          hintStyle: GoogleFonts.robotoSlab(),
          contentPadding: EdgeInsets.only(top: 4),
          prefixIcon: Icon(
            Icons.monetization_on,
          ),
          fillColor: AppConstants.whiteOpacity,
          filled: true,
          label: Text(
            'limit',
            style: GoogleFonts.robotoSlab(),
          ),
        ),
      ),
    );
  }

  Padding buildCategory() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        controller: _shopBesoinController,
        maxLength: 10,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: '',
          hintText: 'category',
          hintStyle: GoogleFonts.robotoSlab(),
          contentPadding: EdgeInsets.only(top: 4),
          prefixIcon: Icon(
            Icons.category,
          ),
          filled: true,
          label: Text(
            'category',
            style: GoogleFonts.robotoSlab(),
          ),
          fillColor: AppConstants.whiteOpacity,
        ),
      ),
    );
  }

  Padding buildPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        controller: _shopPhoneController,
        validator: (text) {
          // if (text!.isEmpty) {
          //   return '';
          // }
          return null;
        },
        textAlign: TextAlign.center,
        maxLength: 10,
        decoration: InputDecoration(
          counterText: '',
          hintText: 'phone-number',
          hintStyle: GoogleFonts.robotoSlab(),
          contentPadding: EdgeInsets.only(top: 4),
          prefixIcon: Icon(
            Icons.phone,
          ),
          filled: true,
          label: Text(
            'phone',
            style: GoogleFonts.robotoSlab(),
          ),
          fillColor: AppConstants.whiteOpacity,
        ),
      ),
    );
  }

  Padding buildEmail() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        controller: _shopEmailController,
        validator: (text) {
          // if (text!.isEmpty) {
          //   return '';
          // }
          return null;
        },
        maxLength: 50,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: '',
          hintText: 'email',
          hintStyle: GoogleFonts.robotoSlab(),
          contentPadding: EdgeInsets.only(top: 4),
          prefixIcon: Icon(
            Icons.email,
          ),
          filled: true,
          label: Text(
            'email',
            style: GoogleFonts.robotoSlab(),
          ),
          fillColor: AppConstants.whiteOpacity,
        ),
      ),
    );
  }

  buildShopName() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        controller: _shopNameController,
        validator: (text) {
          if (text!.isEmpty) {
            return '';
          }
          return null;
        },
        onChanged: (text) {
          setState(() {
            _canSave = text.isNotEmpty;
          });
        },
        maxLength: 20,
        decoration: InputDecoration(
          counterText: '',
          hintText: 'shop-name',
          hintStyle: GoogleFonts.robotoSlab(),
          contentPadding: EdgeInsets.only(top: 4),
          prefixIcon: Icon(
            Icons.person,
          ),
          filled: true,
          label: Text(
            'name',
            style: GoogleFonts.robotoSlab(),
          ),
          fillColor: AppConstants.whiteOpacity,
        ),
      ),
    );
  }

  /// save shop
  void _saveShop() {
    setState(() {
      _canSave = false;
    });
    var shop = ShopModel(
      shopName: _shopNameController.text.trim(),
      email: _shopEmailController.text.trim(),
      phone: _shopPhoneController.text.trim(),
      besoinTitle: _shopBesoinController.text.trim(),
      limit: double.parse(_shopLimitController.text),
    );
    _shopBloc.add(AddShopEvent(shop));
    clear();
  }

  /// update shop
  void _updateShop() {
    setState(() {
      _canSave = false;
    });
    var shop = ShopModel(
      id: widget.shop?.id,
      shopName: _shopNameController.text.trim(),
      email: _shopEmailController.text.trim(),
      phone: _shopPhoneController.text.trim(),
      besoinTitle: _shopBesoinController.text.trim(),
      limit: double.parse(_shopLimitController.text),
    );
    _shopBloc.add(UpdateShopEvent(shop));
    clear();
  }
}
