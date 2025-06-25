import 'package:flutter/material.dart';
import '../components.dart';
import '../models/shop/shops_data.dart';
import 'price_curency_widget.dart';

class ShopSquareTile extends StatelessWidget {
  const ShopSquareTile({
    Key? key,
    required this.onTap,
    required this.shopData,
  }) : super(key: key);

  final VoidCallback? onTap;
  final ShopData shopData;

  Color calculateProgressColor(double progress) {
    // Example: Interpolating between red (0.0) and green (1.0) based on progress
    return Color.lerp(Colors.red, Colors.green, progress) ?? Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    calculateProgressColor(1);

    return GestureDetector(
      onTap: onTap,
      child: BluredContainer(
        height: 140,
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    '${shopData.shop.shopName}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ],
            ),
            // PriceNumberZone(
            //   right: const SizedBox.shrink(),
            //   withDollarSign: true,
            //   price: shopData.shopDataCalculations.itemsSumAfterPayment,
            //   style: Theme.of(context).textTheme.headline3!.copyWith(
            //         color: AppConstants.hintColor,
            //       ),
            // ),
            //const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 50,
              width: 158,
              decoration: BoxDecoration(
                // color: progressColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '${shopData.shop.dailyLimit}',
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: <TextSpan>[
                          TextSpan(
                            text: ' => ',
                          ),
                          TextSpan(
                            text: '${shopData.shop.limit}',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_circle_up_sharp, color: Colors.green),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// this is used to create the shop data card that will be displayed in the shopdetailsmain section

class SimpleShopSquareTile extends StatelessWidget {
  const SimpleShopSquareTile({
    Key? key,
    required this.onTap,
    required this.shopData,
  }) : super(key: key);

  final VoidCallback? onTap;
  final ShopData shopData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BluredContainer(
        height: 80,
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    '${shopData.shop.shopName}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ],
            ),
            PriceNumberZone(
              right: const SizedBox.shrink(),
              withDollarSign: true,
              price: shopData.shopDataCalculations.itemsSumAfterPayment,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppConstants.hintColor,
                  ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
