import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innovins_tech/const/app_colors.dart';

TextFormField customTextFormField({label, controller}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      label: Text("$label"),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.greyColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.greenColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.redColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      hintStyle: TextStyle(color: AppColors.greyColor, fontSize: 12.sp),
    ),
  );
}
