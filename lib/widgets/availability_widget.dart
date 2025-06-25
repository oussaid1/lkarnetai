import 'package:flutter/material.dart';

import '../components.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({
    Key? key,
    required this.availability,
  }) : super(key: key);
  final double availability;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: SfRadialGauge(
        // backgroundColor: Colors.white,
        axes: <RadialAxis>[
          RadialAxis(
            labelFormat: '$availability',
            labelOffset: 15,
            labelsPosition: ElementsPosition.inside,
            axisLabelStyle:
                GaugeTextStyle(fontSize: 8, fontWeight: FontWeight.bold),
            minimum: 0,
            maximum: 10,
            showLabels: true,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            axisLineStyle: AxisLineStyle(
              thickness: 0.05,
              color: Color.fromARGB(38, 255, 255, 255),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                color: Color.fromARGB(99, 255, 255, 255),
                value: availability,
                width: 0.95,
                pointerOffset: 0.05,
                sizeUnit: GaugeSizeUnit.factor,
              )
            ],
          )
        ],
      ),
    );
  }
}
