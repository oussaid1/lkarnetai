import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkarnet/models/statistics/tagged.dart';
import 'package:lkarnet/widgets/charts.dart';
import '../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../blocs/itemsbloc/items_bloc.dart';
import '../../blocs/payments/payments_bloc.dart';
import '../../blocs/shopsbloc/shops_bloc.dart';
import '../../models/data_sink.dart';
import '../../models/item/item.dart';
import '../../models/item/items_data.dart';
import '../../models/payment/payment_model.dart';
import '../../models/shop/shop_model.dart';
import '../../widgets/glasswidget.dart';

class StatsAll extends StatefulWidget {
  @override
  State<StatsAll> createState() => _StatsAllState();
}

class _StatsAllState extends State<StatsAll> {
  List<ItemModel> _items = [];
  List<PaymentModel> _payments = [];
  List<ShopModel> _shops = [];

  @override
  Widget build(BuildContext context) {
    // var chartData = ref.watch(frequentItemsProvider.state).state;
    // var chartData2 = ref.watch(shopsChartsDataProvider.state).state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("All Statistics"),
      ),
      backgroundColor: Colors.transparent,
      // floatingActionButton: MyExpandableFab(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BlocBuilder<ItemsBloc, ItemsState>(
        buildWhen: (previous, current) =>
            previous.items.length != current.items.length,
        builder: (context, itemsState) {
          return BlocBuilder<PaymentsBloc, PaymentsState>(
            buildWhen: (previous, current) =>
                previous.payments.length != current.payments.length,
            builder: (context, paymentsState) {
              return BlocBuilder<ShopsBloc, ShopsState>(
                buildWhen: (previous, current) =>
                    previous.shops.length != current.shops.length,
                builder: (context, shopsState) {
                  return BlocBuilder<DateFilterBloc, DateFilterState>(
                    builder: (context, filterState) {
                      //////////////////////////////////////////////////////
                      //////////////////////////////////////////////////////
                      _items = itemsState.items;
                      _payments = paymentsState.payments;
                      _shops = shopsState.shops;
                      //////////////////////////////////////////////////////

                      /// //////////////////////////////////////////////////////
                      final ItemsData _itemsData = ItemsData(items: _items);

                      /// //////////////////////////////////////////////////////
                      DataSink _dataSink = DataSink(
                        shops: _shops,
                        items: _items,
                        payments: _payments,
                      );

                      /// //////////////////////////////////////////////////////
                      // List<ShopData> _shopsDataList = _dataSink.allShopsData;
                      // ShopDataCalculations _shopDataCalculations =
                      //     ShopDataCalculations(
                      //   items: _items,
                      //   payments: _payments,
                      // );

                      /// //////////////////////////////////////////////////////
                      // _shopsDataList.isNotEmpty
                      //     ? _shopData = _shopsDataList[0]
                      //     : _shopData = null;

                      /// items by shop
                      List<Tagged> _dataByShops = _dataSink.taggedShops;

                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 12),
                            BluredContainer(
                              margin: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                              child: ColumnChartWidget(
                                chartData: _dataByShops,
                                title: "Items by Shop",
                              ),
                            ),
                            BluredContainer(
                              margin: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width,
                              height: 240,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LineChartWidgetDate(
                                      chartData:
                                          _itemsData.monthlyItemsChartData,
                                      title: "Items Sold By Month")),
                            ),
                            BluredContainer(
                                margin: EdgeInsets.all(8),
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                child: PeiWidget(
                                  chartData: _itemsData.itemsByNameChartData,
                                  title: "Highest Items",
                                )),
                            const SizedBox(
                              width: 100,
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
    );
  }
}
