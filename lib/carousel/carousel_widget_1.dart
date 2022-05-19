// import 'dart:async';

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';

// import 'carousel_indicator.dart';

// class ImageSlideshowCopy extends StatefulWidget {
//   const ImageSlideshowCopy({
//     Key? key,
//     required this.children,
//     this.width = double.infinity,
//     this.height = 200,
//     this.initialPage = 0,
//     this.indicatorColor,
//     this.indicatorBackgroundColor = Colors.grey,
//     this.onPageChanged,
//     this.autoPlayInterval,
//     this.isLoop = false,
//   }) : super(key: key);

//   /// The widgets to display in the [ImageSlideshowCopy].
//   ///
//   /// Mainly intended for image widget, but other widgets can also be used.
//   final List<Widget> children;

//   /// Width of the [ImageSlideshowCopy].
//   final double width;

//   /// Height of the [ImageSlideshowCopy].
//   final double height;

//   /// The page to show when first creating the [ImageSlideshowCopy].
//   final int initialPage;

//   /// The color to paint the indicator.
//   final Color? indicatorColor;

//   /// The color to paint behind th indicator.
//   final Color? indicatorBackgroundColor;

//   /// Called whenever the page in the center of the viewport changes.
//   final ValueChanged<int>? onPageChanged;

//   /// Auto scroll interval.
//   ///
//   /// Do not auto scroll when you enter null or 0.
//   final int? autoPlayInterval;

//   /// Loops back to first slide.
//   final bool isLoop;

//   @override
//   _ImageSlideshowCopyState createState() => _ImageSlideshowCopyState();
// }

// class _ImageSlideshowCopyState extends State<ImageSlideshowCopy> {
//   final _currentPageNotifier = ValueNotifier<int>(0);
//   late PageController _pageController;

//   void _onPageChanged(int index) {
//     _currentPageNotifier.value = index % widget.children.length;
//     if (widget.onPageChanged != null) {
//       widget.onPageChanged!(_currentPageNotifier.value);
//     }
//   }

//   void _autoPlayTimerStart() {
//     Timer.periodic(
//       Duration(milliseconds: widget.autoPlayInterval!),
//       (timer) {
//         int nextPage = _nextPage;
//         if (_nextPage == -1) {
//           return;
//         }

//         // if (widget.isLoop) {
//         //   nextPage = _currentPageNotifier.value + 1;
//         // } else {
//         //   if (_currentPageNotifier.value < widget.children.length - 1) {
//         //     nextPage = _currentPageNotifier.value + 1;
//         //   } else {
//         //     return;
//         //   }
//         // }

//         if (_pageController.hasClients) {
//           _pageController.animateToPage(
//             nextPage,
//             duration: const Duration(milliseconds: 350),
//             curve: Curves.easeIn,
//           );
//         }
//       },
//     );
//   }

//   int get _nextPage {
//     if (_currentPageNotifier.value < widget.children.length - 1) {
//       return _currentPageNotifier.value + 1;
//     } else if (widget.isLoop) {
//       return 0;
//     } else {
//       return -1;
//     }
//   }

//   int get _previousPage {
//     if (_currentPageNotifier.value > 0) {
//       return _currentPageNotifier.value - 1;
//     } else if (widget.isLoop) {
//       return widget.children.length - 1;
//     } else {
//       return -1;
//     }
//   }

//   @override
//   void initState() {
//     _pageController = PageController(
//       initialPage: widget.initialPage,
//     );
//     _currentPageNotifier.value = widget.initialPage;

//     if (widget.autoPlayInterval != null && widget.autoPlayInterval != 0) {
//       _autoPlayTimerStart();
//     }

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   final red = Color.fromRGBO(232, 25, 75, 1);
//   final whiteRed = Color.fromRGBO(232, 25, 75, 0.3);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: widget.width,
//       height: widget.height,
//       child: Stack(
//         children: [
//           ValueListenableBuilder<int>(
//             valueListenable: _currentPageNotifier,
//             builder: (context, value, child) {
//               return Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: red,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Text(
//                     (_currentPageNotifier.value + 1).toString(),
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           Column(
//             children: [
//               Expanded(
//                 child: Row(
//                   children: [
//                     ValueListenableBuilder<int>(
//                       valueListenable: _currentPageNotifier,
//                       builder: (context, value, child) {
//                         return IconButton(
//                           splashRadius: 24,
//                           iconSize: 24,
//                           onPressed: () => _pageController.animateToPage(
//                             _previousPage,
//                             duration: Duration(milliseconds: 350),
//                             curve: Curves.easeIn,
//                           ),
//                           icon: Icon(Icons.navigate_before,
//                               color: _currentPageNotifier.value == 0 &&
//                                       !widget.isLoop
//                                   ? whiteRed
//                                   : red),
//                         );
//                       },
//                     ),
//                     Expanded(
//                       child: PageView.builder(
//                         scrollBehavior: const ScrollBehavior().copyWith(
//                           scrollbars: false,
//                           overscroll: false,
//                           dragDevices: {
//                             PointerDeviceKind.touch,
//                             PointerDeviceKind.mouse,
//                           },
//                         ),
//                         onPageChanged: _onPageChanged,
//                         itemCount: widget.isLoop
//                             ? null
//                             : widget.children.length, //widget.children.length,
//                         controller: _pageController,
//                         itemBuilder: (context, index) {
//                           final correctIndex = index % widget.children.length;
//                           return widget.children[correctIndex];
//                         },
//                       ),
//                     ),
//                     ValueListenableBuilder<int>(
//                       valueListenable: _currentPageNotifier,
//                       builder: (context, value, child) {
//                         return IconButton(
//                           splashRadius: 24,
//                           iconSize: 24,
//                           onPressed: () => _pageController.animateToPage(
//                             _nextPage,
//                             duration: Duration(milliseconds: 350),
//                             curve: Curves.easeIn,
//                           ),
//                           icon: Icon(Icons.navigate_next,
//                               color: _currentPageNotifier.value ==
//                                           widget.children.length - 1 &&
//                                       !widget.isLoop
//                                   ? whiteRed
//                                   : red),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               ValueListenableBuilder<int>(
//                 valueListenable: _currentPageNotifier,
//                 builder: (context, value, child) {
//                   return CarouselIndicator(
//                     count: widget.children.length,
//                     currentIndex: value,
//                     indicatorActiveColor: widget.indicatorColor,
//                     indicatorInactiveColor: widget.indicatorBackgroundColor,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
