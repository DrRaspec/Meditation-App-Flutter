import 'package:flutter/material.dart';
import 'package:meditation_app/core/widgets/glass_container.dart';
import 'package:meditation_app/core/widgets/native_ios_blur.dart';

/// Tappable glass button built on top of [GlassContainer].
class GlassButton extends StatelessWidget {
  const GlassButton({
    super.key,
    required this.label,
    required this.onTap,
    this.height = 56,
    this.borderRadius = 28,
    this.iosOnly = false,
    this.useNativeIosBlur = true,
    this.iosBlurStyle = IosBlurStyle.systemMaterial,
    this.iosNativeViewType = 'native_blur_view',
    this.iosNativeCreationParams,
    this.blurSigma = 16,
    this.textColor,
    this.textStyle,
    this.borderColor,
    this.borderWidth = 1,
    this.gradient,
    this.boxShadow,
    this.fallbackColor,
    this.leading,
    this.trailing,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.contentSpacing = 8,
    this.minContentSpacing = 4,
    this.minLabelWidth = 64,
  });

  /// Button label text.
  final String label;

  /// Tap callback.
  final VoidCallback onTap;

  /// Button height.
  final double height;

  /// Button corner radius.
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

  /// Optional label color. Defaults to `colorScheme.onPrimary`.
  final Color? textColor;

  /// Optional full text style for the label.
  ///
  /// If provided, it is merged with the default `labelLarge` style.
  final TextStyle? textStyle;

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

  /// Optional widget before the label (icon, svg, etc.).
  final Widget? leading;

  /// Optional widget after the label (icon, badge, etc.).
  final Widget? trailing;

  /// Content padding inside the button.
  final EdgeInsetsGeometry contentPadding;

  /// Spacing between optional content and label.
  final double contentSpacing;

  /// Minimum spacing allowed when width is tight.
  final double minContentSpacing;

  /// Minimum reserved width for label.
  final double minLabelWidth;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: GlassContainer(
          iosOnly: iosOnly,
          useNativeIosBlur: useNativeIosBlur,
          iosBlurStyle: iosBlurStyle,
          iosNativeViewType: iosNativeViewType,
          iosNativeCreationParams: iosNativeCreationParams,
          blurSigma: blurSigma,
          height: height,
          borderRadius: borderRadius,
          borderColor: borderColor,
          borderWidth: borderWidth,
          gradient: gradient,
          boxShadow: boxShadow,
          fallbackColor: fallbackColor,
          child: LayoutBuilder(
            builder: (context, constraints) {
              const estimatedAdornmentWidth = 28.0;
              final resolvedPadding = contentPadding.resolve(
                Directionality.of(context),
              );
              final horizontalPadding =
                  resolvedPadding.left + resolvedPadding.right;
              final adornmentCount =
                  (leading != null ? 1 : 0) + (trailing != null ? 1 : 0);
              final availableContentWidth =
                  (constraints.maxWidth - (horizontalPadding * 2)).clamp(
                    0.0,
                    double.infinity,
                  );
              final estimatedFixedWidth =
                  adornmentCount * estimatedAdornmentWidth;
              final spacingUpperBound = adornmentCount == 0
                  ? 0.0
                  : ((availableContentWidth -
                                estimatedFixedWidth -
                                minLabelWidth) /
                            adornmentCount)
                        .clamp(minContentSpacing, contentSpacing);
              final adaptiveSpacing = spacingUpperBound;
              final maxLabelWidth =
                  (availableContentWidth -
                          estimatedFixedWidth -
                          (adornmentCount * adaptiveSpacing))
                      .clamp(0.0, availableContentWidth);

              return Padding(
                padding: contentPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (leading != null) ...[
                      leading!,
                      SizedBox(width: adaptiveSpacing),
                    ],
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxLabelWidth),
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style:
                            (Theme.of(context).textTheme.labelLarge
                                        ?.copyWith(
                                          color:
                                              textColor ??
                                              Theme.of(
                                                context,
                                              ).colorScheme.onPrimary,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.4,
                                        ) ??
                                    TextStyle(
                                      color:
                                          textColor ??
                                          Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                    ))
                                .merge(textStyle),
                      ),
                    ),
                    if (trailing != null) ...[
                      SizedBox(width: adaptiveSpacing),
                      trailing!,
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
