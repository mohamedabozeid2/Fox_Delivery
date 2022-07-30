import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

var defaultColor = const Color(0xff5967a4);

// ThemeData darkTheme = ThemeData(
//   primarySwatch: defaultBlueColor,
//   scaffoldBackgroundColor: Colors.black,
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       selectedItemColor: defaultDarkColor,
//       backgroundColor: Colors.black,
//       elevation: 20.0,
//       type: BottomNavigationBarType.fixed,
//       unselectedItemColor: Colors.grey),
//   appBarTheme: AppBarTheme(
//       elevation: 0.0,
//       titleSpacing: 20.0,
//       systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: Colors.black,
//           statusBarIconBrightness: Brightness.light),
//       backgroundColor: Colors.black,
//       titleTextStyle: TextStyle(
//           color: defaultDarkColor,
//           fontSize: 22.0,
//           fontWeight: FontWeight.bold,
//           fontFamily: "Jannah"),
//       actionsIconTheme: IconThemeData(color: defaultDarkColor)),
//   textTheme: const TextTheme(
//       subtitle1: TextStyle(
//           fontSize: 14.0,
//           fontWeight: FontWeight.w600,
//           color: Colors.white,
//           height: 1.3
//       ),
//       bodyText1: TextStyle(
//         fontSize: 20.0,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//       bodyText2: TextStyle(
//           fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white)),
//   fontFamily: 'Jannah',
// );

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: defaultColor,
      ),
      subtitle1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: defaultColor,
          height: 1.3),
      bodyText2: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.w600, color: defaultColor)),
  primarySwatch: Colors.blue,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: defaultColor),
  scaffoldBackgroundColor: defaultColor,
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: Colors.white),
    actionsIconTheme: const IconThemeData(color: Colors.white),
    toolbarHeight: Get.height*0.1,
    titleSpacing: 20.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0.0,
    backgroundColor: defaultColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: defaultColor,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: defaultColor,
      elevation: 20.0),
);
