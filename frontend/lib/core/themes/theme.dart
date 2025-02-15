import 'package:flutter/material.dart';

// Màu chủ đạo: Đỏ nhẹ
const Color primaryColor = Color(0xFFE57373); // Màu đỏ nhẹ
const Color secondaryColor = Color(0xFFFFCDD2); // Màu đỏ nhạt hơn
const Color backgroundColor = Color(0xFFFFEBEE); // Màu nền hơi hồng nhạt

// Định nghĩa ThemeData
final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: primaryColor),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: secondaryColor, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    labelStyle: TextStyle(color: primaryColor),
  ),
);
