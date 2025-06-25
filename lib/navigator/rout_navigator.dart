import 'package:flutter/material.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/root.dart';
import 'package:lkarnet/screens/add/add_item.dart';
import 'package:lkarnet/screens/add/add_shop.dart';
import 'package:lkarnet/screens/auth/login.dart';
import 'package:lkarnet/screens/auth/signup.dart';
import 'package:lkarnet/screens/home.dart';
import 'package:lkarnet/screens/splash.dart';

class RouteGenerator {
  static const String root = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String splash = '/splash';
  static const String error = '/error';
  static const String notFound = '*';
  static const String payment = '/payment';
  static const String dashboard = '/dashboard';
  static const String kitchen = '/kitchen';
  static const String stats = '/stats';
  static const String settings = '/settings';

  /// //////////////////////////////////////////////////////
  /// fragments
  static const String shopDetails = '/shopDetails';
  static const String kitchenStock = '/kitchenStock';
  static const String statsAll = '/statsAll';
  static const String shopDetailsMain = '/shopDetailsMain';
  static const String addKitchenElement = '/addKitchenElement';
  static const String addKitchenItem = '/addKitchenItem';
  ////////////////////////////////////////////////////////
  /// Crud operations /////////////////////////////////////
  static const String addItem = '/addItem';
  static const String editItem = '/editItem';
  static const String addShop = '/addShop';
  static const String editShop = '/edit_shop';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case root:
        return MaterialPageRoute(builder: (_) => SplashPage());
      ////////////////////////////////////////////////////////////////
      ///mainViews////////////////////////////////////////////////////
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      ////////////////////////////////////////////////////////////////
      /// fragments////////////////////////////////////////////////////
      case addItem:
        return MaterialPageRoute(builder: (_) => AddItem());
      case editItem:
        return MaterialPageRoute(
            builder: (_) => AddItem(
                  item: args as ItemModel,
                ));
      case editShop:
        return MaterialPageRoute(
            builder: (_) => AddShop(shop: args as ShopModel));

      ////////////////////////////////////////////////////////////////
      ///error handling////////////////////////////////////////////////////
      case error:
        return _errorRoute();
      default:
        return MaterialPageRoute(builder: (_) => Root());
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
