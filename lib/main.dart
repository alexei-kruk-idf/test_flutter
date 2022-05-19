import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/carousel/carousel_widget_1.dart';
import 'package:test_flutter/custom_widget/builder_screen.dart';
import 'package:test_flutter/custom_widget/custom_toggle.dart';
import 'package:test_flutter/custom_widget/custom_toggle_min.dart';
import 'package:test_flutter/custom_widget/percent_bar_widget.dart';

import 'carousel/carousel_widget.dart';
import 'custom_widget/provider_screen_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(
          title: 'dwda',
        )
        //BuilderScreen() //const MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: CarouselWidget(
            //    this.activeColorButtonDirection = const Color.fromRGBO(232, 25, 75, 1),
            // this.inactiveColorButtonDirection = const Color.fromRGBO(232, 25, 75, 0.3),
            //isLoop: true,
            //autoPlayInterval: 1000,
            //initialPage: 5,
            width: 312,
            height: 290,
            useButtonDirection: true,
            useCounter: true,
            useIndicator: true,
            textStyleCounter: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            colorCounter: Color.fromRGBO(232, 25, 75, 1),
            activeColorButtonDirection: Color.fromRGBO(232, 25, 75, 1),
            inactiveColorButtonDirection: Color.fromRGBO(232, 25, 75, 0.3),
            children: [
              Image.asset('assets/home_bank_1.png'),
              Image.asset('assets/home_bank_2.png'),
              Image.asset('assets/home_bank_3.png'),
              Image.asset('assets/home_bank_4.png'),
              Image.asset('assets/home_bank_5.png'),
              Image.asset('assets/home_bank_6.png'),
              Image.asset('assets/home_bank_7.png'),
              Image.asset('assets/home_bank_8.png'),
              Image.asset('assets/home_bank_9.png'),
              Image.asset('assets/home_bank_10.png'),
              Image.asset('assets/home_bank_11.png'),
              Image.asset('assets/home_bank_12.png'),
            ],
          ),
        ),
      ),
    );
  }
}
