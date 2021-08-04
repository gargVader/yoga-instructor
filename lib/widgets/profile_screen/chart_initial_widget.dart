import 'package:flutter/material.dart';

class ChartInitialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final int paddingSide = (16 * 2);

    final double chartWidth = screenWidth - paddingSide;
    final double chartHeight = screenWidth * (3 / 4) - paddingSide;

    return Container(
      width: chartWidth,
      height: chartHeight,
    );
  }
}
