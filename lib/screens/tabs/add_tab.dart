import 'package:flutter/material.dart';
import 'package:lkarnet/screens/add/add_category.dart';
import 'package:lkarnet/screens/add/add_item.dart';
import 'package:lkarnet/screens/add/add_payment.dart';
import 'package:lkarnet/screens/add/add_shop.dart';

class AddTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          flexibleSpace: TabBar(
            indicatorPadding: EdgeInsets.only(left: 8),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
                color: Theme.of(context).colorScheme.secondary),
            labelColor: Colors.white,
            unselectedLabelColor: Theme.of(context).dividerColor,
            tabs: [
              Tab(text: '+shop'),
              Tab(text: '+item'),
              Tab(text: '+category'),
              Tab(text: '+payment'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'addFabOuss',
          onPressed: () {
            _showDialog(context);
          },
          child: Icon(Icons.add_shopping_cart),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            AddShop(),
            AddItem(),
            AddCategory(),
            AddPayment(),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 500,
            child: SizedBox.expand(child: AddPayment()),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}
