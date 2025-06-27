import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/repository/database_operations.dart';

import '../blocs/kitchenitembloc/kitchen_item_bloc.dart';
import '../models/item/item.dart';
import '../models/kitchen/kitchen_element.dart';
import '../models/kitchen/kitchen_item.dart';
import '../settings/theme.dart';
import 'kitchen_elements_spinner.dart';

class AddToKitchenFromItem extends StatefulWidget {
  const AddToKitchenFromItem({super.key, required this.item});
  final ItemModel item;

  @override
  State<AddToKitchenFromItem> createState() => _StateAddToKitchenFromItem();
}

class _StateAddToKitchenFromItem extends State<AddToKitchenFromItem> {
  KitchenElementModel? _kitchenElement;
  // bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select kitchen Element to add item to',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KitchenElementsSpinner(
                onSelected: (element) {
                  setState(() {
                    _kitchenElement = element;
                  });
                },
              ),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: _kitchenElement == null
                      ? null
                      : () {
                          final kElBloc = KitchenItemBloc(
                            GetIt.I<DatabaseOperations>(),
                          );
                          kElBloc.add(
                            AddKitchenItemEvent(
                              KitchenItemModel.fromItem(
                                widget.item,
                                _kitchenElement!,
                              ),
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                  style: MThemeData.raisedButtonStyleSave,
                  child: Text('Save'),
                ),
              ),
              // const SizedBox(width: 4),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
