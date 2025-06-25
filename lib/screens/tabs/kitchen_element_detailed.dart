import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/blocs/kitchenelementbloc/kitchen_element_bloc.dart';
import 'package:lkarnet/blocs/kitchenitembloc/kitchen_item_bloc.dart';
import 'package:lkarnet/repository/database_operations.dart';
import 'package:lkarnet/screens/add/add_kitchen_item.dart';
import 'package:lkarnet/screens/add/add_kitechen_element.dart';
import 'package:lkarnet/settings/theme.dart';

import '../../blocs/itemsbloc/items_bloc.dart';
import '../../components.dart';
import '../../models/kitchen/kitchen_element_data.dart';
import '../../models/kitchen/kitchen_item.dart';
import '../../widgets/availability_widget.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/expired_switch.dart';
import '../../widgets/kitchen_item_listtile.dart';

class KitchenElementDetailsScreen extends StatefulWidget {
  const KitchenElementDetailsScreen({Key? key, required this.kitchenElement})
      : super(key: key);
  final KitchenElementDataModel kitchenElement;
  @override
  State<KitchenElementDetailsScreen> createState() =>
      _KitchenItemDetailsScreenState();
}

class _KitchenItemDetailsScreenState
    extends State<KitchenElementDetailsScreen> {
  DateTime? _expiryDate = DateTime.now();

  /// this is used in setting the expiration date of the kitchen item
  List<KitchenItemModel> _kitchenItems = [];

  @override
  Widget build(BuildContext context) {
    final _kelmbloc = KitchenElementBloc(GetIt.I<DatabaseOperations>());
    final _kitmbloc = KitchenItemBloc(GetIt.I<DatabaseOperations>());
    return Scaffold(
      body: GlassMaterial(
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
        centerWidget: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  KitchenElementBloc(GetIt.I<DatabaseOperations>())
                    ..add(GetKitchenElementsEvent()),
            ),
            BlocProvider(
              create: (context) =>
                  KitchenItemBloc(GetIt.I<DatabaseOperations>())
                    ..add(GetKitchenItemsEvent()),
            ),
          ],
          child: Scaffold(
            backgroundColor: Colors.transparent,

            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              heroTag: 'kitchen_element_details_screen',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => KitchenItemBloc(
                            GetIt.I<DatabaseOperations>(),
                          )..add(GetKitchenItemsEvent()),
                        ),
                        BlocProvider(
                          create: (context) => ItemsBloc(
                              databaseOperations: GetIt.I<DatabaseOperations>())
                            ..add(GetItemsEvent()),
                        ),
                      ],
                      child: AddKitchenItem(
                        kitchenElement: widget.kitchenElement.kitchenElement,
                      ),
                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text('${widget.kitchenElement.kitchenElement.title}'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddKitchenElement(
                          kitchenElement: widget.kitchenElement.kitchenElement,
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Dialogs.confirmDialogue(
                      context,
                      title: 'Delete',
                      message: 'Are you sure you want to delete this item?',
                    ).then((value) => {
                          if (value)
                            {
                              ///  delete kitchen element
                              _kelmbloc.add(DeleteKitchenElementEvent(
                                  kitchenElement:
                                      widget.kitchenElement.kitchenElement)),

                              /// then loop over all the items in the kitchen element and delete them

                              _kitmbloc.add(DeleteAllKitchenItems(
                                widget.kitchenElement.kitchenItems,
                              )),
                            }
                        });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),

            // Next, create a SliverList
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  _buildTopContainer(context, _kelmbloc, _kitmbloc),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Items',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              'Long press to set the expiration date ! if Item expired !',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildBottomContainer(context, _kelmbloc, _kitmbloc),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// this is the bottom container of the screen that contains the kitchen items
  _buildBottomContainer(BuildContext context, _kelmbloc, _kitmbloc) {
    return BluredContainer(
      margin: EdgeInsets.symmetric(horizontal: 8),
      // height: 340,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<KitchenItemBloc, KitchenItemState>(
          builder: (context, kitchenItemsState) {
        if (kitchenItemsState.kitchenItems.isNotEmpty) {
          _kitchenItems = kitchenItemsState.kitchenItems;

          final KitchenElementDataModel _singleKitchenElementData =
              KitchenElementDataModel(
            kitchenElement: widget.kitchenElement.kitchenElement,
            kitchenItemList: _kitchenItems,
          );
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _singleKitchenElementData.kitchenItems
                .length, //widget.kitchenElement.sortedItems.length,
            itemBuilder: (context, index) {
              final KitchenItemModel _kitchenItem =
                  _singleKitchenElementData.kitchenItems[index];
              return KitchenItemTileWidget(
                onDoubleTap: () {
                  setState(() {
                    _expiryDate = null;
                  });
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: ExpiredSwitch(
                        onChanged: (value) {
                          /// if the item is not expired, then set the expiry date to null
                          /// else set the expiry date to the picked date as expiry date
                          setState(() {
                            if (value['isExpired']) {
                              setState(() {
                                //  _isLoading = false;
                                _expiryDate = value['expiryDate'];
                              });
                            } else {
                              setState(() {
                                _expiryDate = null;
                                //_isLoading = false;
                              });
                            }
                          });
                        },
                      ),
                      //content:
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              child: Text(
                                'Cancel',
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),

                            //const Spacer(),
                            ElevatedButton(
                              child: Text('Ok'),
                              onPressed: () {
                                _kitmbloc.add(UpdateKitchenItemEvent(
                                    _kitchenItem.copyWith(
                                  dateExpired: _expiryDate,
                                )));
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                kitchenItem: _kitchenItem,
              );
            },
          );
        } else
          return Center(child: Text('something went wrong'));
      }),
    );
  }

  BluredContainer _buildTopContainer(
      BuildContext context, _kelmbloc, _kitmbloc) {
    return BluredContainer(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BluredContainer(
            height: 65,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AvailabilityChangeWidget(
                    initialValue:
                        widget.kitchenElement.kitchenElement.availability!,
                    onSaved: (newVal) {
                      _kelmbloc.add(UpdateKitchenElementEvent(
                          kitchenElement: widget.kitchenElement.kitchenElement
                              .copyWith(availability: newVal)));
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 12),
                        child: Text(
                          widget.kitchenElement.kitchenElement.title.toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      PiorityRatingWidget(
                        ignoreGestures: true,
                        onRatingChanged: (rating) {},
                        initialRating:
                            widget.kitchenElement.kitchenElement.priority!,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.kitchenElement.kitchenElement.category}',
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.fastfood,
                  color: Colors.white.withOpacity(0.5),
                  size: 20,
                ),
              ],
            ),
          ),

          ///  SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last bought: ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white.withOpacity(0.3)),
                ),
                Text(
                  '${widget.kitchenElement.lastTimeBought}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(104, 36, 35, 35).withOpacity(0.6),
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date expired : ',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white.withOpacity(0.3)),
                ),
                Text(
                  '${widget.kitchenElement.timeExpired}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(104, 36, 35, 35).withOpacity(0.6),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AvailabilityChangeWidget extends StatefulWidget {
  const AvailabilityChangeWidget({
    Key? key,
    required this.onSaved,
    required this.initialValue,
  }) : super(key: key);
  final void Function(double) onSaved;
  final double initialValue;

  @override
  State<AvailabilityChangeWidget> createState() =>
      _AvailabilityChangeWidgetState();
}

class _AvailabilityChangeWidgetState extends State<AvailabilityChangeWidget> {
  double availability = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: GestureDetector(
        onTap: () {
          showDialog<double>(
              barrierDismissible: true,
              context: context,
              builder: (mctx) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  child: Stack(
                    //overflow: Overflow.visible,
                    clipBehavior: Clip.none,
                    fit: StackFit.passthrough,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 130,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: MThemeData.raisedButtonStyleSave,
                                onPressed: () {
                                  widget.onSaved(availability);
                                  Navigator.of(context).pop(availability);
                                },
                                child: Text(
                                  'Save',
                                ),
                              ),
                              // const SizedBox(width: 10),
                              ElevatedButton(
                                style: MThemeData.raisedButtonStyleCancel,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Cancel',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: -60,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 60,
                            child: Availibility(
                              radius: 120,
                              initialValue: widget.initialValue,
                              onChanged: (newVal) {
                                setState(() {
                                  availability = newVal;
                                });
                              },
                            ),
                          )),
                    ],
                  ))).then((value) => value);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ProgressWidget(
                  availability: widget.initialValue,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status: ',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white.withOpacity(0.3)),
                ),
                Text(
                  'tap here to change status ... ! ',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PiorityRatingWidget extends StatelessWidget {
  const PiorityRatingWidget({
    Key? key,
    required this.onRatingChanged,
    this.initialRating = 0,
    this.itemSize = 18,
    this.ignoreGestures = false,
  }) : super(key: key);
  final void Function(double) onRatingChanged;
  final double itemSize;
  final double initialRating;
  final bool ignoreGestures;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RatingBar.builder(
            ignoreGestures: ignoreGestures,
            initialRating:
                initialRating, //ref.watch(priorityRatingProvider.state).state,
            itemSize: itemSize,
            minRating: 0,
            direction: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, _) =>
                Icon(Icons.star_border_purple500, color: Colors.amber),
            onRatingUpdate: onRatingChanged),
      ],
    );
  }
}

