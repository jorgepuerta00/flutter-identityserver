import 'package:flutter/material.dart';

class AppColors {
  //Material design palette generator: http://mcg.mbitson.com/#!?mcgpalette0=%233f51b5
  //Transparency colors: https://stackoverflow.com/questions/50081213/how-do-i-use-hexadecimal-color-strings-in-flutter

// 100% — FF
// 95% — F2
// 90% — E6
// 85% — D9
// 80% — CC
// 75% — BF
// 70% — B3
// 65% — A6
// 60% — 99
// 55% — 8C
// 50% — 80
// 45% — 73
// 40% — 66
// 35% — 59
// 30% — 4D
// 25% — 40
// 20% — 33
// 15% — 26
// 10% — 1A
// 5% — 0D
// 0% — 00

  static const int PRIMARY = 0xFF070417;
  static const PRIMARY_SWATCH = MaterialColor(PRIMARY, {
    50: Color(0xFFE1E1E3),
    100: Color(0xFFB5B4B9),
    200: Color(0xFF83828B),
    300: Color(0xFF514F5D),
    400: Color(0xFF2C2A3A),
    500: Color(0xFF070417),
    600: Color(0xFF060314),
    700: Color(0xFF050311),
    800: Color(0xFF04020D),
    900: Color(0xFF020107),
  });

  static const Color PRIMARY_COLOR = Color(0xFF070417);
  static const Color WHITE = Color(0xFFFFFFFF);
  static const Color ORANGE = Color(0xFFFF4D00);
  static const Color RED = Color(0xFFFF453A);

  static const Color GREY_DARK = Color(0xFF48484A);
  static const Color GREY_DARK_2 = Color(0xFF1c1b1b);
  static const Color GREY_DARK_3 = Color(0xFF292626);
  static const Color GREY_DARK_STRONG = Color(0x99EBEBF5);
  static const Color GREY = Color(0xFF16141F);

  /*Interes Icons background*/
  static const Color BLUE_LIGHT = Color(0xFF0A84FF);
  static const Color PURPLE = Color(0xFF5856D6);
  static const Color PURPLE_LIGHT = Color(0xFFAF52DE);
  static const Color RED_LIGHT = Color(0xFFFF3B30);
  static const Color YELLOW_LIGHT = Color(0xFFFF9500);

  //--------------------------------

  static const int PRIMARY_LIGHT = 0xFFA5CFF1;
  static const int PRIMARY_DARK = 0xFF0D3656;

  /*Screens*/
  static const int SCREEN_BACKGROUND_1 = 0xFFFFFFFF;

  /*Buttons*/
  static const int BUTTON_PRIMARY_TEXT = 0xFF276384;
  static const int BUTTON_ACCENT_TEXT = 0xFFffffff;

  /*Input text*/
  static const int INPUT_TEXT_LABEL = 0x4D000000;
  static const int INPUT_TEXT_TOP_LABEL = 0xB3354263;
  static const int INPUT_TEXT_ENABLED_BORDER = 0x26354263;
  static const int INPUT_TEXT_ERROR = 0xFFB52B36;
  static const int INPUT_TEXT = 0xFF000000;

  /*Text*/
  static const int TEXT_HEADLINE1 = 0xFF1E1E1E;
  static const int TEXT_HEADLINE2 = 0xFF000000;
  static const int TEXT_BODYTEXT1 = 0xFF000000;

  /*Icons*/
  static const int ICON_DISABLED = 0xFFAAAAAA;

  /*Other elements*/
  static const int SEPARATOR_LINE = 0x1A000000;
  static const int SUCCESS = 0xFF6B9541;
}
