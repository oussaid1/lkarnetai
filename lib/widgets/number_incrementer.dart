import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../components.dart';

class NumberIncrementer extends StatefulWidget {
  final Function(double) onDecrement;
  final Function(double) onIncrement;
  final double initialValue;

  NumberIncrementer({
    Key? key,
    required this.onDecrement,
    required this.onIncrement,
    required this.initialValue,
  }) : super(key: key);

  @override
  _NumberIncrementerState createState() => _NumberIncrementerState();
}

class _NumberIncrementerState extends State<NumberIncrementer> {
  late double _quantity;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _quantity = widget.initialValue;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Card(
          color: AppConstants.whiteOpacity,
          child: Container(
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(CupertinoIcons.minus_circle),
                  onPressed: () {
                    setState(() {
                      if (_quantity > 0.5) {
                        _quantity -= 0.5;
                        widget.onDecrement(_quantity);
                      }
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(_quantity.toString()),
                ),
                IconButton(
                  icon: Icon(CupertinoIcons.plus_circle),
                  onPressed: () {
                    setState(() {
                      _quantity += 0.5;
                      widget.onIncrement(_quantity);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
