import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/blocs/kitchenitembloc/kitchen_item_bloc.dart';
import 'package:lkarnet/widgets/dialogs.dart';
import '../components.dart';
import '../models/kitchen/kitchen_item.dart';
import '../repository/database_operations.dart';
import '../screens/add/add_kitchen_item.dart';
import 'price_curency_widget.dart';

class KitchenItemTileWidget extends StatelessWidget {
  final VoidCallback? onDoubleTap;

  const KitchenItemTileWidget({
    Key? key,
    required this.kitchenItem,
    this.onDoubleTap,
  }) : super(key: key);

  final KitchenItemModel kitchenItem;

  @override
  Widget build(BuildContext context) {
    final _kitmBloc = KitchenItemBloc(GetIt.I<DatabaseOperations>());
    return Slidable(
      //actionPane: SlidableDrawerActionPane(),
      //  actionExtentRatio: 0.25,

      startActionPane: ActionPane(
        // dismissible: DismissiblePane(onDismissed: () {}),
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            key: const Key('action-1'),
            backgroundColor: Colors.transparent,
            onPressed: (contexti) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (contexta) => AddKitchenItem(
                    kitchenItem: kitchenItem,
                  ),
                ),
              );
            },
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),

      endActionPane: ActionPane(
        //dismissible: DismissiblePane(onDismissed: () {}),
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
              key: const Key('action-12'),
              backgroundColor: Colors.transparent,
              label: 'Delete',
              onPressed: (context) {
                Dialogs.confirmDialogue(context,
                        title: 'Delete',
                        message: 'Are you sure you want to delete this item?')
                    .then((confirmed) {
                  if (confirmed) {
                    _kitmBloc.add(DeleteKitchenItemEvent(kitchenItem));
                  }
                });
              },
              icon: Icons.delete),
        ],
      ),

      child: GestureDetector(
        onDoubleTap: onDoubleTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radius),
            side: BorderSide(
              color: AppConstants.whiteOpacity,
              width: 1,
            ),
          ),
          color: !kitchenItem.isExpired
              ? AppConstants.whiteOpacity
              : Color.fromARGB(171, 112, 111, 111),
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
                        color:
                            Color.fromARGB(255, 224, 2, 253).withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppConstants.radius),
                          bottomLeft: Radius.circular(AppConstants.radius),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${kitchenItem.quantity}',
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${kitchenItem.quantifier}',
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
                          '${kitchenItem.itemName}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          children: [
                            Text(
                              '${kitchenItem.shopName}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              '  ${kitchenItem.dateBought.formatted()}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(4.0),
                        child: PriceNumberZone(
                          price: kitchenItem.itemPrice,
                          style: Theme.of(context).textTheme.headlineMedium,
                          withDollarSign: true,
                        )),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // // build bottomsheet for add item
  // void mBottomSheet(
  //   BuildContext context, {
  //   AnimationController? controller
  //   // required Widget child,
  // }) {
  //   showModalBottomSheet(
  //       transitionAnimationController: controller,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(25.0),
  //         ),
  //       ),
  //       // backgroundColor: Colors.black,
  //       context: context,
  //       isScrollControlled: true,
  //       isDismissible: true,
  //       builder: (_) {
  //         return Container(
  //           decoration: BoxDecoration(
  //             color: Color.fromARGB(255, 189, 110, 110),
  //             borderRadius: BorderRadius.vertical(
  //               top: Radius.circular(25.0),
  //             ),
  //           ),
  //           height: 160,
  //           child: Padding(
  //             padding: MediaQuery.of(context).viewInsets,
  //             child: (
  //               item: _localItem!,
  //               op: ref.read(operationsProvider),
  //             ),
  //           ),
  //         );
  //       });
  // }
}
