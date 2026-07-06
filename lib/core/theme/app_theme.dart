import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static const double _buttonRadius = 12;
  static const double _cardRadius = 16;
  static const double _inputRadius = 12;

  static ThemeData lightTheme = _buildTheme(isDark: false);

  static ThemeData darkTheme = _buildTheme(isDark: true);

  static ThemeData _buildTheme({required bool isDark}) {
    final background =
        isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final textPrimary =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final textTertiary =
        isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight;
    final outline = isDark ? AppColors.outlineDark : AppColors.outlineLight;
    final inputFill =
        isDark ? AppColors.inputFillDark : AppColors.inputFillLight;
    final chipInactive =
        isDark ? AppColors.chipInactiveDark : AppColors.chipInactiveLight;
    final navInactive =
        isDark ? AppColors.navInactiveDark : AppColors.navInactiveLight;

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: AppColors.fontFamily,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        primaryContainer:
            isDark ? AppColors.primaryTintDark : AppColors.primaryTint,
        onPrimaryContainer: AppColors.primary,
        secondary: AppColors.primaryLight,
        onSecondary: AppColors.white,
        secondaryContainer:
            isDark ? AppColors.primaryTintDark : AppColors.primaryTint,
        onSecondaryContainer: AppColors.primary,
        tertiary: AppColors.success,
        onTertiary: AppColors.white,
        tertiaryContainer:
            isDark ? AppColors.successTintDark : AppColors.successTint,
        onTertiaryContainer: AppColors.success,
        error: AppColors.error,
        onError: AppColors.white,
        errorContainer: isDark ? AppColors.errorTintDark : AppColors.errorTint,
        onErrorContainer: AppColors.error,
        surface: surface,
        onSurface: textPrimary,
        surfaceContainerHighest: background,
        onSurfaceVariant: textSecondary,
        outline: outline,
        shadow: AppColors.black,
        scrim: AppColors.black,
        inverseSurface: isDark ? AppColors.surfaceLight : AppColors.surfaceDark,
        onInverseSurface:
            isDark ? AppColors.textPrimaryLight : AppColors.textPrimaryDark,
        inversePrimary: AppColors.primaryLight,
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: AppColors.fontFamily,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: isDark ? 0 : 1,
        shadowColor: AppColors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardRadius),
          side: BorderSide(
            color: isDark ? outline : outline.withValues(alpha: 0.5),
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: outline,
        thickness: 0.5,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        hintStyle: TextStyle(
          color: textTertiary,
          fontFamily: AppColors.fontFamily,
        ),
        prefixIconColor: textTertiary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputRadius),
          borderSide: BorderSide(color: outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputRadius),
          borderSide: BorderSide(color: outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputRadius),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputRadius),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputRadius),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: textPrimary,
          fontFamily: AppColors.fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: textPrimary,
          fontFamily: AppColors.fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: textPrimary,
          fontFamily: AppColors.fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontFamily: AppColors.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: textPrimary,
          fontFamily: AppColors.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: textSecondary,
          fontFamily: AppColors.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: textPrimary,
          fontFamily: AppColors.fontFamily,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: textSecondary,
          fontFamily: AppColors.fontFamily,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: textTertiary,
          fontFamily: AppColors.fontFamily,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          color: AppColors.white,
          fontFamily: AppColors.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: textSecondary,
          fontFamily: AppColors.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: textTertiary,
          fontFamily: AppColors.fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconTheme: IconThemeData(
        color: isDark ? textSecondary : textTertiary,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.white),
        side: BorderSide(color: outline, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: chipInactive,
        selectedColor: AppColors.primary,
        disabledColor: chipInactive,
        labelStyle: TextStyle(
          fontFamily: AppColors.fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: AppColors.fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide.none,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: navInactive,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontFamily: AppColors.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: AppColors.fontFamily,
          fontSize: 12,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 4,
        shape: CircleBorder(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_buttonRadius),
          ),
          textStyle: const TextStyle(
            fontFamily: AppColors.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          backgroundColor: surface,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_buttonRadius),
          ),
          textStyle: const TextStyle(
            fontFamily: AppColors.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontFamily: AppColors.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
