import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkarnet/components.dart';
import 'package:flutter/material.dart';
import '../blocs/datefilterbloc/date_filter_bloc.dart';
import '../blocs/itemsbloc/items_bloc.dart';
import '../blocs/payments/payments_bloc.dart';
import '../blocs/shopsbloc/shops_bloc.dart';
import '../models/payment/payment_model.dart';
import '../models/shop/shops_data.dart';
import '../widgets/item_listtile.dart';

class StatisticsWidget extends StatefulWidget {
  const StatisticsWidget({Key? key, this.shopsData}) : super(key: key);
  final ShopData? shopsData;
  @override
  _StatisticsWidgetState createState() => _StatisticsWidgetState();
}

class _StatisticsWidgetState extends State<StatisticsWidget> {
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
      centerWidget: Scaffold(
        //floatingActionButton: MyExpandableFab(),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Statistics ',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          leading: IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: null, //() => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<ItemsBloc, ItemsState>(
          builder: (context, itemsState) {
            return BlocBuilder<PaymentsBloc, PaymentsState>(
              builder: (context, paymentsState) {
                return BlocBuilder<ShopsBloc, ShopsState>(
                  builder: (context, shopsState) {
                    return BlocBuilder<DateFilterBloc, DateFilterState>(
                      builder: (context, filterState) {
                        //////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////
                        // List<ItemModel> _items = itemsState.items;
                        // List<PaymentModel> _payments = paymentsState.payments;
                        // List<ShopModel> _shops = shopsState.shops;
                        //////////////////////////////////////////////////////

                        //   DataSink _dataSink =
                        //     DataSink(_shops, _items, _payments);
                        // List<ShopData> _shopsDataList = _dataSink.allShopsData;

                        return SingleChildScrollView(
                          child: BluredContainer(
                            start: 0,
                            end: 0,
                            borderColorOpacity: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${widget.shopsData!.shop.shopName}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium),
                                        Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Center(
                                            child: Text('Today',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                // .copyWith(color: Colors.white),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 390,
                                    height: 300,
                                    child: BluredContainer(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Items',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall!
                                                      // .copyWith(color: Colors.white),
                                                      ),
                                                  Text(
                                                      'count :${widget.shopsData!.shopDataCalculations.countItems} ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium),
                                                  Text(
                                                      'total : ${widget.shopsData!.shopDataCalculations.itemsSum} ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemBuilder: (context, index) {
                                                return ItemTileWidget(
                                                    item: widget.shopsData!
                                                        .items[index]);
                                              },
                                              itemCount: widget
                                                  .shopsData!.items.length,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: 390,
                                    height: 260,
                                    child: BluredContainer(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Payments',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall!
                                                      // .copyWith(color: Colors.white),
                                                      ),
                                                  Text(
                                                      'count :${widget.shopsData!.shopDataCalculations.countPayments} ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium),
                                                  Text(
                                                      'total : ${widget.shopsData!.shopDataCalculations.paymentsSum} ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemBuilder: (context, index) {
                                                return buildShopPaymentTile(
                                                    widget.shopsData!
                                                        .payments[index]);
                                              },
                                              itemCount: widget
                                                  .shopsData!.payments.length,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

// build custom listTile
  Widget buildShopPaymentTile(PaymentModel payment) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radius),
      ),
      color: AppConstants.whiteOpacity,
      child: SizedBox(
        height: 50,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 19, 174, 235),
                    // : Color(0xA4E6218D),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.radius),
                      bottomLeft: Radius.circular(AppConstants.radius),
                    ),
                  ),
                  child: Icon(
                    Icons.attach_money_outlined,
                    color: Colors.white.withOpacity(0.5),
                    size: 30,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${payment.datePaid.formatted()}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${payment.paidAmount.toPrecision(2)}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Text(
                        'DH',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
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
