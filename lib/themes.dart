import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromARGB(255, 8, 168, 35);
// const kSecondaryColor = Color(0xFFEFBC08);
const kPrimaryLightColor = Color(0xFFF1E6FF);
// const whiteColor = Color(0xFF121212);
// // const whiteColor = Colors.white;
const greyColor = Color.fromARGB(255, 158, 158, 158);
// const blackColor = Colors.white;
// // const blackColor = Colors.black;
// const detailPageTextColor = Color(0xFF2C2C2C);

const double defaultPadding = 16.0;

final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(color: greyColor),
      unselectedIconTheme: IconThemeData(color: Color(0xFF121212)),
      selectedItemColor: greyColor,
      unselectedItemColor: Color(0xFF121212),
      // selectedItemColor: kPrimary
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF121212),
    ),
    cardTheme: const CardTheme(shadowColor: Color(0xFF121212), elevation: 15),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    shadowColor: const Color(0xFF121212),
    cardColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        maximumSize: const Size(double.infinity, 56),
        minimumSize: const Size(double.infinity, 56),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: kPrimaryLightColor,
      suffixIconColor: kPrimaryColor,
      iconColor: kPrimaryColor,
      prefixIconColor: kPrimaryColor,
      contentPadding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide.none,
      ),
    ));

final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF121212)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
      selectedIconTheme: IconThemeData(color: greyColor),
      unselectedIconTheme: IconThemeData(color: Colors.white),
      selectedItemColor: greyColor,
      unselectedItemColor: Colors.white,
      // selectedItemColor: kPrimary
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    cardTheme: const CardTheme(shadowColor: Colors.white, elevation: 15),
    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF121212)),
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: const Color(0xFF121212),
    shadowColor: Colors.white,
    cardColor: const Color(0xFF121212),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        // primary: kPrimaryColor,
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.black,
        shape: const StadiumBorder(),
        maximumSize: const Size(double.infinity, 56),
        minimumSize: const Size(double.infinity, 56),
      ),
    ),
    // textTheme: TextTheme(
    //   textStyle
    // ),
    // text
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: kPrimaryLightColor,
      iconColor: kPrimaryColor,
      prefixIconColor: kPrimaryColor,
      contentPadding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide.none,
      ),
    ));
