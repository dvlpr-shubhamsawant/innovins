import 'package:flutter/material.dart';
import 'package:innovins_tech/const/app_colors.dart';

flutterToast(context, title) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      backgroundColor: AppColors.greenColor,
    ),
  );
}
