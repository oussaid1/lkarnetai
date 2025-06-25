import 'package:flutter/material.dart';

import '../../components.dart';
import '../../models/kitchen/kitchen_element_data.dart';
import '../../widgets/price_curency_widget.dart';
import '../kitchen_stock.dart';
import '../tabs/kitchen_element_detailed.dart';

class UnAvailiableElements extends ConsumerStatefulWidget {
  final List<KitchenElementDataModel>? elementData;
  UnAvailiableElements({
    Key? key,
    this.elementData,
  }) : super(key: key);
  @override
  ConsumerState<UnAvailiableElements> createState() => _ItemsListState();
}

class _ItemsListState extends ConsumerState<UnAvailiableElements> {
  double _total = 0;
  double _count = 0;
  @override
  void initState() {
    if (widget.elementData != null) {
      widget.elementData!.forEach((element) {
        _total += element.totalPrice;
        _count += element.kitchenItems.length;
      });
    }
    super.initState();
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
      centerWidget: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [],
          leading: Icon(Icons.menu, color: Colors.black),
          title: Text(
            'Out of Stock',
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Container(
              //   //  margin: EdgeInsets.symmetric(vertical: 10),
              //   width: 400,
              //   height: 140,
              //   decoration: BoxDecoration(
              //     color: AppConstants.whiteOpacity,
              //     borderRadius: BorderRadius.circular(AppConstants.radius),
              //   ),
              //   child: ,
              // ),
              buildTopWidget(total: _total, count: _count),
              const SizedBox(height: 20),
              BluredContainer(
                margin: EdgeInsets.only(top: 10, left: 4, right: 4, bottom: 8),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  // height: 440,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                    itemCount: widget.elementData!.length,
                    itemBuilder: (context, index) {
                      final KitchenElementDataModel kitchenElement =
                          widget.elementData![index];
                      return KitchenItemSquareTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KitchenElementDetailsScreen(
                                kitchenElement: kitchenElement,
                              ),
                            ),
                          );
                        },
                        kitchenElement: kitchenElement,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildTopWidget({double total = 0, double count = 0}) {
    return BluredContainer(
      width: 390,
      height: 130,
      child: SizedBox(
        width: 390,
        height: 130,
        child: BluredContainer(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //

                    Text(
                      'To be bought',
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                    ),
                    Spacer(),
                    PriceNumberZone(
                      right: const SizedBox.shrink(),
                      withDollarSign: true,
                      price: total,
                      style: Theme.of(context).textTheme.displayMedium!,
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'with a total of',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          // color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                    ),
                    Spacer(),
                    PriceNumberZone(
                      right: const SizedBox.shrink(),
                      withDollarSign: false,
                      price: count,
                      style: Theme.of(context).textTheme.bodyMedium!,
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
