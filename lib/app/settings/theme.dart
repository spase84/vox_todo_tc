import 'package:flutter/material.dart';
import 'package:vox_todo/app/settings/colors.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.backgroundPrimary,
  fontFamily: 'SFUIText',
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.backgroundPrimary,
  ),
  textTheme: TextTheme(
    displayMedium: baseTextStyle.copyWith(
      fontSize: 26,
      fontWeight: FontWeight.w500,
    ),
    headlineLarge: baseTextStyle.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: baseTextStyle,
    bodySmall: baseTextStyle.copyWith(
      fontSize: 14,
    ),
    labelSmall: baseTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.textGray,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.secondary,
  ),
  cardTheme: const CardTheme(
    color: AppColors.backgroundGrey,
    elevation: 0,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.secondary,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.backgroundGrey;
            } else if (states.contains(WidgetState.pressed)) {
              return AppColors.primary.withValues(alpha: 0.8);
            }
            return AppColors.primary;
          },
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        minimumSize: WidgetStateProperty.all<Size>(const Size.fromHeight(40))),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(
        width: 1,
        color: AppColors.primary,
      ),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      backgroundColor: AppColors.inputsActiveBackground,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
    ),
  ),
);

const TextStyle baseTextStyle = TextStyle(
  fontFamily: '.SF UI Text',
  fontSize: 16.0,
  color: AppColors.textPrimary,
  fontWeight: FontWeight.w400,
);
