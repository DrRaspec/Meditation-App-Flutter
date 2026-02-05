import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meditation_app/core/widgets/native_ios_blur.dart';

/// Reusable glass surface.
///
/// Behavior:
/// - iOS + native blur enabled -> uses [NativeIosBlur]
/// - otherwise -> uses Flutter [BackdropFilter]
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.alignment,
    this.margin,
    this.constraints,
    this.height,
    this.width,
    this.borderRadius = 24,
    this.blurSigma = 16,
    this.borderColor,
    this.borderWidth = 1,
    this.gradient,
    this.boxShadow,
    this.iosOnly = false,
    this.useNativeIosBlur = true,
    this.iosBlurStyle = IosBlurStyle.systemMaterial,
    this.iosNativeViewType = 'native_blur_view',
    this.iosNativeCreationParams,
    this.fallbackColor,
  });

  final Widget child;

  /// Inner padding for the content.
  final EdgeInsetsGeometry? padding;

  /// Child alignment inside the surface.
  final AlignmentGeometry? alignment;

  /// Outer margin around the surface.
  final EdgeInsetsGeometry? margin;

  /// Optional constraints for the surface.
  final BoxConstraints? constraints;

  /// Optional fixed height.
  final double? height;

  /// Optional fixed width.
  final double? width;

  /// Border radius for both blur clip and decoration.
  final double borderRadius;

  /// Fallback blur intensity when not using native iOS blur.
  final double blurSigma;

  /// Border color of the glass surface.
  final Color? borderColor;

  /// Border width of the glass surface.
  final double borderWidth;

  /// Optional overlay gradient on top of the blur.
  final Gradient? gradient;

  /// Optional custom shadow list.
  final List<BoxShadow>? boxShadow;

  /// If true, only apply glass effect on iOS.
  final bool iosOnly;

  /// If true, use native iOS blur via platform view on iOS.
  final bool useNativeIosBlur;

  /// Native iOS blur style when [useNativeIosBlur] is true.
  final IosBlurStyle iosBlurStyle;

  /// Native iOS platform-view type id.
  final String iosNativeViewType;

  /// Extra params sent to the native iOS platform view.
  final Map<String, dynamic>? iosNativeCreationParams;

  /// Solid fallback color when glass effect is disabled.
  final Color? fallbackColor;

  @override
  Widget build(BuildContext context) {
    final isIos = Theme.of(context).platform == TargetPlatform.iOS;
    final shouldUseGlass = !iosOnly || isIos;
    final useNativeIos = shouldUseGlass && useNativeIosBlur && isIos && !kIsWeb;
    final radius = BorderRadius.circular(borderRadius);

    final overlaySurface = Container(
      alignment: alignment,
      margin: margin,
      constraints: constraints,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: radius,
        color: shouldUseGlass
            ? null
            : fallbackColor ?? Theme.of(context).cardColor,
        gradient: shouldUseGlass
            ? (gradient ??
                  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.14),
                      Colors.white.withValues(alpha: 0.03),
                    ],
                  ))
            : null,
        border: Border.all(
          color: borderColor ?? Colors.white.withValues(alpha: 0.22),
          width: borderWidth,
        ),
        boxShadow: boxShadow ??
            (shouldUseGlass
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : null),
      ),
      child: child,
    );

    Widget withSize(Widget child) {
      if (height == null && width == null) return child;
      return SizedBox(height: height, width: width, child: child);
    }

    if (!shouldUseGlass) {
      return withSize(overlaySurface);
    }

    if (useNativeIos) {
      return withSize(
        ClipRRect(
          borderRadius: radius,
          child: Stack(
            fit: StackFit.expand,
            children: [
              NativeIosBlur(
                borderRadius: borderRadius,
                style: iosBlurStyle,
                viewType: iosNativeViewType,
                extraCreationParams: iosNativeCreationParams,
              ),
              overlaySurface,
            ],
          ),
        ),
      );
    }

    return withSize(
      ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: overlaySurface,
        ),
      ),
    );
  }
}
