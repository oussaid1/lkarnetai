import 'package:flutter/material.dart';
import 'package:lkarnet/components.dart';
import '../../models/shop/shops_data.dart';
import '../../models/statistics/statistics_model.dart';
import 'shop_stats_charts.dart';

class ShopStatsPage extends StatefulWidget {
  final ShopData? shopData;
  const ShopStatsPage({super.key, required this.shopData});
  @override
  State<ShopStatsPage> createState() => _ShopStatsPageState();
}

class _ShopStatsPageState extends State<ShopStatsPage> {
  /////////////////
  ShopData? _shopData;
  /////////////////
  //int _filter = 0;
  List<ItemsChartData<dynamic>> _chartData = [];
  @override
  void initState() {
    _shopData = widget.shopData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverStickyHeader(
          sticky: false,
          header: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _chartData =
                        _shopData!.itemsDataForAll.monthlyItemsChartData;
                  });
                },
                child: Container(
                  height: 50.0,
                  width: 100,
                  margin: EdgeInsets.all(8),
                  color: AppConstants.whiteOpacity,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Monthly',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _chartData =
                        _shopData!.itemsDataForAll.yearlyItemsChartData;
                  });
                },
                child: Container(
                  height: 50.0,
                  width: 100,
                  margin: EdgeInsets.all(8),
                  color: AppConstants.whiteOpacity,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Yearly',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _chartData = _shopData!.itemsDataForAll.dailyItemsChartData;
                  });
                },
                child: Container(
                  height: 50.0,
                  width: 100,
                  margin: EdgeInsets.all(8),
                  color: AppConstants.whiteOpacity,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Daily',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                BluredContainer(
                  margin: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  height: 260,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _shopData != null
                        ? LineChartWidgetDate(
                            chartData: _chartData,
                            title: 'Items Price',
                          )
                        : const SizedBox(),
                  ),
                ),
                BluredContainer(
                  margin: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  height: 260,
                  child: _shopData != null
                      ? PeiWidget(
                          chartData:
                              _shopData!.itemsDataForAll.itemsByNameChartData,
                          title: "Most Expenssive Items",
                        )
                      : const SizedBox(),
                ),
                BluredContainer(
                  margin: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  height: 260,
                  child: ColumnChartWidget(
                    chartData: _shopData!.itemsDataForAll.itemsByNameChartData,
                    title: "Most Frequent Items",
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


// Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               BluredContainer(
//                 margin: EdgeInsets.all(8),
//                 width: MediaQuery.of(context).size.width,
//                 height: 240,
//                 child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: _shopData != null
//                         ? LineChartWidgetDate(
//                             chartData:
//                                 _shopData!.itemsDataForAll.dailyItemsChartData,
//                             title: "All Items")
//                         : const SizedBox()),
//               ),
//               BluredContainer(
//                 margin: EdgeInsets.all(8),
//                 width: MediaQuery.of(context).size.width,
//                 height: 240,
//                 child: _shopData != null
//                     ? PeiWidget(
//                         chartData:
//                             _shopData!.itemsDataForAll.itemsByNameChartData,
//                         title: "Most Expenssive Items",
//                       )
//                     : const SizedBox(),
//               ),
//               BluredContainer(
//                 margin: EdgeInsets.all(8),
//                 width: MediaQuery.of(context).size.width,
//                 height: 220,
//                 child: ColumnChartWidget(
//                   chartData: _shopData!.itemsDataForAll.itemsByNameChartData,
//                   title: "Most Frequent Items",
//                 ),
//               ),
//               const SizedBox(
//                 width: 100,
//               ),
//             ],
//           )),