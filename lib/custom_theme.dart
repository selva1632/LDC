import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const mainBgColor = Color(0xFF000000);
const mainColor = Color(0xFFE26B6B);
const secondaryColor = Color(0xFFE7A9A9);
const cardColor = Color(0xFF202020);

final customTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: mainColor,
  splashColor: secondaryColor,
  scaffoldBackgroundColor: mainBgColor,
  canvasColor: cardColor,
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  primaryTextTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    backgroundColor: mainBgColor,
  ),
  tabBarTheme: const TabBarTheme(
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: mainColor,
        width: 2.0,
      ),
    ),
  ),
  cardTheme: const CardTheme(
    margin: EdgeInsets.all(6.0),
    color: cardColor,
    clipBehavior: Clip.hardEdge,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0.0,
    backgroundColor: mainBgColor,
    selectedItemColor: mainColor,
    unselectedItemColor: Colors.white,
  ),
);
