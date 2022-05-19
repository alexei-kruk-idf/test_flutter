import 'package:flutter/material.dart';

class CustomToggle extends StatefulWidget {
  const CustomToggle({Key? key}) : super(key: key);

  @override
  State<CustomToggle> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  bool _isEnable = false;

  void onTapButton() {
    setState(() {
      _isEnable = !_isEnable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapButton,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.centerLeft,
        height: 40,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: _isEnable ? const Color(0xff565671) : const Color(0xff989fd5),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 2,
              //blurRadius: 2,
            ),
          ],
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: _isEnable ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
