import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:gripable_test_app/assets/brand_colors.dart';

class CustomAnimatedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;


  CustomAnimatedButton({this.text, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedButton(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: onPressed,
        color: color,
      ),
    );
  }
}