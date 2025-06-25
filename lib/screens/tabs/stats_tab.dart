import 'package:flutter/material.dart';
import 'package:lkarnet/screens/stats/stats_all.dart';
import 'package:lkarnet/widgets/glasswidget.dart';

class StatsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      initialIndex: 0,
      child: BluredContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            leading: Container(),
            flexibleSpace: TabBar(
              unselectedLabelColor: Theme.of(context).dividerColor,
              tabs: [
                Tab(text: 'All'),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              StatsAll(),
            ],
          ),
        ),
      ),
    );
  }
}
