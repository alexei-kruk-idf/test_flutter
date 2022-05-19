import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'carousel_indicator.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({
    Key? key,
    required this.children,
    this.width = double.infinity,
    this.height = 200,
    this.initialPage = 0,
    this.indicatorActiveColor,
    this.indicatorInactiveColor,
    this.offsetIndicator = 25,
    this.onPageChanged,
    this.autoPlayInterval,
    this.isLoop = false,
    required this.useIndicator,
    this.radiusActiveIndicator = 6,
    this.radiusInactiveIndicator = 4,
    this.indicatorSpacing = 4,
    this.indicatorRunSpacing = 4,
    required this.useCounter,
    this.widthCounter = 40,
    this.heightCounter = 40,
    this.textStyleCounter,
    this.colorCounter,
    required this.useButtonDirection,
    this.splashRadiusButtonDirection = 24,
    this.iconSizeButtonDirection = 24,
    this.activeColorButtonDirection,
    this.inactiveColorButtonDirection,
  }) : super(key: key);

  /// The widgets to display in the [CarouselWidget].
  ///
  /// Mainly intended for image widget, but other widgets can also be used.
  final List<Widget> children;

  /// Width of the [CarouselWidget].
  final double width;

  /// Height of the [CarouselWidget].
  final double height;

  /// The page to show when first creating the [CarouselWidget].
  final int initialPage;

  /// The color to paint the indicator.
  final Color? indicatorActiveColor;

  /// The color to paint behind th indicator.
  final Color? indicatorInactiveColor;

  // Radius of the active indicator
  final double radiusActiveIndicator;

  // Radius of the inactive indicator
  final double radiusInactiveIndicator;

  // Interval between indicators
  final double indicatorSpacing;

  // Start interval
  final double indicatorRunSpacing;

  // Use indicator
  final bool useIndicator;

  // Interval between the carousel and the indicator
  final double offsetIndicator;

  // Use counter
  final bool useCounter;

  // Width counter
  final double widthCounter;

  // Height counter
  final double heightCounter;

  // Style of text inside counter
  final TextStyle? textStyleCounter;

  // Color counter
  final Color? colorCounter;

  // Use the buttons that are on the sides
  final bool useButtonDirection;

  // Splash radius direction button
  final double splashRadiusButtonDirection;

  // Icon size direction button
  final double iconSizeButtonDirection;

  // Color of active button
  final Color? activeColorButtonDirection;

  // Color of inactive button
  final Color? inactiveColorButtonDirection;

  /// Called whenever the page in the center of the viewport changes.
  final ValueChanged<int>? onPageChanged;

  /// Auto scroll interval.
  ///
  /// Do not auto scroll when you enter null or 0.
  final int? autoPlayInterval;

  /// Loops back to first slide.
  final bool isLoop;

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final _currentPageNotifier = ValueNotifier<int>(0);
  late PageController _pageController;
  int _realPage = 10000;
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    _currentIndex = index;
    final int currentPage = _getRealIndex(
      _currentIndex + widget.initialPage,
      _realPage,
      widget.children.length,
    );
    _currentPageNotifier.value = currentPage;

    if (widget.onPageChanged != null) {
      widget.onPageChanged!(currentPage);
    }
  }

  void _autoPlayTimerStart() {
    Timer.periodic(
      Duration(milliseconds: widget.autoPlayInterval!),
      (timer) {
        _goNextPage();
      },
    );
  }

  void _goNextPage() {
    final int nextPage;
    if (widget.isLoop) {
      nextPage = _currentIndex += 1;
    } else if (_currentIndex < widget.children.length - 1) {
      nextPage = _currentIndex += 1;
    } else {
      return;
    }

    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }

  void _goPreviousPage() {
    final int previousPage;
    if (widget.isLoop) {
      previousPage = _currentIndex - 1;
    } else if (_currentIndex > 0) {
      previousPage = _currentIndex - 1;
    } else {
      return;
    }

    _pageController.animateToPage(
      previousPage,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }

  int _getRealIndex(int position, int base, int length) {
    final int offset = position - base;
    return _remainder(offset, length);
  }

  int _remainder(int input, int source) {
    if (source == 0) return 0;
    final int result = input % source;
    return result < 0 ? source + result : result;
  }

  @override
  void initState() {
    _realPage =
        widget.isLoop ? _realPage + widget.initialPage : widget.initialPage;

    _pageController = PageController(initialPage: _realPage);
    _currentPageNotifier.value = widget.initialPage;
    _currentIndex = _realPage;

    if (widget.autoPlayInterval != null && widget.autoPlayInterval != 0) {
      _autoPlayTimerStart();
    }

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          //  Counter
          widget.useCounter
              ? Align(
                  alignment: Alignment.topLeft,
                  child: ValueListenableBuilder<int>(
                    valueListenable: _currentPageNotifier,
                    builder: (context, value, child) {
                      return Container(
                        width: widget.widthCounter,
                        height: widget.heightCounter,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: widget.colorCounter,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          (_currentPageNotifier.value + 1).toString(),
                          style: widget.textStyleCounter,
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(),
          Expanded(
            child: Row(
              children: [
                // Button previous page
                widget.useButtonDirection
                    ? ValueListenableBuilder<int>(
                        valueListenable: _currentPageNotifier,
                        builder: (context, value, child) {
                          return IconButton(
                            splashRadius: widget.splashRadiusButtonDirection,
                            iconSize: widget.iconSizeButtonDirection,
                            onPressed: _goPreviousPage,
                            icon: Icon(
                              Icons.navigate_before,
                              color: _currentPageNotifier.value == 0 &&
                                      !widget.isLoop
                                  ? widget.inactiveColorButtonDirection
                                  : widget.activeColorButtonDirection,
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
                //  Carousel
                Expanded(
                  child: PageView.builder(
                    scrollBehavior: const ScrollBehavior().copyWith(
                      scrollbars: false,
                      overscroll: false,
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    onPageChanged: _onPageChanged,
                    itemCount: widget.isLoop ? null : widget.children.length,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      final int currentPage = _getRealIndex(
                        index + widget.initialPage,
                        _realPage,
                        widget.children.length,
                      );
                      return widget.children[currentPage];
                    },
                  ),
                ),
                // Button next page
                widget.useButtonDirection
                    ? ValueListenableBuilder<int>(
                        valueListenable: _currentPageNotifier,
                        builder: (context, value, child) {
                          return IconButton(
                            splashRadius: widget.splashRadiusButtonDirection,
                            iconSize: widget.iconSizeButtonDirection,
                            onPressed: _goNextPage,
                            icon: Icon(
                              Icons.navigate_next,
                              color: _currentPageNotifier.value ==
                                          widget.children.length - 1 &&
                                      !widget.isLoop
                                  ? widget.inactiveColorButtonDirection
                                  : widget.activeColorButtonDirection,
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          SizedBox(
            height: widget.offsetIndicator,
          ),
          // Bottom indicator
          widget.useIndicator
              ? ValueListenableBuilder<int>(
                  valueListenable: _currentPageNotifier,
                  builder: (context, value, child) {
                    return CarouselIndicator(
                      count: widget.children.length,
                      currentIndex: value,
                      indicatorActiveColor: widget.indicatorActiveColor,
                      indicatorInactiveColor: widget.indicatorInactiveColor,
                      radiusActiveIndicator: widget.radiusActiveIndicator,
                      radiusInactiveIndicator: widget.radiusInactiveIndicator,
                      indicatorRunSpacing: widget.indicatorRunSpacing,
                      indicatorSpacing: widget.indicatorSpacing,
                    );
                  },
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
