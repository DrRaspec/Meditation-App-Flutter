import 'package:flutter/material.dart';
import 'package:meditation_app/core/widgets/glass_container.dart';
import 'package:meditation_app/core/widgets/native_ios_blur.dart';

/// Compact icon-only glass button (great for back/menu actions).
class GlassIconButton extends StatelessWidget {
  const GlassIconButton({
    super.key,
    this.icon,
    this.child,
    required this.onTap,
    this.size = 44,
    this.borderRadius = 14,
    this.iosOnly = false,
    this.useNativeIosBlur = true,
    this.iosBlurStyle = IosBlurStyle.systemMaterial,
    this.iosNativeViewType = 'native_blur_view',
    this.iosNativeCreationParams,
    this.blurSigma = 16,
    this.iconSize = 22,
    this.iconColor,
    this.borderColor,
    this.borderWidth = 1,
    this.gradient,
    this.boxShadow,
    this.fallbackColor,
  });

  /// Icon to render inside the button.
  final IconData? icon;
  /// Optional custom child widget. Overrides [icon] when provided.
  final Widget? child;
  /// Tap callback.
  final VoidCallback onTap;
  /// Button width and height.
  final double size;
  /// Corner radius.
  final double borderRadius;
  /// If true, apply glass effect only on iOS.
  final bool iosOnly;
  /// If true, use native iOS blur on iOS.
  final bool useNativeIosBlur;
  /// Native iOS blur style when rendered on iOS.
  final IosBlurStyle iosBlurStyle;
  /// Native iOS platform-view type id.
  final String iosNativeViewType;
  /// Extra params sent to the native iOS platform view.
  final Map<String, dynamic>? iosNativeCreationParams;
  /// Blur sigma when Flutter-rendered blur is used.
  final double blurSigma;
  /// Icon size when [icon] is used.
  final double iconSize;
  /// Icon color when [icon] is used.
  final Color? iconColor;
  /// Optional border color for the glass surface.
  final Color? borderColor;
  /// Border width for the glass surface.
  final double borderWidth;
  /// Optional overlay gradient for the glass surface.
  final Gradient? gradient;
  /// Optional custom shadow list.
  final List<BoxShadow>? boxShadow;
  /// Solid fallback color when glass effect is disabled.
  final Color? fallbackColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: GlassContainer(
          iosOnly: iosOnly,
          useNativeIosBlur: useNativeIosBlur,
          iosBlurStyle: iosBlurStyle,
          iosNativeViewType: iosNativeViewType,
          iosNativeCreationParams: iosNativeCreationParams,
          blurSigma: blurSigma,
          width: size,
          height: size,
          borderRadius: borderRadius,
          borderColor: borderColor,
          borderWidth: borderWidth,
          gradient: gradient,
          boxShadow: boxShadow,
          fallbackColor: fallbackColor,
          child: child ??
              (icon == null
                  ? const SizedBox.shrink()
                  : Icon(
                      icon,
                      size: iconSize,
                      color: iconColor ?? Theme.of(context).colorScheme.onSurface,
                    )),
        ),
      ),
    );
  }
}
