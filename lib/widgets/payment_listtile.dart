import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/payments/payments_bloc.dart';
import '../components.dart';
import '../models/payment/payment_model.dart';
import '../screens/add/add_payment.dart';
import '../settings/theme.dart';
import 'dialogs.dart';
import 'price_curency_widget.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({
    Key? key,
    required this.payment,
    this.withActions = false,
  }) : super(key: key);
  final bool withActions;
  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    return withActions
        ? Slidable(
            startActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                    backgroundColor: Colors.transparent,
                    icon: Icons.mode_edit,
                    label: 'Edit',
                    onPressed: (context) {
                      Dialogs.botomUpDialog(
                          context,
                          AddPayment(
                            payment: payment,
                          ));
                    }),
              ],
            ),
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  icon: Icons.delete_forever,
                  label: 'Delete',
                  backgroundColor: Colors.transparent,
                  onPressed: (context2) {
                    Dialogs.dialogSimple(context,
                        title: 'Are you sure !!?',
                        widgets: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 120,
                                  child: ElevatedButton(
                                    child: Text(
                                      'Cancel',
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    style: MThemeData.raisedButtonStyleCancel,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 120,
                                  child: ElevatedButton(
                                    child: Text(
                                      'Ok',
                                      style:
                                          Theme.of(context).textTheme.displaySmall,
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<PaymentsBloc>(context)
                                          .add(DeletePaymentEvent(payment));
                                      Navigator.pop(context);
                                    },
                                    style: MThemeData.raisedButtonStyleSave,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]);
                  },
                ),
              ],
            ),
            child: PaymentListTileOnly(payment: payment))
        : PaymentListTileOnly(payment: payment);
  }
}

class PaymentListTileOnly extends StatelessWidget {
  const PaymentListTileOnly({
    Key? key,
    required this.payment,
  }) : super(key: key);

  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radius),
        side: BorderSide(
          color: AppConstants.whiteOpacity,
          width: 1,
        ),
      ),
      color: Color.fromARGB(69, 255, 0, 102).withOpacity(0.2),
      child: SizedBox(
        height: 50,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(69, 255, 0, 102).withOpacity(0.2),
                    // : Color.fromRGBO(230, 33, 141, 0.643),

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.radius),
                      bottomLeft: Radius.circular(AppConstants.radius),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.attach_money_outlined,
                        color: Color.fromARGB(159, 3, 3, 3),
                        size: 18,
                      ),
                      Text(
                        'payment',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${payment.paidShopName}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        '${payment.datePaid.formatted()}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(4.0),
                          child: PriceNumberZone(
                            price: payment.paidAmount,
                            style: Theme.of(context).textTheme.headlineMedium,
                            withDollarSign: true,
                          )),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
