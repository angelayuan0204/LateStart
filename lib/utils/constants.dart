import 'package:flutter/material.dart';

enum AppTheme { light, dark }

enum Status { initialized, ongoing, completed }

enum CounterUpdate { increment, decrement }


const Color primaryColor = Color(0xff7D5CF5);//Color(0xffAFFC41);

const Color primaryTitleGrayColor = Color(0xFFAEAEAE);

// Dark Theme Color Palette
const Color secondaryColor = Color(0xffE2daff);//Color(0xffB8E9C4);
const Color primaryBackgroundColor = Color(0xff16171c);
const Color secondaryBackgroundColor = Color(0xff1c1f26);
const Color primaryTextColor = Colors.white;
const Color secondaryTextColor = Colors.black;
const Color primaryDisabledTextColor = Color(0xff595f6b);

// Light Theme Color Palette
const Color lightSecondaryColor = Color(0xff6FBC00);
const Color lightPrimaryBackgroundColor = Color(0xffFFFFFF);
const Color lightSecondaryBackgroundColor = Color(0xffF9F9F9);
const Color lightPrimaryTextColor = Color(0xff444444);
const Color lightSecondaryTextColor = Color(0xff7C7C7C);
const Color lightPrimaryDisabledTextColor = Color(0xffACACAB);

// Dark ThemeData
ThemeData themeData = ThemeData(
  useMaterial3: false,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: secondaryColor),
  ),
  iconTheme: const IconThemeData(
    color: primaryTextColor,
  ),
  fontFamily: 'arial',//poppins
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(primaryTextColor),
    fillColor: MaterialStateProperty.all(primaryBackgroundColor),
  ),
  textTheme: const TextTheme(
    titleSmall: TextStyle(color: primaryTextColor, letterSpacing: 0.15),
    titleMedium: TextStyle(color: primaryTextColor, letterSpacing: 0.15),
    titleLarge: TextStyle(color: primaryTextColor, letterSpacing: 0.15),
    bodySmall: TextStyle(color: primaryTextColor, letterSpacing: 0.15),
    bodyMedium: TextStyle(color: primaryTextColor, letterSpacing: 0.15),
    bodyLarge: TextStyle(color: primaryTextColor, letterSpacing: 0.15),
    displaySmall: TextStyle(
      fontSize: 16,
      color: primaryTextColor,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
    displayLarge: TextStyle(
      fontSize: 28,
      color: primaryTextColor,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
    displayMedium: TextStyle(
      fontSize: 23,
      color: primaryTextColor,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.black,
    backgroundColor: primaryColor,
  ),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: primaryBackgroundColor,
  appBarTheme: const AppBarTheme(backgroundColor: primaryBackgroundColor),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: secondaryColor,
    background: primaryBackgroundColor,
    onPrimaryContainer: secondaryBackgroundColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: primaryTextColor.withOpacity(0.5)),
    labelStyle: const TextStyle(color: primaryTextColor),
    focusColor: primaryTextColor,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: primaryColor),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: primaryColor),
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: primaryColor,
    selectionColor: primaryColor,
    selectionHandleColor: secondaryColor,
  ),
  sliderTheme: SliderThemeData(
    thumbColor: primaryColor,
    activeTrackColor: primaryColor,
    inactiveTrackColor: primaryTextColor.withOpacity(0.3),
  ),
  outlinedButtonTheme: const OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
      side: MaterialStatePropertyAll(BorderSide(color: primaryColor)),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: primaryBackgroundColor,
    selectedLabelStyle: TextStyle(
      color: primaryColor,
      shadows: [
          Shadow(color: Color.fromARGB(90, 255, 255, 255), offset: Offset(1, 1), blurRadius: 10.0),
          Shadow(color: Color.fromARGB(90, 255, 255, 255), offset: Offset(1, -1), blurRadius: 10.0),
          Shadow(color: Color.fromARGB(90, 255, 255, 255), offset: Offset(-1, 1), blurRadius: 10.0),
          Shadow(color: Color.fromARGB(90, 255, 255, 255), offset: Offset(-1, -1), blurRadius: 10.0),
        ],
    ),
    unselectedLabelStyle: TextStyle(
      color: primaryTextColor,
    ),
    selectedIconTheme: IconThemeData(
      color: primaryColor,
      shadows: [
          Shadow(color: Color.fromARGB(90, 255, 255, 255), offset: Offset(1, 1), blurRadius: 10.0),
          Shadow(color: Color.fromARGB(90, 255, 255, 255), offset: Offset(1, -1), blurRadius: 10.0),
          Shadow(color: Color.fromARGB(90, 255, 255, 255), offset: Offset(-1, 1), blurRadius: 10.0),
          Shadow(color: Color.fromARGB(90, 255, 255, 255), offset: Offset(-1, -1), blurRadius: 10.0),
        ],
    ),
    unselectedIconTheme: IconThemeData(
      color: primaryTextColor,
    ),
  ),
);

