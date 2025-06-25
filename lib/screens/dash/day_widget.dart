// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lkarnet/models/data_sink.dart';
// import 'package:lkarnet/models/shop/shops_data.dart';
// import 'package:lkarnet/models/statistics/tagged.dart';
// import 'package:lkarnet/widgets/glasswidget.dart';
// import 'package:lkarnet/widgets/items_listview.dart';

// import '../../blocs/datefilterbloc/date_filter_bloc.dart';
// import '../../blocs/itemsbloc/items_bloc.dart';
// import '../../blocs/payments/payments_bloc.dart';
// import '../../blocs/shopsbloc/shops_bloc.dart';
// import '../../models/item/item.dart';
// import '../../models/payment/payment_model.dart';
// import '../../models/shop/shop_model.dart';

// final mlistIndex = StateProvider<int>((ref) {
//   return 0;
// });

// class DailyDash extends StatefulWidget {
//   const DailyDash({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<DailyDash> createState() => _DailyDashState();
// }

// class _DailyDashState extends State<DailyDash> {
//   // final _scrollController = ScrollController();
//   int _currentIndex = 0;
//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return BlocBuilder<ItemsBloc, ItemsState>(
//       builder: (context, itemsState) {
//         return BlocBuilder<PaymentsBloc, PaymentsState>(
//           builder: (context, paymentsState) {
//             return BlocBuilder<ShopsBloc, ShopsState>(
//               builder: (context, shopsState) {
//                 return BlocBuilder<DateFilterBloc, DateFilterState>(
//                   builder: (context, filterState) {
//                     //////////////////////////////////////////////////////
//                     //////////////////////////////////////////////////////
//                     List<ItemModel> _items = itemsState.items;
//                     List<PaymentModel> _payments = paymentsState.payments;
//                     List<ShopModel> _shops = shopsState.shops;
//                     //////////////////////////////////////////////////////

//                     //////////////////////////////////////////////////////
//                     var _dataSink = DataSink(_shops, _items, _payments);
//                     //////////////////////////////////////////////////////
//                     List<Tagged> _listOfTagged = _dataSink.taggedDistinctDates;

//                     final _tagged = _listOfTagged[_currentIndex];
//                     //////////////////////////////////////////////////////

//                     return SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 IconButton(
//                                     icon: Icon(Icons.arrow_back_ios_rounded),
//                                     onPressed: () {
//                                       if (_currentIndex > 0)
//                                         setState(() {
//                                           _currentIndex--;
//                                         });
//                                     }),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Day: ',
//                                       style:
//                                           Theme.of(context).textTheme.headline2,
//                                     ),
//                                     Text('${_tagged.tag}'),
//                                   ],
//                                 ),
//                                 IconButton(
//                                     icon: Icon(Icons.arrow_forward_ios_rounded),
//                                     onPressed: () {
//                                       if (_currentIndex <
//                                           _listOfTagged.length - 1) {
//                                         setState(() {
//                                           _currentIndex++;
//                                         });
//                                       }
//                                     }),
//                               ],
//                             ),
//                           ),
//                           _buildMonthlyCard(context, _tagged),
//                           Container(
//                             width: 420,
//                             height: 400,
//                             child: ListView.builder(
//                                 itemCount: _tagged.shopsDataList.length,
//                                 itemBuilder: (context, index) {
//                                   ShopData shopData =
//                                       _tagged.shopsDataList[index];
//                                   return BluredContainer(
//                                     child: ExpansionTile(
//                                       collapsedTextColor: Colors.white,
//                                       textColor: Colors.white,
//                                       title: Text('${shopData.shop.shopName}'),
//                                       trailing: Text(
//                                           '${shopData.shopDataCalculations.itemsSum}'),
//                                       subtitle: Text(
//                                         'N° items : ' +
//                                             '${shopData.shopDataCalculations.countItems}',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .subtitle2,
//                                       ),
//                                       leading: CircleAvatar(
//                                         child: Icon(
//                                           Icons.account_circle,
//                                           color: Colors.grey,
//                                         ),
//                                         backgroundColor: Theme.of(context)
//                                             .colorScheme
//                                             .secondary,
//                                       ),
//                                       children: [
//                                         Container(
//                                             width: 400,
//                                             height: 400,
//                                             child: ItemsListWidget(
//                                               items: shopData.items,
//                                             )),
//                                       ],
//                                     ),
//                                   );
//                                 }),
//                           ),
//                           SizedBox(
//                             height: 50,
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   Container _buildMonthlyCard(BuildContext context, Tagged tagged) {
//     return Container(
//       height: 100,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: BluredContainer(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Total-amount',
//                       //style: Theme.of(context).textTheme.headline3,
//                     ),
//                     Text(
//                       tagged.shopDataCalculations.itemsSumAfterPayment
//                           .toString(),
//                       //style: AkThemeData.darkThemeData.textTheme.headline4,
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Total number of items',
//                       style: Theme.of(context).textTheme.subtitle2,
//                     ),
//                     Text(
//                       '${tagged.shopDataCalculations.countItems}',
//                       style: Theme.of(context).textTheme.subtitle2,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
