import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const customBlueAccent = Color(0xffedf8ff);

class Themes {
  final ThemeData lightTheme = ThemeData(
    // primarySwatch: Colors.blue,

    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      iconColor: Colors.blue,
      hintStyle: const TextStyle(color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      errorStyle: const TextStyle(color: Colors.red),
      fillColor: Colors.blue,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
        borderSide: BorderSide(color: Colors.grey, width: 1.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
        borderSide: BorderSide(color: Colors.grey, width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
        borderSide: BorderSide(color: Colors.blue, width: 2.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
        borderSide: BorderSide(color: Colors.red, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
        borderSide: BorderSide(color: Colors.red, width: 2.w),
      ),
    ),
  );
}
