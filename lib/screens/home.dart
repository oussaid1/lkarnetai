import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/blocs/payments/payments_bloc.dart';
import 'package:lkarnet/components.dart';

import 'package:lkarnet/screens/dash/dashboard.dart';
import 'package:lkarnet/screens/settings/settings.dart';
import '../blocs/datefilterbloc/date_filter_bloc.dart';
import '../blocs/itemsbloc/items_bloc.dart';
import '../blocs/kitchenelementbloc/kitchen_element_bloc.dart';
import '../blocs/kitchenitembloc/kitchen_item_bloc.dart';
import '../blocs/shopsbloc/shops_bloc.dart';
import '../cubits/userCubit/usermodel_cubit.dart';
import '../models/item/items_filtered.dart';
import '../repository/database_operations.dart';
import 'shopdetailsmain.dart';
import 'stats/stats_all.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ItemsBloc(databaseOperations: GetIt.I<DatabaseOperations>())
                ..add(GetItemsEvent()),
        ),
        BlocProvider(
          create: (context) =>
              ShopsBloc(GetIt.I<DatabaseOperations>())..add(GetShopsEvent()),
        ),
        BlocProvider(
          create: (context) => PaymentsBloc(GetIt.I<DatabaseOperations>())
            ..add(GetPaymentsEvent()),
        ),
        //////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////
        /// Kitchen Blocs
        /// //////////////////////////////////////////////////////

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

        /// userCubit
        BlocProvider(
          create: (context) => UserModelCubit()..loadUser(),
        ),
      ],
      child: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  HomeWidget({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _selectedPageIndex = 0;
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
      centerWidget: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: ExpandableFab(
          distance: 0,
          children: [
            AddStuffWidget(
              context: context,
            )
          ],
        ),
        bottomNavigationBar:
            buildNavigationBar(context, _selectedPageIndex, _pageController),
        backgroundColor: Colors.transparent,
        body: buildPageView(
          _pageController,
        ),
      ),
    );
  }

  buildPageView(
    PageController _pageController,
  ) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _selectedPageIndex = index;
              });
            },
            children: [
              DashBoardPage(),
              //DashBoardTab(),
              ShopDetailsMain(),
              // ListTab(),
              //ShopsList(),
              //   KitchenStockHomeView(),
              StatsAll(),
              SettingsPage(),
            ],
          ),
        ),
      ],
    );
  }

  buildNavigationBar(
      context, int _selectedPageIndex, PageController _pageController) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedPageIndex,
      elevation: 8,
      onTap: (index) {
        _pageController.jumpToPage(index);
        setState(() {
          _selectedPageIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
          backgroundColor: Color.fromARGB(137, 101, 179, 224),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.dashboard),
          label: 'Dashboard',
          backgroundColor: Color.fromARGB(144, 224, 126, 101),
        ),
        // BottomNavigationBarItem(
        //   icon: const Icon(Icons.kitchen),
        //   label: 'Kitchen',
        //   backgroundColor: Color.fromARGB(136, 224, 101, 121),
        // ),
        const BottomNavigationBarItem(
          icon: const Icon(Icons.add_chart),
          label: 'Stats',
          backgroundColor: Color.fromARGB(123, 224, 101, 183),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Color.fromARGB(160, 148, 101, 224),
        ),
      ],
    );
  }
}
