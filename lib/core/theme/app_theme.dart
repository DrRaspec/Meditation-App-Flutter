import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Theme source of truth for color and text usage.
///
/// Quick usage guide (prefer Theme tokens, not hardcoded colors):
/// - Screen background: `Theme.of(context).scaffoldBackgroundColor`
/// - Card/panel background: `Theme.of(context).colorScheme.surface`
/// - Primary button background: `Theme.of(context).colorScheme.primary`
/// - Primary button text/icon: `Theme.of(context).colorScheme.onPrimary`
/// - Normal body text: `Theme.of(context).textTheme.bodyLarge`
/// - Secondary/subtle text: `Theme.of(context).textTheme.bodyMedium`
/// - Headings/titles: `Theme.of(context).textTheme.headline*` or `title*`
class AppTheme {
  static ThemeData light() {
    final baseTextTheme = AppTypography.textTheme(Brightness.light);

    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          primary: AppColors.primary,
          surface: AppColors.lightSurface,
        ).copyWith(
          onSurface: AppColors.lightText,
          onPrimary: Colors.white,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBg,
      colorScheme: scheme,
      textTheme: baseTextTheme.copyWith(
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          color: AppColors.lightText,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          color: AppColors.lightText,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          color: AppColors.lightText,
        ),
        titleSmall: baseTextTheme.titleSmall?.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          color: AppColors.lightText,
        ),
        labelMedium: baseTextTheme.labelMedium?.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        labelSmall: baseTextTheme.labelSmall?.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(
          color: AppColors.lightText,
        ),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          color: AppColors.lightText,
        ),
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(
          color: AppColors.lightText,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightIconInactive,
        backgroundColor: AppColors.lightSurface,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }

  static ThemeData dark() {
    final baseTextTheme = AppTypography.textTheme(Brightness.dark);

    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
          primary: AppColors.primary,
          surface: AppColors.darkSurface,
        ).copyWith(
          onSurface: AppColors.darkText,
          onPrimary: Colors.white,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBg,
      colorScheme: scheme,
      textTheme: baseTextTheme.copyWith(
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: AppColors.darkText),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          color: AppColors.darkText,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          color: AppColors.darkText,
        ),
        titleSmall: baseTextTheme.titleSmall?.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          color: AppColors.darkText,
        ),
        labelMedium: baseTextTheme.labelMedium?.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        labelSmall: baseTextTheme.labelSmall?.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(
          color: AppColors.darkText,
        ),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          color: AppColors.darkText,
        ),
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(
          color: AppColors.darkText,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkIconInactive,
        backgroundColor: AppColors.darkSurface,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }
}
