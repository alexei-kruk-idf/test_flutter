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
    // TODO: Исправить
    this.indicatorActiveColor,
    this.indicatorInactiveColor = Colors.grey,
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
    required this.useButtonDirection,
    this.splashRadiusButtonDirection = 24,
    this.iconSizeButtonDirection = 24,
    // TODO: Исправить
    this.activeColorButtonDirection = const Color.fromRGBO(232, 25, 75, 1),
    this.inactiveColorButtonDirection = const Color.fromRGBO(232, 25, 75, 0.3),
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

  //
  final double radiusActiveIndicator;

  //
  final double radiusInactiveIndicator;

  final double indicatorSpacing;

  final double indicatorRunSpacing;

  final bool useIndicator;

  final bool useCounter;

  final double widthCounter;

  final double heightCounter;

  final bool useButtonDirection;

  final double splashRadiusButtonDirection;

  final double iconSizeButtonDirection;

  final Color activeColorButtonDirection;

  final Color inactiveColorButtonDirection;

  //  : 24,
  //                         iconSize: 24,
  //                         onPressed: _goPreviousPage,
  //                         icon: Icon(Icons.navigate_before,
  //                             color: _currentPageNotifier.value == 0 &&
  //                                     !widget.isLoop
  //                                 ? whiteRed
  //                                 : red),

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
      index + widget.initialPage,
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
      child: Stack(
        children: [
          //Counter
          widget.useCounter
              ? ValueListenableBuilder<int>(
                  valueListenable: _currentPageNotifier,
                  builder: (context, value, child) {
                    return Container(
                      width: widget.widthCounter,
                      height: widget.heightCounter,
                      decoration: BoxDecoration(
                        color: widget.activeColorButtonDirection,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          (_currentPageNotifier.value + 1).toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox(),
          Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Button previous page
                    widget.useButtonDirection
                        ? ValueListenableBuilder<int>(
                            valueListenable: _currentPageNotifier,
                            builder: (context, value, child) {
                              return IconButton(
                                splashRadius: 24,
                                iconSize: 24,
                                onPressed: _goPreviousPage,
                                icon: Icon(Icons.navigate_before,
                                    color: _currentPageNotifier.value == 0 &&
                                            !widget.isLoop
                                        ? widget.inactiveColorButtonDirection
                                        : widget.activeColorButtonDirection),
                              );
                            },
                          )
                        : SizedBox(),
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
                        itemCount:
                            widget.isLoop ? null : widget.children.length,
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
                                splashRadius: 24,
                                iconSize: 24,
                                onPressed: _goNextPage,
                                icon: Icon(Icons.navigate_next,
                                    color: _currentPageNotifier.value ==
                                                widget.children.length - 1 &&
                                            !widget.isLoop
                                        ? widget.inactiveColorButtonDirection
                                        : widget.activeColorButtonDirection),
                              );
                            },
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
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
                          radiusInactiveIndicator:
                              widget.radiusInactiveIndicator,
                          indicatorRunSpacing: widget.indicatorRunSpacing,
                          indicatorSpacing: widget.indicatorSpacing,
                        );
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
