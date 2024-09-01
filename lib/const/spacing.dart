import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Spacing {
  static EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: 16.w,
  );

  static SizedBox heightBox(double height) => SizedBox(
        height: height.h,
      );
  static SizedBox widthBox(double widht) => SizedBox(
        width: widht.h,
      );
}
