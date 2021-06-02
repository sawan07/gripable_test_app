import 'package:flutter/material.dart';
import 'package:gripable_test_app/assets/brand_colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;

  CustomAppBar(this.title, {Key key}): preferredSize= Size.fromHeight(50.0),
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: BrandColors.colorBackground, fontWeight: FontWeight.w600),
      ),
      backgroundColor: BrandColors.colorSecondaryDark,
      automaticallyImplyLeading: true,
    );
  }
}
