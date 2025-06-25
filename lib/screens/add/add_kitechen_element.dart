import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/blocs/kitchenelementbloc/kitchen_element_bloc.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../models/kitchen/kitchen_element.dart';
import '../../repository/database_operations.dart';
import '../tabs/kitchen_element_detailed.dart';

class AddKitchenElement extends ConsumerStatefulWidget {
  final KitchenElementModel? kitchenElement;

  AddKitchenElement({this.kitchenElement});

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddKitchenElement> {
  final GlobalKey<FormState> _formKeyTitle = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyCat = GlobalKey<FormState>();
  final TextEditingController _elementCategoryController =
      TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();

  bool _canSave = false;
  void clear() {
    _elementCategoryController.clear();
    _itemNameController.clear();
  }

  void _updatefeilds() {
    if (widget.kitchenElement != null) {
      _itemNameController.text = widget.kitchenElement!.title.toString();
      _elementCategoryController.text =
          widget.kitchenElement!.category.toString();
      _availability = widget.kitchenElement!.availability!;
      _priorityRating = widget.kitchenElement!.priority!;
    }
  }

  @override
  void initState() {
    _updatefeilds();
    _canSave = _itemNameController.text.isNotEmpty;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ignore: unused_field
  List<KitchenElementModel> _kitchenElements = [];
  double _priorityRating = 1;
  double _availability = 1;

  @override
  Widget build(BuildContext context) {
    // final logger = Logger();
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
        centerWidget: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  KitchenElementBloc(GetIt.I<DatabaseOperations>())
                    ..add(GetKitchenElementsEvent()),
            ),
          ],
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
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
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                widget.kitchenElement != null ? "تعديل المادة" : "اضافة مادة",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: BlocBuilder<KitchenElementBloc, KitchenElementState>(
                  builder: (context, snapshot) {
                if (snapshot.kitchenElements.isNotEmpty) {
                  _kitchenElements = snapshot.kitchenElements;
                }
                return SizedBox(
                  height: 500,
                  //width: 200,
                  child: BluredContainer(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildTitle(context),
                        // _buildKitchenItemName(),
                        _buildElementName(context),
                        _buildPriority(context),
                        _buildDivider(),
                        _buildAvailability(context),
                        SizedBox(height: 40),
                        _buildSave(context)
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ));
  }

  Padding _buildTitle(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20, bottom: 8),
        child: Text('Add Kitchen Element',
            style: Theme.of(context).textTheme.displaySmall));
  }

  Padding _buildDivider() {
    return Padding(
      padding: EdgeInsets.only(top: 18.0, bottom: 18),
      child: Divider(
        height: 3,
        indent: 12,
        color: Colors.amber,
        endIndent: 12,
      ),
    );
  }

