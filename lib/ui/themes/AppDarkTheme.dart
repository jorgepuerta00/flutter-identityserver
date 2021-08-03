import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/AppColors.dart';
import '../constants/AppFonts.dart';

final _inputBorderDark = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: BorderSide(
    color: AppColors.GREY_DARK,
    width: 1,
    style: BorderStyle.solid,
  ),
);

final _inputBorderFocusedDark = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: BorderSide(
    color: AppColors.BLUE_LIGHT,
    width: 1,
    style: BorderStyle.solid,
  ),
);

final _inputBorderErrorDark = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: BorderSide(
    color: AppColors.RED,
    width: 1,
    style: BorderStyle.solid,
  ),
);

ThemeData buildAppDarkTheme(BuildContext context) {
  final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.PRIMARY_SWATCH,
    accentColor: AppColors.ORANGE,
    primaryColor: AppColors.WHITE,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.PRIMARY_SWATCH,
      textTheme: GoogleFonts.sourceSansProTextTheme().copyWith(
        headline6: TextStyle(
          color: AppColors.WHITE,
        ),
      ),
    ),
    //TODO: Update this font with the real font
    textTheme: GoogleFonts.sourceSansProTextTheme().copyWith(
      headline1: Theme.of(context).textTheme.headline1?.copyWith(
            fontFamily: AppFonts.Avenir,
            color: AppColors.WHITE,
            fontSize: 40,
            fontWeight: FontWeight.w900,
          ),
      bodyText1: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: AppColors.WHITE,
            fontSize: 20,
          ),
      subtitle1: GoogleFonts.sourceSansProTextTheme().subtitle1?.copyWith(
            color: AppColors.WHITE,
            fontSize: 17,
          ),
      caption: GoogleFonts.sourceSansProTextTheme().caption?.copyWith(
            color: AppColors.WHITE,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
    ),

    inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
          border: _inputBorderDark,
          enabledBorder: _inputBorderDark,
          focusedBorder: _inputBorderFocusedDark,
          errorBorder: _inputBorderErrorDark,
          errorStyle: GoogleFonts.sourceSansPro().copyWith(
            color: AppColors.RED,
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: 12,
            bottom: 10,
            left: 16,
            right: 16,
          ),
        ),
  );

  return darkTheme;
}
