import 'package:flutter/material.dart';

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    Key? key,
    required this.count,
    required this.currentIndex,
    required this.indicatorActiveColor,
    required this.indicatorInactiveColor,
    required this.radiusActiveIndicator,
    required this.radiusInactiveIndicator,
    required this.indicatorSpacing,
    required this.indicatorRunSpacing,
  }) : super(key: key);

  final int count;
  final int currentIndex;
  final Color? indicatorActiveColor;
  final Color? indicatorInactiveColor;
  final double radiusActiveIndicator;
  final double radiusInactiveIndicator;
  final double indicatorSpacing;
  final double indicatorRunSpacing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: List.generate(
        count,
        (index) {
          return CircleAvatar(
            radius: currentIndex == index
                ? radiusActiveIndicator
                : radiusInactiveIndicator,
            backgroundColor: currentIndex == index
                ? indicatorActiveColor
                : indicatorInactiveColor,
          );
        },
      ),
    );
  }
}
