import 'package:flutter/material.dart';
import 'package:innerbhakti/utils/app_color.dart';

Widget buildCircleIcon(IconData icon, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: CircleAvatar(
      backgroundColor: AppColor.bgColor,
      radius: 16,
      child: Icon(
        icon,
        size: 20,
        color: Colors.black,
      ),
    ),
  );
}