  _buildSave(BuildContext context) {
    final bloc = KitchenElementBloc(GetIt.I<DatabaseOperations>());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 120,
          child: ElevatedButton(
              child: Text(
                'Cancel',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: MThemeData.raisedButtonStyleCancel),
        ),
        Container(
          width: 120,
          child: ElevatedButton(
              child: Text(
                widget.kitchenElement == null ? 'Save' : 'Update',
              ),
              onPressed: !_canSave
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Saving...'),
                      ));

                      widget.kitchenElement == null
                          ? _save(bloc)
                          : _update(bloc);
                    },
              style: MThemeData.raisedButtonStyleSave),
        ),
      ],
    );
  }

  Padding _buildAvailability(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Availability', style: Theme.of(context).textTheme.bodyLarge),
          Availibility(
            initialValue: _availability,
            onChanged: (value) {
              setState(() {
                _availability = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Padding _buildPriority(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text('Priority', style: Theme.of(context).textTheme.bodyLarge),
          ),
          PiorityRatingWidget(
            initialRating: _priorityRating,
            onRatingChanged: (double rating) {
              setState(() {
                _priorityRating = rating;
              });
            },
          ),
        ],
      ),
    );
  }

  Padding _buildElementName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 50,
        child: Form(
          key: _formKeyTitle,
          child: TextField(
            textAlign: TextAlign.center,
            controller: _itemNameController,
            style: Theme.of(context).textTheme.titleLarge,
            onChanged: (x) => setState(() {
              _canSave = true;
            }),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.shopping_basket_outlined,
                color: Color.fromARGB(117, 212, 211, 211),
              ),
              suffix: IconButton(
                icon: Icon(
                  Icons.clear_outlined,
                  size: 18,
                ),
                onPressed: () {
                  _itemNameController.clear();
                },
              ),
              hintText: 'element name',
              hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey,
                  ),

              fillColor: AppConstants.whiteOpacity,
              filled: true,
              contentPadding: EdgeInsets.only(top: 4, right: 4, left: 4),
              // labelText: 'Name',
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildKitchenItemName() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Form(
  //       key: _formKeyCat,
  //       child: SizedBox(
  //         height: 50,
  //         child: TypeAheadField<KitchenElementModel>(
  //           // noItemsFoundBuilder: (context) => Text('No Items Found'),
  //           autoFlipDirection: true,
  //           // minCharsForSuggestions: 2,
  //           direction: VerticalDirection.up,
  //           // hideSuggestionsOnKeyboardHide: true,
  //           decorationBuilder: TextFieldConfiguration(
  //             onChanged: (x) => setState(() {
  //               _canSave = true;
  //             }),
  //             controller: _elementCategoryController,
  //             autofocus: true,
  //             textAlign: TextAlign.center,
  //             style: Theme.of(context).textTheme.bodyMedium,
  //             decoration: InputDecoration(
  //               contentPadding: EdgeInsets.only(top: 4, right: 4, left: 4),
  //               fillColor: AppConstants.whiteOpacity,
  //               filled: true,
  //               hintText: 'title',
  //               //alignLabelWithHint: true,

  //               prefixIcon: Icon(
  //                 Icons.category,
  //                 color: Color.fromARGB(117, 212, 211, 211),
  //               ),
  //               suffix: IconButton(
  //                 icon: Icon(
  //                   Icons.clear_outlined,
  //                   size: 18,
  //                 ),
  //                 onPressed: () {
  //                   setState(() {
  //                     _elementCategoryController.clear();
  //                   });
  //                 },
  //               ),
  //               // border: OutlineInputBorder(),
  //             ),
  //           ),
  //           suggestionsCallback: (pattern) {
  //             return _kitchenElements
  //                 .where((item) => item.title
  //                     .toLowerCase()
  //                     .startsWith(pattern.toLowerCase()))
  //                 .toList(growable: true);
  //           },
  //           itemBuilder: (context, suggestion) {
  //             return Container(
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(20),
  //                   color: AppConstants.whiteOpacity,
  //                 ),
  //                 height: 40,
  //                 width: 100,
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                     suggestion.title,
  //                     textAlign: TextAlign.center,
  //                     style: Theme.of(context).textTheme.bodyLarge,
  //                   ),
  //                 ));
  //           },
  //           onSelected: (suggestion) {
  //             _elementCategoryController.text = suggestion.title;
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /// save the kitchen element to the database
  void _save(bloc) {
    final kitchenElement = KitchenElementModel(
      title: _itemNameController.text.trim(),
      priority: _priorityRating,
      availability: _availability,
      category: _elementCategoryController.text.trim(),
    );
    if (_formKeyTitle.currentState!.validate() &&
        _formKeyCat.currentState!.validate()) {
      setState(() {
        _canSave = false;
      });

      bloc.add(AddKitchenElementEvent(kitchenElement: kitchenElement));
      Navigator.pop(context);
    }
  }

  /// update the kitchen element to the database
  void _update(bloc) {
    final kitchenElement = KitchenElementModel(
      id: widget.kitchenElement?.id,
      title: _itemNameController.text.trim(),
      priority: _priorityRating,
      availability: _availability,
      category: _elementCategoryController.text.trim(),
    );
    if (_formKeyTitle.currentState!.validate() &&
        _formKeyCat.currentState!.validate()) {
      setState(() {
        _canSave = false;
      });
      bloc.add(UpdateKitchenElementEvent(kitchenElement: kitchenElement));

      Navigator.of(context).pop();
    }
  }
}
