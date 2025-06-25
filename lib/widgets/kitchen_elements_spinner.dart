import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/blocs/kitchenelementbloc/kitchen_element_bloc.dart';
import 'package:lkarnet/components.dart';
import 'package:flutter/material.dart';
import 'package:lkarnet/repository/database_operations.dart';
import '../models/kitchen/kitchen_element.dart';

class KitchenElementsSpinner extends StatelessWidget {
  const KitchenElementsSpinner({Key? key, required this.onSelected})
      : super(key: key);
  final void Function(KitchenElementModel) onSelected;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KitchenElementBloc(GetIt.I<DatabaseOperations>())
        ..add(GetKitchenElementsEvent()),
      child: KitchenElementsDropDown(
        onSelected: onSelected,
      ),
    );
  }
}

class KitchenElementsDropDown extends ConsumerStatefulWidget {
  const KitchenElementsDropDown({Key? key, required this.onSelected})
      : super(key: key);
  final void Function(KitchenElementModel) onSelected;

  @override
  ConsumerState<KitchenElementsDropDown> createState() =>
      _KitchenElementsDropDownState();
}

class _KitchenElementsDropDownState
    extends ConsumerState<KitchenElementsDropDown> {
  KitchenElementModel? _selectedKitchenElement;
  List<KitchenElementModel> _kitchenElements = [];

  @override
  Widget build(BuildContext context) {
    return BluredContainer(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(6),
      //   // color: AppConstants.whiteOpacity,
      // ),
      width: 160.0,
      height: 45,
      child: BlocBuilder<KitchenElementBloc, KitchenElementState>(
          builder: (context, snapshot) {
        if (snapshot.kitchenElements.isNotEmpty) {
          _kitchenElements = snapshot.kitchenElements;

          if (_selectedKitchenElement == null && !_kitchenElements.isEmpty) {
            _selectedKitchenElement = _kitchenElements.first;
          }
        }
        return DropdownButtonHideUnderline(
          child: ButtonTheme(
            height: 200,
            alignedDropdown: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<KitchenElementModel>(
                elevation: 4,
                iconSize: 30,
                icon: Icon(Icons.arrow_drop_down),
                isExpanded: true,
                value: _selectedKitchenElement,
                onChanged: (value) {
                  setState(() {
                    _selectedKitchenElement = value;
                  });
                  widget.onSelected(value!);
                },
                items: _kitchenElements.toSet().map((element) {
                  return DropdownMenuItem<KitchenElementModel>(
                    value: element,
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Text(
                          element.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  );
                }).toList()),
          ),
        );
      }),
    );
  }
}

// final kitchenElementProvider = StateProvider<KitchenElement?>((ref) {
//   return null;
// });

// class KitchenElementSpinner extends ConsumerWidget {
//   KitchenElementSpinner({Key? key, required this.onSelected});
//   final void Function(KitchenElement?) onSelected;
//   @override
//   Widget build(BuildContext context, ref) {
//     List<KitchenElement> _list = [];
//     // var _selectedShop = ref.watch(pickedShop.state).state;

//     return StreamBuilder<List<KitchenElement>>(
//         stream: ref.read(databaseProvider).kitchenElementsStream(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             _list = snapshot.data!;
//           }
//           return Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(6),
//               color: AppConstants.whiteOpacity,
//             ),
//             width: 240.0,
//             height: 45,
//             child: DropdownButtonHideUnderline(
//               child: ButtonTheme(
//                 alignedDropdown: true,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: DropdownButton<KitchenElement>(
//                   elevation: 4,
//                   iconSize: 30,
//                   underline: Divider(
//                     height: 2,
//                     color: Theme.of(context).colorScheme.secondary,
//                   ),
//                   icon: Icon(Icons.arrow_drop_down),
//                   isExpanded: false,
//                   hint: Text(
//                     "Select Kitchen",
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.subtitle2,
//                   ),
//                   value: ref.watch(kitchenElementProvider),
//                   onChanged: (value) {
//                     onSelected(value!);
//                     ref.read(kitchenElementProvider.state).state = value;
//                   },
//                   items: [
//                     for (var i = 0; i < _list.length; i++)
//                       DropdownMenuItem<KitchenElement>(
//                         value: _list[i],
//                         child: Container(
//                           width: 100,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 8.0, right: 8),
//                             child: new Text(
//                               _list[i].title.toString(),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }
