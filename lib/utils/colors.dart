import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.black,
    cardColor: const Color(0xFFF4F4F4),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    splashColor: const Color(0xFF57595E),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.cairo(
        color: Colors.black,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF2C303D),
    //TODO: Need to verify name.
    splashColor: const Color(0xFF202032),
    canvasColor: Colors.white,
    cardColor: const Color(0xFF272630),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.cairo(
        color: Colors.white,
      ),
    ),
  );
}

const whiteColor = Colors.white;
const blackTextColor = Colors.black;
const primaryColor = Color(0xFFBDF369);
const greyColor = Colors.grey;
const bottomBarColor = Color(0xFF202032);
const greenColor = Color(0xFFBDF369);