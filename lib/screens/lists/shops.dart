import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lkarnet/const/constents.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/screens/add/add_shop.dart';
import 'package:lkarnet/widgets/dialogs.dart';
import 'package:lkarnet/widgets/glasswidget.dart';

import '../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../blocs/itemsbloc/items_bloc.dart';
import '../../blocs/payments/payments_bloc.dart';
import '../../blocs/shopsbloc/shops_bloc.dart';
import '../../models/data_sink.dart';
import '../../models/item/item.dart';
import '../../models/payment/payment_model.dart';
import '../../settings/theme.dart';

class ShopsList extends ConsumerWidget {
  ShopsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    //  final lista = ref.watch(shopsProvider.state).state;
    // var _shopsDataList = ref.watch(shopsDataListProvider.state).state;
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Dialogs.botomUpDialog(context, AddShop());
          },
          child: Icon(Icons.add),
        ),
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
            'Shops',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
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
                        List<ItemModel> _items = itemsState.items;
                        List<PaymentModel> _payments = paymentsState.payments;
                        List<ShopModel> _shops = shopsState.shops;
                        //////////////////////////////////////////////////////

                        DataSink _dataSink = DataSink(
                            items: _items, payments: _payments, shops: _shops);
                        List<ShopData> _shopsDataList = _dataSink.allShopsData;

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 60,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Shops",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall),
                                            Text(
                                                "see all the shops, add new ones, edit them, delete them, etc.",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              BluredContainer(
                                margin: EdgeInsets.only(
                                    left: 8, right: 8, bottom: 8),
                                child: ListView.builder(
                                  itemCount: _shopsDataList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ShopData shopsData = _shopsDataList[index];
                                    return Slidable(
                                        startActionPane: ActionPane(
                                          motion: ScrollMotion(),
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  Icons.mode_edit,
                                                  size: 30,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                                color: Colors.transparent,
                                                onPressed: () {
                                                  Dialogs.botomUpDialog(
                                                      context,
                                                      AddShop(
                                                          shop:
                                                              shopsData.shop));
                                                }),
                                          ],
                                        ),
                                        endActionPane: ActionPane(
                                          motion: ScrollMotion(),
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete_forever,
                                                size: 30,
                                                color: Theme.of(context)
                                                    .colorScheme.error,
                                              ),
                                              color: Colors.transparent,
                                              onPressed: () {
                                                Dialogs.dialogSimple(context,
                                                    title: 'Are you sure !!?',
                                                    widgets: [
                                                      Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: 120,
                                                              child:
                                                                  ElevatedButton(
                                                                child: Text(
                                                                  'Cancel',
                                                                ),
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context),
                                                                style: MThemeData
                                                                    .raisedButtonStyleCancel,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Container(
                                                              width: 120,
                                                              child:
                                                                  ElevatedButton(
                                                                child: Text(
                                                                  'Ok',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .displaySmall,
                                                                ),
                                                                onPressed:
                                                                    () {},
                                                                style: MThemeData
                                                                    .raisedButtonStyleSave,
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: BluredContainer(
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Card(
                                              color: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: ListTile(
                                                dense: true,
                                                contentPadding: EdgeInsets.only(
                                                    left: 8, right: 8),
                                                leading: Container(
                                                  height: 45,
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppConstants
                                                        .whiteOpacity,
                                                  ),
                                                  child: Icon(Icons.person),
                                                ),
                                                title: Text(
                                                  ' ${shopsData.shop.shopName}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                ),
                                                trailing: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${(shopsData.shop.limit)}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium,
                                                    ),
                                                    Text(
                                                      'limit',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                              ),
                            ],
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
}
