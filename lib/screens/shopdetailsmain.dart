import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/widgets/myappbar.dart';
import '../blocs/itemsbloc/items_bloc.dart';
import '../blocs/payments/payments_bloc.dart';
import '../blocs/shopsbloc/shops_bloc.dart';
import '../components.dart';
import '../models/payment/payment_model.dart';
import '../models/statistics/tagged.dart';
import '../widgets/price_curency_widget.dart';
import '../widgets/shop_square_tile.dart';
import 'shop_details/shop_details_tab.dart';

class ShopDetailsMain extends ConsumerStatefulWidget {
  const ShopDetailsMain({
    Key? key,
  }) : super(key: key);
  //final ShopData? shopsData;
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends ConsumerState<ShopDetailsMain> {
  Tagged? _tagged;
  List<Tagged> _taggedList = [];
  List<ItemModel> _items = [];
  List<PaymentModel> _payments = [];
  List<ShopModel> _shops = [];
  int filter = 1;
  int groupValue = 1;
  Map<int, String> _groupValueMap = {
    // 0: 'All',
    1: 'Daily',
    //2: 'Weekly',
    3: 'Monthly',
    4: 'Yearly',
  };

  @override
  void initState() {
    super.initState();
  }

  List<Tagged> _listOfTags() {
    List<Tagged> _list = [];
    List<DateTime> _distinctDates =
        _items.map((item) => item.dateBought.toDate()).toSet().toList();
    List<DateTime> _distinctMonths =
        _items.map((item) => item.dateBought.toMonth()).toSet().toList();
    List<DateTime> _distinctYears =
        _items.map((item) => item.dateBought.toYear()).toSet().toList();
    //////////////////////////////////////////////////////
    switch (filter) {
      // case 0:
      //   return _list = _distinctDates
      //       .map((dstDate) => Tagged(
      //             tag: dstDate,
      //             items: _items,
      //             payments: _payments,
      //           ))
      //       .toList();
      case 1:
        return _list = _distinctDates
            .map((dstDate) => Tagged(
                  tag: dstDate,
                  items: _items
                      .where((item) => item.dateBought.isMatchDay(dstDate))
                      .toList(),
                  payments: _payments
                      .where((payment) => payment.datePaid.isMatchDay(dstDate))
                      .toList(),
                ))
            .toList();
      case 3:
        return _list = _distinctMonths
            .map((dstDate) => Tagged(
                  tag: dstDate,
                  items: _items
                      .where((item) => item.dateBought.isMatchMonth(dstDate))
                      .toList(),
                  payments: _payments
                      .where(
                          (payment) => payment.datePaid.isMatchMonth(dstDate))
                      .toList(),
                ))
            .toList();
      case 4:
        return _list = _distinctYears
            .map((dstDate) => Tagged(
                  tag: dstDate,
                  items: _items
                      .where((item) => item.dateBought.isMatchYear(dstDate))
                      .toList(),
                  payments: _payments
                      .where((payment) => payment.datePaid.isMatchYear(dstDate))
                      .toList(),
                ))
            .toList();
      default:
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopsBloc, ShopsState>(
      buildWhen: (previous, current) =>
          previous.shops.length != current.shops.length,
      builder: (context, shopsState) {
        return BlocBuilder<PaymentsBloc, PaymentsState>(
          buildWhen: (previous, current) =>
              previous.payments.length != current.payments.length,
          builder: (context, paymentsState) {
            return BlocBuilder<ItemsBloc, ItemsState>(
              buildWhen: (previous, current) =>
                  previous.items.length != current.items.length,
              builder: (context, itemsState) {
                //////////////////////////////////////////////////////

                //////////////////////////////////////////////////////
                _items = itemsState.items;
                _payments = paymentsState.payments;
                _shops = shopsState.shops;
                //////////////////////////////////////////////////////
                _taggedList = _listOfTags();
                //////////////////////////////////////////////////////
                //////////////////////////////////////////////////////
                // DataSink _dataSink = DataSink(_shops, _items, _payments);
                //////////////////////////////////////////////////////
                ////////////////////////////////////////////////
                //////////////////////////////////////////////////////
                var _shopDataList = shopsDataList(_shops, _tagged)
                  ..removeWhere((element) =>
                      element.shopDataCalculations.itemsSumAfterPayment == 0);
                //////////////////////////////////////////////////////
                // _tagged == null ? _listOfTagged[0] : _tagged;
                return BluredContainer(
                  start: 0,
                  end: 0,
                  borderColorOpacity: 0,
                  child: Scaffold(
                    backgroundColor: Color.fromARGB(0, 255, 255, 255),
                    // floatingActionButton: MyExpandableFab(),
                    // floatingActionButtonLocation:
                    //     FloatingActionButtonLocation.endFloat,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      flexibleSpace: MyAppBar(
                        title: Text('Shop Details'),
                      ),
                    ),

                    // Next, create a SliverList
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          buildSelectFilter(),
                          Container(
                            height: 235,
                            width: double.infinity,
                            // color: Color.fromARGB(94, 255, 193, 7),
                            child: Stack(
                              //fit: StackFit.loose,
                              children: [
                                _tagged != null
                                    ? _buildMonthlyCard(context, _tagged!)
                                    : Container(),
                                Positioned(
                                  top: 195,
                                  width: 360,
                                  left: MediaQuery.of(context).size.width / 2 -
                                      180,
                                  child: _buildSelector(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          _tagged == null
                              ? SizedBox.shrink()
                              : Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 1.5,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10),
                                    itemCount: _shopDataList.length,
                                    itemBuilder: (context, index) {
                                      return SimpleShopSquareTile(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ShopDetailsTab(
                                              shopData: _shopDataList[index],
                                            ),
                                          ),
                                        ),
                                        shopData: _shopDataList[index],
                                      );
                                    },
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
  }

  SizedBox buildSelectFilter() {
    return SizedBox(
      height: 45,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// a dropDownButton
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                color: Color.fromARGB(157, 255, 255, 255),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  alignment: Alignment.center,
                  value: filter,
                  icon: Container(),
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      filter = newValue ?? 0;
                    });
                  },
                  items: _groupValueMap.keys
                      .map<DropdownMenuItem<int>>((int value) =>
                          DropdownMenuItem<int>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Text(_groupValueMap[value] ?? ''),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ShopData> shopsDataList(List<ShopModel> shops, Tagged? tegged) {
    List<ShopData> shopsDataList = [];
    if (tegged == null) return shopsDataList;
    for (ShopModel shop in shops) {
      shopsDataList.add(
        ShopData(
          shop: shop,
          items: tegged.items
              .where((item) => item.shopName == shop.shopName)
              .toList(),
          payments: tegged.payments
              .where((payment) => payment.paidShopName == shop.shopName)
              .toList(),
        ),
      );
    }
    return shopsDataList;
  }
// build custom listTile

  Widget _buildSelector() {
    // _tagged = _taggedList[filter];
    return BluredContainer(
      start: 0.5,
      end: 0.5,
      height: 40,
      width: 380,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _taggedList.length,
        itemBuilder: (context, index) {
          final Tagged mtagged = _taggedList[index];

          return SizedBox(
            width: 100,
            height: 30,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _tagged = mtagged;
                });
              },
              child: Card(
                color: _tagged == _taggedList[index]
                    ? AppConstants.primaryColor
                    : AppConstants.whiteOpacity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // tagged == _tagged ? Text('Selected') : Text(''),
                    Text(
                      mtagged.date.ddmmyyyy(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildMonthlyCard(BuildContext context, Tagged tagged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BluredContainer(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total-amount',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  PriceNumberZone(
                      right: const SizedBox.shrink(),
                      withDollarSign: true,
                      price: tagged.shopDataCalculations.itemsSumAfterPayment,
                      style: Theme.of(context).textTheme.displaySmall!),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total sum of items',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppConstants.whiteOpacity),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: tagged.shopDataCalculations.itemsSum,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppConstants.hintColor,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total sum of payments',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppConstants.whiteOpacity),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: tagged.shopDataCalculations.paymentsSum,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppConstants.hintColor,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total number of items',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppConstants.whiteOpacity),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: tagged.shopDataCalculations.countItems.toDouble(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppConstants.hintColor,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total number of payments',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppConstants.whiteOpacity),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: tagged.shopDataCalculations.countPayments.toDouble(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppConstants.hintColor,
                        ),
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
