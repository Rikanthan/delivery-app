import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GredientIcon extends StatelessWidget {
    GredientIcon(
    this.icon,
    this.size
  );

  final IconData icon;
  final double size;
   Gradient gradient = 
   LinearGradient(
        colors: <Color>[
          Colors.white,
          Colors.yellow,
          Colors.amber,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}