// ignore: must_be_immutable
class Availibility extends StatefulWidget {
  Availibility(
      {Key? key,
      required this.onChanged,
      this.initialValue = 0,
      this.radius = 35})
      : super(key: key);
  final void Function(double) onChanged;
  final double radius;

  double initialValue = 0;

  @override
  State<Availibility> createState() => _AvailibilityState();
}

class _AvailibilityState extends State<Availibility> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius,
      height: widget.radius,
      child: GestureDetector(
        onTap: () {
          if (widget.initialValue < 10) {
            setState(() {
              widget.initialValue++;
            });
          } else {
            setState(() {
              widget.initialValue = 0;
            });
          }
          widget.onChanged(widget.initialValue);
        },
        child: SfRadialGauge(
          // backgroundColor: Colors.white,

          axes: <RadialAxis>[
            RadialAxis(
              useRangeColorForAxis: true,
              labelFormat: '${widget.initialValue}',
              maximumLabels: 0,
              labelOffset: 45,
              labelsPosition: ElementsPosition.inside,
              axisLabelStyle: GaugeTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 115, 0)),
              minimum: 0,
              maximum: 10,
              showLabels: true,
              showTicks: false,
              startAngle: 250,
              endAngle: 250,
              axisLineStyle: AxisLineStyle(
                thickness: 0.05,
                color: Colors.white.withOpacity(0.5),
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                  color: Color.fromARGB(183, 252, 252, 252),
                  value: widget.initialValue,
                  width: 0.95,
                  // pointerOffset: 0.05,
                  sizeUnit: GaugeSizeUnit.factor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
