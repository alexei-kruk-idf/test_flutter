import 'package:flutter/material.dart';

class CustomToggleMin extends StatefulWidget {
  const CustomToggleMin({Key? key}) : super(key: key);

  @override
  State<CustomToggleMin> createState() => _CustomToggleMinState();
}

class _CustomToggleMinState extends State<CustomToggleMin> {
  bool _isEnabled = false;
  void _onTapButton() {
    setState(() {
      _isEnabled = !_isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapButton,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.centerLeft,
        width: 500,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: _isEnabled ? const Color(0xff989fd5) : const Color(0xff565671),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: _isEnabled ? Alignment.centerRight : Alignment.centerLeft,
          child: FractionallySizedBox(
            heightFactor: 2,
            widthFactor: 0.4,
            child: Container(
              // height: 300,
              // width: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(103, 152, 230, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
