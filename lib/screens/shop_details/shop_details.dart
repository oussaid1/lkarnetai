import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:flutter/material.dart';
import '../../components.dart';
import '../../widgets/item_listtile.dart';
import '../../widgets/payment_listtile.dart';
import '../add/add_shop.dart';
import '../lists/items.dart';
import '../lists/payments.dart';

class ShopDetails extends StatefulWidget {
  const ShopDetails({Key? key, this.shopData}) : super(key: key);
  final ShopData? shopData;
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlassMaterial(
      circleWidgets: [
        Positioned(
          width: 140,
          height: 140,
          left: 10,
          top: 120,
          child: AppAssets.blueCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          right: 80,
          top: 200,
          child: AppAssets.purpleCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          left: 40,
          bottom: 80,
          child: AppAssets.pinkCircleWidget,
        ),
      ],
      gradientColors: AppConstants.myGradients,
      centerWidget: ShopsDetailsBody(shopsData: widget.shopData!),
    );
  }

// build custom listTile
}

class ShopsDetailsBody extends StatelessWidget {
  const ShopsDetailsBody({
    Key? key,
    required this.shopsData,
  }) : super(key: key);

  final ShopData shopsData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BluredContainer(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        start: 0,
        end: 0,
        borderColorOpacity: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              BluredContainer(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        '${shopsData.shopDataCalculations.itemsSumAfterPayment}',
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${shopsData.shop.shopName}',
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    /// an iconbutton to edit the shop
                    // IconButton(
                    //   icon: Icon(Icons.bar_chart),
                    //   onPressed: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ShopDetailsTab(
                    //         shopData: shopsData,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddShop(
                              shop: shopsData.shop,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ShopItemsDetailsWidget(shopsData: shopsData),
              const SizedBox(height: 10),
              ShopPaymentsDetailWidget(shopsData: shopsData),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopItemsDetailsWidget extends StatefulWidget {
  const ShopItemsDetailsWidget({
    Key? key,
    required this.shopsData,
  }) : super(key: key);

  final ShopData shopsData;

  @override
  State<ShopItemsDetailsWidget> createState() => _ShopItemsDetailsWidgetState();
}

class _ShopItemsDetailsWidgetState extends State<ShopItemsDetailsWidget> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        ExpansionPanelList(
            elevation: 0,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpanded = !isExpanded;
              });
            },
            animationDuration: Duration(milliseconds: 800),
            children: [
              ExpansionPanel(
                isExpanded: _isExpanded,
                canTapOnHeader: false,
                backgroundColor: AppConstants.whiteOpacity,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Items',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'count :',
                              style: Theme.of(context).textTheme.titleSmall!),
                          TextSpan(
                              text:
                                  ' ${widget.shopsData.shopDataCalculations.countItems}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color:
                                          Color.fromARGB(189, 255, 255, 255))),
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'total :',
                              style: Theme.of(context).textTheme.titleSmall!),
                          TextSpan(
                              text:
                                  ' ${widget.shopsData.shopDataCalculations.itemsSum}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color:
                                          Color.fromARGB(189, 255, 255, 255))),
                        ])),
                      ],
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    leading: IconButton(
                      icon: Icon(Icons.menu_sharp,
                          color: Color.fromARGB(106, 255, 255, 255)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemsList(
                              lista: widget.shopsData.items,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                body: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 400,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ItemTileWidget(
                        item: widget.shopsData.items[index],
                      );
                    },
                    itemCount: widget.shopsData.items.length,
                  ),
                ),
              ),
            ]),
      ],
    );
  }
}

class ShopPaymentsDetailWidget extends StatefulWidget {
  const ShopPaymentsDetailWidget({
    Key? key,
    required this.shopsData,
  }) : super(key: key);

  final ShopData shopsData;

  @override
  State<ShopPaymentsDetailWidget> createState() =>
      _ShopPaymentsDetailWidgetState();
}

class _ShopPaymentsDetailWidgetState extends State<ShopPaymentsDetailWidget> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExpansionPanelList(
            elevation: 0,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpanded = !isExpanded;
              });
            },
            animationDuration: Duration(milliseconds: 800),
            children: [
              ExpansionPanel(
                isExpanded: _isExpanded,
                canTapOnHeader: true,
                backgroundColor: AppConstants.whiteOpacity,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Payments',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'count :',
                              style: Theme.of(context).textTheme.titleSmall!),
                          TextSpan(
                              text:
                                  ' ${widget.shopsData.shopDataCalculations.countPayments}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color:
                                          Color.fromARGB(189, 255, 255, 255))),
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'total :',
                              style: Theme.of(context).textTheme.titleSmall!),
                          TextSpan(
                              text:
                                  ' ${widget.shopsData.shopDataCalculations.paymentsSum}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color:
                                          Color.fromARGB(189, 255, 255, 255))),
                        ])),
                      ],
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    leading: IconButton(
                      icon: Icon(Icons.menu_sharp,
                          color: Color.fromARGB(106, 255, 255, 255)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PaymentsList(lista: widget.shopsData.payments),
                          ),
                        );
                      },
                    ),
                  );
                },
                body: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 400,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      widget.shopsData.payments
                          .sort((b, a) => a.datePaid.compareTo(b.datePaid));
                      final PaymentModel payment =
                          widget.shopsData.payments[index];
                      return PaymentTile(
                        withActions: true,
                        payment: payment,
                      );
                    },
                    itemCount: widget.shopsData.payments.length,
                  ),
                ),
              ),
            ]),
      ],
    );
  }
}
