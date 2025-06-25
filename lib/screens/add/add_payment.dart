import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkarnet/blocs/payments/payments_bloc.dart';
import 'package:lkarnet/const/constents.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:lkarnet/widgets/dialogs.dart';
import 'package:lkarnet/widgets/glasswidget.dart';
import 'package:lkarnet/widgets/shop_spinner.dart';

import '../../repository/database_operations.dart';

class AddPayment extends ConsumerStatefulWidget {
  final PaymentModel? payment;

  const AddPayment({Key? key, this.payment}) : super(key: key);
  @override
  _AddPaymentState createState() => _AddPaymentState();
}

class _AddPaymentState extends ConsumerState<AddPayment> {
  final GlobalKey<FormState> _formKeyPaidAmount = GlobalKey<FormState>();
  final TextEditingController _paidAmountController = TextEditingController();
  bool _canSave = false;
  DateTime _datePaid = DateTime.now();
  String? _id;
  final FocusNode _paidAmountFocusNode = FocusNode();
  String? _shopName;
  void _update() {
    if (widget.payment != null) {
      _id = widget.payment!.id!;
      _paidAmountController.text = widget.payment!.paidAmount.toString();
      _datePaid = widget.payment!.datePaid;
      _shopName = widget.payment!.paidShopName;
    }
  }

  void clear() {
    _paidAmountController.clear();
  }

  @override
  void initState() {
    _update();
    _canSave = _shopName != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pmntBloc = PaymentsBloc((GetIt.I<DatabaseOperations>()));
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
            widget.payment != null ? "تعديل " : "اضافة ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: BluredContainer(
            height: 460, // MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(20),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                _buildShopDropDown(),
                _buildAmountPaid(),
                _buildDatePaid(),
                SizedBox(height: 40),
                _buildSaveButton(context, pmntBloc),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSaveButton(BuildContext context, pmntBloc) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      ElevatedButton(
        child: Text(
          'Cancel',
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: MThemeData.raisedButtonStyleCancel,
      ),
      ElevatedButton(
        child: Text(
          widget.payment == null ? 'Save' : 'Update',
        ),
        onPressed: !_canSave
            ? null
            : () {
                final _payment = PaymentModel(
                  id: _id,
                  paidAmount: double.parse(_paidAmountController.text),
                  datePaid: _datePaid,
                  paidShopName: _shopName!, // ref.read(pickedShop.state).state,
                );
                if (_formKeyPaidAmount.currentState!.validate()) {
                  if (widget.payment == null) {
                    _addPayment(context, _payment, pmntBloc);
                  } else {
                    _updatePayment(context, _payment, pmntBloc);
                  }
                  setState(() {
                    _canSave = false;
                  });
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(Dialogs.snackBar('error'));
                }
                //
              },
        style: MThemeData.raisedButtonStyleSave,
      ),
    ]);
  }

  _buildDatePaid() {
    return SelectDate(
      initialDate: widget.payment?.datePaid,
      onDateSelected: (value) {
        setState(() {
          _datePaid = value;
        });
      },
    );
  }

  _buildAmountPaid() {
    return SizedBox(
      width: 300,
      child: Form(
        key: _formKeyPaidAmount,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            focusNode: _paidAmountFocusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text!.isEmpty) {
                return 'please enter amount';
              }
              return null;
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)')),
            ],
            controller: _paidAmountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            //textAlign: TextAlign.center,
            maxLength: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radius),
              ),

              counterText: '',
              hintText: '00.00',
              hintStyle: GoogleFonts.robotoSlab(),
              contentPadding: EdgeInsets.only(top: 4),
              // prefixIcon: Icon(Icons.qr_code),
              fillColor: AppConstants.whiteOpacity,
              filled: true,
              label: Text(
                'Paid Amount',
                style: GoogleFonts.robotoSlab(),
              ),
              prefixIcon: Icon(
                Icons.monetization_on_outlined,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildShopDropDown() {
    return ShopSpinner(
      initialValue: widget.payment?.paidShopName,
      focusNode: _paidAmountFocusNode,
      onShopSelected: (value) {
        setState(() {
          _canSave = true;
          _shopName = value!.shopName;
        });
        // ref.read(pickedShop.state).state = value;
      },
    );
  }

  void _addPayment(context, PaymentModel payment, bloc) {
    bloc.add(AddPaymentEvent(payment));
    Navigator.of(context).pop();
  }

  void _updatePayment(context, PaymentModel payment, bloc) {
    bloc.add(UpdatePaymentEvent(payment));
    Navigator.of(context).pop();
  }
}
