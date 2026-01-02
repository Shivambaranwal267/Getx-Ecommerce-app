import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/theme/widget_theme/appbar_theme.dart';
import 'package:ecommerce/utils/theme/widget_theme/bottom_sheet_theme.dart';
import 'package:ecommerce/utils/theme/widget_theme/checkbox_theme.dart';
import 'package:ecommerce/utils/theme/widget_theme/chip_theme.dart';
import 'package:ecommerce/utils/theme/widget_theme/elevated_button_theme.dart';
import 'package:ecommerce/utils/theme/widget_theme/outlined_button_theme.dart';
import 'package:ecommerce/utils/theme/widget_theme/text_field_theme.dart';
import 'package:ecommerce/utils/theme/widget_theme/text_theme.dart';
import 'package:flutter/material.dart';

class UAppTheme {
  // private constructor
  UAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.light,
    primaryColor: UColors.primary,
    disabledColor: UColors.grey,
    textTheme: UTextTheme.lightTextTheme,
    chipTheme: UChipTheme.lightChipTheme,
    scaffoldBackgroundColor: UColors.white,
    appBarTheme: UAppBarTheme.lightAppBarTheme,
    checkboxTheme: UCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: UBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: UElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: UOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: UTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.dark,
    primaryColor: UColors.primary,
    disabledColor: UColors.grey,
    textTheme: UTextTheme.darkTextTheme,
    chipTheme: UChipTheme.darkChipTheme,
    scaffoldBackgroundColor: UColors.black,
    appBarTheme: UAppBarTheme.darkAppBarTheme,
    checkboxTheme: UCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: UBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: UElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: UOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: UTextFormFieldTheme.darkInputDecorationTheme,
  );
}
