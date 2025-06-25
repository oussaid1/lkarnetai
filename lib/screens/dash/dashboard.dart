import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/operations_adapter.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/utils.dart';
import 'package:lkarnet/widgets/dialogs.dart';
import '../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../blocs/itemsbloc/items_bloc.dart';
import '../../blocs/payments/payments_bloc.dart';
import '../../blocs/shopsbloc/shops_bloc.dart';
import '../../models/data_sink.dart';
import '../../models/item/item.dart';
import '../../models/item/items_filtered.dart';
import '../../models/payment/payments_filtered.dart';
import '../../models/shop/shopdata_calculations.dart';
import '../../models/shop/shops_data.dart';
import '../../widgets/item_listtile.dart';
import '../../widgets/payment_listtile.dart';
import '../../widgets/price_curency_widget.dart';
import '../../widgets/shop_square_tile.dart';
import '../add/add_item.dart';
import '../add/add_kitchen_item.dart';
import '../add/add_payment.dart';
import '../add/add_shop.dart';
import '../lists/items.dart';
import '../shop_details/shop_details_tab.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  //late List<KitchenElement> _kitchenElements;
  // /late List<KitchenItem> _kitchenItems;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // GetIt.I.registerFactory<ItemsBloc>(
    //     () => ItemsBloc(databaseOperations: GetIt.I.get<DatabaseOperations>()));
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Dashboard',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        leading: IconButton(icon: Icon(Icons.dashboard), onPressed: () {}),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GlassContainer(
            start: 0,
            end: 0,
            child: MultiBlocListener(
              listeners: [
                BlocListener<ItemsBloc, ItemsState>(
                  listener: (context, state) {
                    if (state.status == ItemsStatus.loaded) {
                      Dialogs.snackBar('Items loaded');
                    }
                    if (state.status == ItemsStatus.added) {
                      GlobalFunctions.showSnackBar(
                        context,
                        'Item added successfully',
                      );
                    }
                    if (state.status == ItemsStatus.updated) {
                      GlobalFunctions.showSnackBar(
                        context,
                        'Item updated successfully',
                      );
                    }
                    if (state.status == ItemsStatus.deleted) {
                      GlobalFunctions.showSnackBar(
                        context,
                        'Item deleted successfully',
                      );
                    }
                    if (state.status == ItemsStatus.error) {
                      GlobalFunctions.showErrorSnackBar(context, state.error);
                    }
                  },
                ),
                BlocListener<ShopsBloc, ShopsState>(
                  listener: (context, state) {
                    if (state.status == ShopsStatus.loaded) {
                      GlobalFunctions.showSnackBar(
                        context,
                        'Shops loaded successfully',
                      );
                    }
                    if (state.status == ShopsStatus.added) {
                      GlobalFunctions.showSnackBar(
                        context,
                        'Shop added successfully',
                      );
                    }
                    if (state.status == ShopsStatus.updated) {
                      GlobalFunctions.showSnackBar(
                        context,
                        'Shop updated successfully',
                      );
                    }
                    if (state.status == ShopsStatus.deleted) {
                      GlobalFunctions.showSnackBar(
                        context,
                        'Shop deleted successfully',
                      );
                    }
                    if (state.status == ShopsStatus.error) {
                      GlobalFunctions.showErrorSnackBar(context, state.error);
                    }
                  },
                ),
                BlocListener<PaymentsBloc, PaymentsState>(
                  listener: (context, state) {
                    if (state.status == PaymentsStatus.loaded) {
                      GlobalFunctions.showSnackBar(
                        context,
                        'Payments loaded successfully',
                      );
                    }

                    if (state.status == PaymentsStatus.added) {
                      GlobalFunctions.showSnackBar(
                        context,
                        'Payment added successfully',
                      );
                    }
                    if (state.status == PaymentsStatus.updated) {
                      GlobalFunctions.showSnackBar(
                        context,
                        'Payment updated successfully',
                      );
                    }
                    if (state.status == PaymentsStatus.deleted) {
                      GlobalFunctions.showSnackBar(
                        context,
                        'Payment deleted successfully',
                      );
                    }
                    if (state.status == PaymentsStatus.error) {
                      GlobalFunctions.showErrorSnackBar(context, state.error);
                    }
                  },
                ),
              ],
              child: BlocBuilder<PaymentsBloc, PaymentsState>(
                builder: (context, paymentsState) {
                  return BlocBuilder<ShopsBloc, ShopsState>(
                    builder: (context, shopsState) {
                      return BlocBuilder<DateFilterBloc, DateFilterState>(
                        builder: (context, filterState) {
                          return BlocBuilder<ItemsBloc, ItemsState>(
                            builder: (context, itemsState) {
                              if (itemsState.items.isNotEmpty) {
                                //////////////////////////////////////////////////////
                                //////////////////////////////////////////////////////
                                //////////////////////////////////////////////////////
                                //////////////////////////////////////////////////////

                                //////////////////////////////////////////////////////
                                /// filtered items
                                ItemsFiltered _filteredItems = ItemsFiltered(
                                  items: itemsState.items,
                                );

                                /// filtered payments
                                PaymentsFiltered _filteredPayments =
                                    PaymentsFiltered(
                                      payments: paymentsState.payments,
                                    );
                                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                //  List<ItemModel> _items =
                                _filteredItems.itemsByDateFilter;
                                //////////////////////////////////////////////////////
                                //  List<PaymentModel> _payments =
                                _filteredPayments.paymentsByDateFilter;
                                List<ShopModel> _shops = shopsState.shops;
                                //////////////////////////////////////////////////////
                                var dataSink = DataSink(
                                  items: itemsState.items,
                                  payments: paymentsState.payments,
                                  shops: _shops,
                                );
                                //////////////////////////////////////////////////////
                                List<ShopData> allShopsData =
                                    dataSink.allShopsData;
                                ///////////////////////////////////////////////////////
                                ShopDataCalculations _shopDataCalculations =
                                    ShopDataCalculations(
                                      items: itemsState.items,
                                      payments: paymentsState.payments,
                                    );
                                ///////////////////////////////////////////////////////
                                ///////////////////////////////////////////////////////
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 8),
                                    buildTopWidget(
                                      _shopDataCalculations,
                                      items: itemsState.items,
                                    ),
                                    buildShopsWidget(context, allShopsData),
                                    buildRecentOpeerationsWidget(
                                      context,
                                      RecentOperation(
                                        itemsState.items,
                                        paymentsState.payments,
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('no items... Add new ones'),
                                      const SizedBox(height: 40),
                                      SpinKitSquareCircle(
                                        color: Color.fromARGB(
                                          190,
                                          255,
                                          255,
                                          255,
                                        ),
                                        size: 50.0,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildShopsWidget(BuildContext context, List<ShopData> _shopsDataList) {
    //_shopsDataList..removeWhere((e) => e.shopDataCalculations.itemsSumAfterPayment <= 0);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        // height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Shops',
                        style: Theme.of(context).textTheme.displaySmall!
                            .copyWith(
                              color: Color.fromARGB(141, 255, 255, 255),
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                      child: Text(
                        'Tap the shop to see its details',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
                // IconButton(
                //   icon: Icon(Icons.list,
                //       color: Color.fromARGB(106, 255, 255, 255)),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ShopsList(),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
            SizedBox(
              height: 140,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final ShopData shopsData = _shopsDataList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ShopSquareTile(
                      shopData: shopsData,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ShopDetailsTab(shopData: shopsData),
                          ),
                        );
                      },
                    ),
                  );
                },
                itemCount: _shopsDataList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // build operations widget
  buildRecentOpeerationsWidget(
    BuildContext context,
    RecentOperation recentOperations,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon(Icons.dashboard_customize,
              //     color: Color.fromRGBO(255, 255, 255, 1)),
              // const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Recent Operations',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Color.fromARGB(106, 255, 255, 255),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                    child: Text(
                      'double tap to add the item to kitchen !',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),

              // more button
              IconButton(
                icon: Icon(
                  Icons.list,
                  color: Color.fromARGB(106, 255, 255, 255),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ItemsList(lista: recentOperations.items),
                    ),
                  );
                },
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              final OperationsAdapter recentOperation =
                  recentOperations.recentOperationsList[index];
              return recentOperation.isItem
                  ? ItemTileWidget(
                      animationController: _animationController,
                      withActions: true,
                      onTap: () {
                        Dialogs.dialogSimple(
                          context,
                          title: 'do you want to save to kitchen',
                          widgets: [
                            Container(
                              child: AddKitchenItem(
                                item: recentOperation.item!,
                              ),
                            ),
                          ],
                        );
                      },
                      item: recentOperation.item!,
                    )
                  : PaymentTile(
                      withActions: true,
                      payment: recentOperation.payment!,
                    );
            },
            itemCount: recentOperations.recentOperationsList.length,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  buildTopWidget(
    ShopDataCalculations shopDataCalculations, {
    List<ItemModel>? items,
  }) {
    return BluredContainer(
      //width: 400,
      height: 140,
      margin: EdgeInsets.all(8),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Spendings',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                SizedBox(height: 8),
                PriceNumberZone(
                  right: const SizedBox.shrink(),
                  withDollarSign: true,
                  price: shopDataCalculations.itemsSumAfterPayment,
                  style: Theme.of(context).textTheme.displayMedium!,
                ),
              ],
            ),
            Row(children: [buildCircularProgress(shopDataCalculations)]),
          ],
        ),
      ),
    );
  }

  CircularPercentIndicator buildCircularProgress(
    ShopDataCalculations dataSink,
  ) {
    return CircularPercentIndicator(
      animateFromLastPercent: true,
      animation: true,
      curve: Curves.linear,
      radius: 50.0,
      lineWidth: 6.0,
      percent: dataSink.spendingsUnitinterval,
      center: new Text(
        "${dataSink.spendingsPecentage} %",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.white,
      backgroundColor: Colors.white.withOpacity(0.2),
    );
  }

  // build custom listTile
  Widget buildRowTileRecentOpe(OperationsAdapter operation, String currency) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radius),
      ),
      color: AppConstants.whiteOpacity,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: operation.isItem
                        ? Color(0xFFEBA613)
                        : Color(0xA4E6218D),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.radius),
                      bottomLeft: Radius.circular(AppConstants.radius),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${operation.quantity}',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${operation.quantifier}',
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${operation.title}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '${operation.date!.formatted()}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '${operation.amount!.toPrecision(2)}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Text(
                  '$currency',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddStuffWidget extends StatelessWidget {
  final BuildContext context;
  const AddStuffWidget({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext cxt) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildExpandedFab(
          context,
          icon: Icon(Icons.monetization_on, color: Colors.white),
          title: "Payments",
          child: const AddPayment(),
        ),
        const SizedBox(height: 10),
        buildExpandedFab(
          context,
          icon: Icon(Icons.person_add, color: Colors.white),
          title: "Shop",
          child: const AddShop(),
        ),
        const SizedBox(height: 10),
        buildExpandedFab(
          context,
          icon: Icon(Icons.add_shopping_cart, color: Colors.white),
          title: "Item",
          child: AddItem(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  FloatingActionButton buildExpandedFab(
    BuildContext context, {
    String? title,
    required Widget child,
    Widget? icon,
  }) {
    return FloatingActionButton(
      heroTag: title,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),

      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => child));
        // Dialogs.botomUpDialog(
        //   context,
        //   SizedBox(
        //     // height: 400,
        //     width: 410,
        //     child: child ?? const SizedBox.shrink(),
        //   ),
        // );
      },
      child: icon ?? Icon(Icons.add),

      // label: Text(title ?? '', style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
