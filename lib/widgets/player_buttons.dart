import 'package:flutter/material.dart';
import 'package:innerbhakti/utils/app_color.dart';

Widget buildButton(IconData icons, void Function() onTap) {
  return Container(
    width: 64,
    height: 64,
    decoration: BoxDecoration(
      color: AppColor.primary,
      borderRadius: BorderRadius.circular(32),
    ),
    child: IconButton(
      icon: Icon(
        icons,
        size: 32,
        color: AppColor.bgColor,
      ),
      onPressed: onTap,
    ),
  );
}
