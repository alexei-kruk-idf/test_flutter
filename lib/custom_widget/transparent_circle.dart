import 'package:flutter/material.dart';

class TransparentCircle extends StatelessWidget {
  const TransparentCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
          shape: const CircleBorder(),
          shadows: const [
            BoxShadow(
              blurRadius: 30,
              color: Color.fromRGBO(103, 152, 230, 0.2),
              offset: Offset(6, -1),
            ),
            BoxShadow(
              color: Colors.white,
              blurRadius: 20,
              offset: Offset(0, 1),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              const Color.fromRGBO(103, 152, 230, 0.2),
              Colors.white.withOpacity(0),
            ],
          )),
      child: const SizedBox(
        width: 300,
        height: 300,
      ),
    );
  }
}
