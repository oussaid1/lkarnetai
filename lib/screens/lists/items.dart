import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:flutter/material.dart';
import 'package:lkarnet/repository/database_operations.dart';
import 'package:lkarnet/widgets/search_by_widget.dart';
import '../../blocs/itemsbloc/items_bloc.dart';
import '../../widgets/item_listtile.dart';

class ItemsList extends StatefulWidget {
  final List<ItemModel> lista;
  ItemsList({
    Key? key,
    required this.lista,
  }) : super(key: key);
  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  String _filterPattern = '';
  String _filterType = '';
  List<ItemModel> _filteredList() {
    List<ItemModel> lista = widget.lista;
    switch (_filterType) {
      case "name":
        return lista
            .where((item) => item.itemName
                .toLowerCase()
                .contains(_filterPattern.toLowerCase()))
            .toList();
      case "price":
        return lista
            .where((item) => item.itemPrice.toString().contains(_filterPattern))
            .toList();
      case "category":
        return lista
            .where((item) => item.besoinTitle!
                .toLowerCase()
                .contains(_filterPattern.toLowerCase()))
            .toList();
      case "shop":
        return lista
            .where((item) => item.shopName
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
      centerWidget: BlocProvider(
        create: (context) =>
            ItemsBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
        child: Scaffold(
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),
                SearchByWidget(
                  withCategory: true,
                  listOfCategories: ['name', 'price', 'category', 'shop'],
                  onChanged: (catg, searchText) {
                    setState(() {
                      _filterPattern = searchText;
                      _filterType = catg;
                    });
                  },
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: BluredContainer(
                    margin:
                        EdgeInsets.only(top: 10, left: 4, right: 4, bottom: 8),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          _filteredList().length, // _shopsDataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        ItemModel item = _filteredList()[index];
                        return ItemTileWidget(
                          withActions: true,
                          item: item,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
