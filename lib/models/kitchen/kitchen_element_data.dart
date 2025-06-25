import 'package:lkarnet/components.dart';

import 'kitchen_element.dart';
import 'kitchen_item.dart';

class KitchenElementsData {
  List<KitchenElementModel> kitchenElementList = [];
  late List<KitchenItemModel> kitchenItems;
  KitchenElementsData(
      {required this.kitchenElementList, required this.kitchenItems});

  // get a list of distinct categories
  List<String> get distinctCategories {
    List<String> categories = [];
    for (var i = 0; i < kitchenElementList.length; i++) {
      categories.add(kitchenElementList[i].category!);
    }
    return categories.toSet().toList();
  }

// get all KittchenElementDataModel
  List<KitchenElementDataModel> get allKitchenElementData {
    List<KitchenElementDataModel> allKitchenElements = [];
    for (var i = 0; i < kitchenElementList.length; i++) {
      allKitchenElements.add(KitchenElementDataModel(
          kitchenElement: kitchenElementList[i],
          kitchenItemList: kitchenItems));
    }
    return allKitchenElements;
  }

// get a list of all unavaliable elements
  List<KitchenElementDataModel> get unavaliableElements {
    List<KitchenElementDataModel> _unavaliableElements = [];
    for (var i = 0; i < allKitchenElementData.length; i++) {
      if (!allKitchenElementData[i].isAvailable) {
        _unavaliableElements.add(allKitchenElementData[i]);
      }
    }
    return _unavaliableElements;
  }

// get a list of all avaliable elements
  List<KitchenElementDataModel> get avaliableElements {
    List<KitchenElementDataModel> _avaliableElements = [];
    for (var i = 0; i < allKitchenElementData.length; i++) {
      if (allKitchenElementData[i].isAvailable) {
        _avaliableElements.add(allKitchenElementData[i]);
      }
    }
    return _avaliableElements;
  }

  // get a list of scaresElements
  List<ScarceElements> get scaresElements {
    List<ScarceElements> _scaresElements = [];
    for (var i = 0; i < allKitchenElementData.length; i++) {
      _scaresElements.add(ScarceElements(allKitchenElementData[i]));
    }
    return _scaresElements;
  }

  // get a list of tagged elements
  List<TaggedKitchenElementDataModel> get taggedsingleKitchenElementData {
    List<TaggedKitchenElementDataModel> _kitchenElements = [];
    for (var i = 0; i < distinctCategories.length; i++) {
      for (var i = 0; i < allKitchenElementData.length; i++) {
        if (allKitchenElementData[i].kitchenElement.category ==
            distinctCategories[i]) {
          _kitchenElements.add(
            TaggedKitchenElementDataModel(
              tag: distinctCategories[i],
              kittchenElementDataModel: allKitchenElementData[i],
            ),
          );
        }
      }
    }
    return _kitchenElements;
  }
}

class TaggedKitchenElementDataModel {
  String tag;
  KitchenElementDataModel kittchenElementDataModel;
  TaggedKitchenElementDataModel(
      {required this.tag, required this.kittchenElementDataModel});
}

class KitchenElementDataModel {
  late KitchenElementModel kitchenElement;
  List<KitchenItemModel> kitchenItems = [];
  KitchenElementDataModel(
      {required this.kitchenElement,
      required List<KitchenItemModel> kitchenItemList}) {
    for (var i = 0; i < kitchenItemList.length; i++) {
      if (kitchenItemList[i].kitchenElementId == kitchenElement.id) {
        kitchenItems.add(kitchenItemList[i]);
      }
    }
    // kitchenItems = kitchenItemList
    //     .where((element) => element.kitchenElementId == kitchenElement.id)
    //     .toList();
  }

  List<KitchenItemModel> get sortedItems {
    kitchenItems.sort((a, b) {
      if (a.dateExpired != null && b.dateExpired != null) {
        return a.dateExpired!.compareTo(b.dateExpired!);
      }
      return 0; //a.dateBought.compareTo(b.dateBought);
    });
    return kitchenItems;
  }

// get isNotAvailable
  bool get isAvailable {
    return kitchenElement.availability != 0;
  }

// get isScares
// get the number of times the element is bought
  int get timesBought {
    if (kitchenItems.isEmpty)
      return 0;
    else
      return kitchenItems.length;
  }

// get the date of the last item
  String get lastTimeBought {
    return kitchenItems.isEmpty
        ? 'Not bought yet'
        : kitchenItems.first.dateBought.ddmmyyyy();
  }

// get time expired of the last item
  String get timeExpired {
    return kitchenItems.isEmpty || kitchenItems.first.dateExpired == null
        ? 'Still in stock'
        : kitchenItems.first.dateExpired!.ddmmyyyy();
  }

// get last item was bought
  KitchenItemModel? get lastItemBought {
    // if items is empty return null
    if (kitchenItems.isEmpty) return null;
    // get last item
    final lastItem = kitchenItems.last;
    // if last item is not bought return null
    // return last item
    return lastItem;
  }

// get the total price of all items
  double get totalPrice {
    return kitchenItems.isEmpty
        ? 0
        : kitchenItems.map((e) => e.itemPrice).reduce((a, b) => a + b);
  }
}

class ScarceElements {
  List<KitchenElementDataModel> _scaresElements = [];
  ScarceElements(KitchenElementDataModel kitchenElementDataModel) {
    _scaresElements.add(kitchenElementDataModel);
  }
  List<KitchenElementDataModel> get scaresElements {
    _scaresElements = [];
    for (var i = 0; i < _scaresElements.length; i++) {
      if (_scaresElements[i].isAvailable) {
        _scaresElements.add(_scaresElements[i]);
      }
    }
    return _scaresElements;
  }
  // get the total price of all scare elements
}
