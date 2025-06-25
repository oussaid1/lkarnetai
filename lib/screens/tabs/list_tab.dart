import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/screens/lists/items.dart';
import 'package:lkarnet/screens/lists/payments.dart';
import 'package:lkarnet/screens/lists/shops.dart';
import 'package:lkarnet/widgets/glasswidget.dart';

class ListTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: BluredContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Container(),
            leadingWidth: 10,
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
            ],
            bottom: TabBar(
              overlayColor: WidgetStateColor.resolveWith(
                  (Set<WidgetState> states) =>
                      states.contains(WidgetState.selected)
                          ? Colors.white
                          : Colors.transparent),
              indicatorColor: Colors.white,
              unselectedLabelColor: Theme.of(context).dividerColor,
              tabs: [
                Tab(text: 'Items'),
                Tab(text: 'shops'),
                Tab(text: 'payments'),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              ItemsList(lista: []),
              ShopsList(),
              ViewPaymentsList(),
            ],
          ),
        ),
      ),
    );
  }
}
