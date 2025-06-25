import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/blocs/kitchenelementbloc/kitchen_element_bloc.dart';
import 'package:lkarnet/blocs/kitchenitembloc/kitchen_item_bloc.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/kitchen/kitchen_element_data.dart';
import 'package:lkarnet/screens/add/add_kitechen_element.dart';
import '../blocs/datefilterbloc/date_filter_bloc.dart';
import '../models/item/items_filtered.dart';
import '../models/kitchen/kitchen_element.dart';
import '../models/kitchen/kitchen_item.dart';
import '../repository/database_operations.dart';
import '../widgets/availability_widget.dart';
import '../widgets/charts.dart';
import 'tabs/kitchen_element_detailed.dart';

class KitchenStockHomeView extends StatelessWidget {
  const KitchenStockHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => KitchenElementBloc(GetIt.I<DatabaseOperations>())
            ..add(GetKitchenElementsEvent()),
        ),
        BlocProvider(
          create: (context) => KitchenItemBloc(GetIt.I<DatabaseOperations>())
            ..add(GetKitchenItemsEvent()),
        ),
        BlocProvider<DateFilterBloc>(
          create: (context) => DateFilterBloc()
            ..add(ChangeDateFilterEvent(dateFilter: DateFilter.all)),
        ),
      ],
      child: KitchenStockWidget(),
    );
  }
}

class KitchenStockWidget extends StatelessWidget {
  const KitchenStockWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BluredContainer(
      start: 0.1,
      end: 0,
      borderColorOpacity: 0,
      child: BlocBuilder<KitchenItemBloc, KitchenItemState>(
          builder: (context, kItemsState) {
        return BlocBuilder<KitchenElementBloc, KitchenElementState>(
            builder: (context, kElmntsState) {
          if (kItemsState.kitchenItems.isNotEmpty ||
              kElmntsState.kitchenElements.isNotEmpty) {
            List<KitchenElementModel> _kitchenElements =
                kElmntsState.kitchenElements;
            List<KitchenItemModel> _kitchenItems = kItemsState.kitchenItems;
            KitchenElementsData? _kitchenElementsData = KitchenElementsData(
              kitchenElementList: _kitchenElements,
              kitchenItems: _kitchenItems,
            );
            //  log('KitchenStockHome: _kitchenElementsData: ${kElmntsState.status}');
            //kitchenElements = KitchenElement.fakeKitchenElements;
            return Scaffold(
              backgroundColor: Colors.transparent,

              appBar: AppBar(
                actions: [
                  /// add kitchenEle to database
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddKitchenElement(),
                        ),
                      );
                    },
                    icon: Icon(Icons.add_box_outlined),
                  )
                  // NotificationsIconButton(
                  //   ref: ref,
                  // ),
                ],
                leading: Icon(Icons.kitchen_outlined, color: Colors.black),
                title: Text(
                  'Kitchen Stock',
                  style: Theme.of(context).textTheme.headlineMedium,
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
              // Next, create a SliverList
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildBarChartWidget(_kitchenElements),
                    const SizedBox(height: 20),
                    _buildGridView(context, _kitchenElementsData),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
      }),
    );
  }

  _buildBarChartWidget(List<KitchenElementModel> kitchenElements) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 200,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: BluredContainer(
          margin: EdgeInsets.all(8),
          width: 400,
          height: 220,
          child: ColumnChartKitchenElWidget(kitchenElements)),
    );
  }

  _buildGridView(
      BuildContext context, KitchenElementsData _kitchenElementsData) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      // height: 440,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12),
        itemCount: _kitchenElementsData.allKitchenElementData.length,
        itemBuilder: (context, index) {
          final KitchenElementDataModel kitchenElement =
              _kitchenElementsData.allKitchenElementData[index];
          return KitchenItemSquareTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KitchenElementDetailsScreen(
                    kitchenElement: kitchenElement,
                  ),
                ),
              );
            },
            kitchenElement: kitchenElement,
          );
        },
      ),
    );
  }
}

class KitchenItemSquareTile extends StatelessWidget {
  const KitchenItemSquareTile({
    Key? key,
    required this.onTap,
    required this.kitchenElement,
  }) : super(key: key);

  final VoidCallback? onTap;
  final KitchenElementDataModel kitchenElement;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BluredContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          //verticalDirection: VerticalDirection.up,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0, right: 8),
                              child: Text(
                                kitchenElement.kitchenElement.title.toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                            PiorityRatingWidget(
                              ignoreGestures: true,
                              onRatingChanged: (rating) {},
                              initialRating:
                                  kitchenElement.kitchenElement.priority!,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // buildKitchenItemDetail(context,
                  //     title: 'Status: ',
                  //     digitWidget: ProgressWidget(
                  //       kitchenElement: kitchenElement,
                  //     )),

                  const SizedBox(height: 4),
                  _buildDetails(context),
                ],
              ),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: SizedBox(
                height: 45,
                child: Card(
                  margin: EdgeInsets.all(0),
                  color: AppConstants.whiteOpacity,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(4.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ProgressWidget(
                          availability:
                              kitchenElement.kitchenElement.availability ?? 0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${kitchenElement.kitchenElement.category!.trim()}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          Icon(
                            Icons.fastfood,
                            color: Colors.white.withOpacity(0.5),
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildDetails(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildKitchenItemDetail(context,
                title: 'Last Bought: ',
                digitWidget: Text(
                  kitchenElement.lastTimeBought,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontFamily: 'Montserrat',
                      color: Color.fromARGB(104, 36, 35, 35).withOpacity(0.6)),
                )),
            buildKitchenItemDetail(context,
                title: 'Times Bought: ',
                digitWidget: Text(
                  kitchenElement.timesBought.toString(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Color.fromARGB(104, 36, 35, 35).withOpacity(0.6)),
                )),
          ],
        ),
      ],
    );
  }

  Padding buildKitchenItemDetail(BuildContext context,
      {String? title, Widget? digitWidget}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? '',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white.withOpacity(0.3)),
          ),
          digitWidget ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
