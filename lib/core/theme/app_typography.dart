import 'package:flutter/material.dart';
import 'package:flutter_adaptive_kit/flutter_adaptive_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static String fontFamily() {
    if (PlatformUtils.isIOS) return 'Helvetica Neue';
    return GoogleFonts.inter().fontFamily!;
  }

  static TextTheme textTheme(Brightness brightness) {
    final family = fontFamily();
    final base = GoogleFonts.interTextTheme();

    return base.copyWith(
      headlineLarge: base.headlineLarge?.copyWith(
        fontFamily: family,
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontFamily: family,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: base.bodyLarge?.copyWith(fontFamily: family, fontSize: 16),
      bodyMedium: base.bodyMedium?.copyWith(fontFamily: family, fontSize: 14),
      labelLarge: base.labelLarge?.copyWith(
        fontFamily: family,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
