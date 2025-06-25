import 'package:flutter/material.dart';
import '../../components.dart';
import '../tabs/kitchen_element_detailed.dart';

class UpdateKitchenElement extends ConsumerStatefulWidget {
  const UpdateKitchenElement(
      {Key? key,
      required this.onUpdate,
      this.radius = 35,
      this.initialValue = 0})
      : super(key: key);
  final Function(double) onUpdate;
  final double radius;
  final double initialValue;
  @override
  ConsumerState<UpdateKitchenElement> createState() =>
      _UpdateKitchenElementState();
}

class _UpdateKitchenElementState extends ConsumerState<UpdateKitchenElement> {
  double _availability = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Availibility(
      initialValue: widget.initialValue,
      radius: widget.radius,
      // value: _availability,
      onChanged: (value) {
        setState(() {
          _availability = value;
        });

        widget.onUpdate(_availability);
      },
    );
  }
}