// Light ThemeData
ThemeData lightThemeData = ThemeData(
  useMaterial3: false,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: primaryColor),
  ),
  iconTheme: const IconThemeData(
    color: lightPrimaryTextColor,
  ),
  fontFamily: 'arial',//poppins
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(primaryTextColor),
    fillColor: MaterialStateProperty.all(lightPrimaryBackgroundColor),
  ),
  textTheme: const TextTheme(
    titleSmall: TextStyle(color: lightPrimaryTextColor, letterSpacing: 0.15),
    titleMedium: TextStyle(color: lightPrimaryTextColor, letterSpacing: 0.15),
    titleLarge: TextStyle(color: lightPrimaryTextColor, letterSpacing: 0.15),
    bodySmall: TextStyle(color: lightPrimaryTextColor, letterSpacing: 0.15),
    bodyMedium: TextStyle(color: lightPrimaryTextColor, letterSpacing: 0.15),
    bodyLarge: TextStyle(color: lightPrimaryTextColor, letterSpacing: 0.15),
    displaySmall: TextStyle(
      fontSize: 16,
      color: lightPrimaryTextColor,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
    displayLarge: TextStyle(
      fontSize: 28,
      color: lightPrimaryTextColor,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
    displayMedium: TextStyle(
      fontSize: 23,
      color: lightPrimaryTextColor,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.black,
    backgroundColor: primaryColor,
  ),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: lightPrimaryBackgroundColor,
  appBarTheme: const AppBarTheme(backgroundColor: lightPrimaryBackgroundColor),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: lightSecondaryColor,
    background: lightPrimaryBackgroundColor,
    onPrimaryContainer: lightSecondaryBackgroundColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: lightPrimaryTextColor.withOpacity(0.5)),
    labelStyle: const TextStyle(color: lightPrimaryTextColor),
    focusColor: lightPrimaryTextColor,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: primaryColor),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: primaryColor),
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: primaryColor,
    selectionColor: primaryColor,
    selectionHandleColor: lightSecondaryColor,
  ),
  sliderTheme: SliderThemeData(
    thumbColor: primaryColor,
    activeTrackColor: primaryColor,
    inactiveTrackColor: lightPrimaryTextColor.withOpacity(0.3),
  ),
  outlinedButtonTheme: const OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
      side: MaterialStatePropertyAll(BorderSide(color: primaryColor)),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: lightPrimaryBackgroundColor,
    selectedLabelStyle: TextStyle(
      color: primaryColor,
      shadows: [
          Shadow(color: Color.fromARGB(120, 0, 0, 0), offset: Offset(1, 1), blurRadius: 10.0),
          Shadow(color: Color.fromARGB(120, 0, 0, 0), offset: Offset(1, -1), blurRadius: 10.0),
          Shadow(color: Color.fromARGB(120, 0, 0, 0), offset: Offset(-1, 1), blurRadius: 10.0),
          Shadow(color: Color.fromARGB(120, 0, 0, 0), offset: Offset(-1, -1), blurRadius: 10.0),
        ],
    ),
    unselectedLabelStyle: TextStyle(
      color: lightPrimaryTextColor,
    ),
    selectedIconTheme: IconThemeData(
      color: primaryColor,
      shadows: [
          Shadow(color: Color.fromARGB(100, 0, 0, 0), offset: Offset(1, 1), blurRadius: 10.0),
          Shadow(color: Color.fromARGB(100, 0, 0, 0), offset: Offset(1, -1), blurRadius: 10.0),
          Shadow(color: Color.fromARGB(100, 0, 0, 0), offset: Offset(-1, 1), blurRadius: 10.0),
          Shadow(color: Color.fromARGB(100, 0, 0, 0), offset: Offset(-1, -1), blurRadius: 10.0),
        ],
    ),
    unselectedIconTheme: IconThemeData(
      color: lightPrimaryTextColor,
    ),
  ),
);
