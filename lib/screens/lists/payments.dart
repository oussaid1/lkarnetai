import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../blocs/itemsbloc/items_bloc.dart';
import '../../blocs/payments/payments_bloc.dart';
import '../../blocs/shopsbloc/shops_bloc.dart';
import '../../components.dart';
import '../../models/data_sink.dart';
import '../../models/item/item.dart';
import '../../models/payment/payment_model.dart';
import '../../models/shop/shop_model.dart';
import '../../models/shop/shops_data.dart';
import '../../widgets/payment_listtile.dart';
import '../../widgets/search_by_widget.dart';

class ViewPaymentsList extends StatelessWidget {
  final List<PaymentModel>? lista;
  ViewPaymentsList({
    Key? key,
    this.lista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
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
                      items: _items,
                      payments: _payments,
                      shops: _shops,
                    );
                    List<ShopData> _shopsDataList = _dataSink.allShopsData;

                    return Container(
                      margin: EdgeInsets.only(
                          top: 10, left: 4, right: 4, bottom: 8),
                      child: ListView.builder(
                        itemCount: _shopsDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          ShopData shopsData = _shopsDataList[index];
                          return new ExpansionTile(
                            title: Text('${shopsData.shop.shopName}'),
                            trailing: Text(
                                '${shopsData.shopDataCalculations.paymentsSum}'),
                            leading: CircleAvatar(
                              child: const Icon(
                                Icons.account_circle,
                                size: 40,
                                color: Colors.grey,
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 300,
                                width: 400,
                                child: ListView.builder(
                                  itemCount: lista!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    PaymentModel payment = lista![index];
                                    return PaymentTile(payment: payment);
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class PaymentsList extends StatefulWidget {
  final List<PaymentModel> lista;
  PaymentsList({
    Key? key,
    required this.lista,
  }) : super(key: key);
  @override
  State<PaymentsList> createState() => _PaymentsListState();
}

class _PaymentsListState extends State<PaymentsList> {
  String _filterPattern = '';
  String _filterType = '';
  List<PaymentModel> _filteredList() {
    List<PaymentModel> lista = widget.lista;
    switch (_filterType) {
      case "date":
        return lista
            .where((item) =>
                item.datePaid.ddmmyyyy().contains(_filterPattern.toLowerCase()))
            .toList();
      case "price":
        return lista
            .where(
                (item) => item.paidAmount.toString().contains(_filterPattern))
            .toList();
      case "category":
        return lista
            .where((item) => item.besoinTitle!
                .toLowerCase()
                .contains(_filterPattern.toLowerCase()))
            .toList();
      case "shop":
        return lista
            .where((item) => item.paidShopName!
                .toLowerCase()
                .contains(_filterPattern.toLowerCase()))
            .toList();
      default:
    }
    return lista;
  }

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
          actions: [
            // IconButton(
            //   icon: Icon(Icons.add_box_outlined),
            //   onPressed: () async {
            //     var logger = Logger();
            //     for (var item in items!) {
            //       logger.d(item.toMap());
            //     }
            //   },
            // ),
          ],
          leading: Icon(Icons.menu, color: Colors.black),
          title: Text(
            'All Items',
            style: Theme.of(context).textTheme.displayMedium,
          ),
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SearchByWidget(
                withCategory: true,
                listOfCategories: ['date', 'price', 'category', 'shop'],
                onChanged: (catg, searchText) {
                  setState(() {
                    _filterPattern = searchText;
                    _filterType = catg;
                  });
                },
              ),
              BluredContainer(
                margin: EdgeInsets.only(top: 10, left: 4, right: 4, bottom: 8),
                child: ListView.builder(
                  itemCount: _filteredList().length,
                  itemBuilder: (BuildContext context, int index) {
                    PaymentModel payment = _filteredList()[index];
                    return PaymentTile(payment: payment);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
