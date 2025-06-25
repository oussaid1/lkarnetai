import '../components.dart';
import 'package:flutter/material.dart';

class PriceNumberZone extends StatelessWidget {
  const PriceNumberZone({
    Key? key,
    required this.price,
    this.style = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color.fromARGB(255, 24, 23, 23),
    ),
    this.withDollarSign = true,
    this.right,
  }) : super(key: key);
  final bool withDollarSign;
  final double price;
  final TextStyle? style;
  final Widget? right;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${price.toPrecision(2)} ',
            style: style,
          ),
          withDollarSign
              ? Consumer(builder: (context, ref, _) {
                  final _currency = ref.watch(currencyProvider.notifier);
                  return Text(
                    _currency.state.toString(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 8,
                        ),
                  );
                })
              : const SizedBox.shrink(),
          right ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

final currencyProvider = StateProvider<String>((ref) {
  return 'ريال';
});
