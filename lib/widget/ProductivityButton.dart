import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double? size;
  final VoidCallback onPressed;

  const ProductivityButton(
      {super.key,
      required this.color,
      required this.text,
      this.size,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: size,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
