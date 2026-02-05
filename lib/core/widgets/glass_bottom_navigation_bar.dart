import 'package:flutter/material.dart';
import 'package:meditation_app/core/widgets/glass_container.dart';
import 'package:meditation_app/core/widgets/native_ios_blur.dart';

class GlassNavItem {
  const GlassNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });

  final IconData icon;
  final String label;
  final IconData? activeIcon;
}

class GlassBottomNavigationBar extends StatelessWidget {
  const GlassBottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.iosOnly = false,
    this.useNativeIosBlur = true,
    this.iosBlurStyle = IosBlurStyle.systemMaterial,
    this.iosNativeViewType = 'native_blur_view',
    this.iosNativeCreationParams,
    this.blurSigma = 16,
    this.borderRadius = 24,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    this.safeAreaMinimum = const EdgeInsets.fromLTRB(12, 0, 12, 12),
    this.borderColor,
    this.borderWidth = 1,
    this.gradient,
    this.boxShadow,
    this.fallbackColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.labelStyle,
    this.selectedLabelStyle,
    this.iconSize = 24,
  });

  final List<GlassNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool iosOnly;
  final bool useNativeIosBlur;
  final IosBlurStyle iosBlurStyle;
  final String iosNativeViewType;
  final Map<String, dynamic>? iosNativeCreationParams;
  final double blurSigma;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsets safeAreaMinimum;
  final Color? borderColor;
  final double borderWidth;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final Color? fallbackColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final TextStyle? labelStyle;
  final TextStyle? selectedLabelStyle;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final activeColor = selectedItemColor ?? Theme.of(context).colorScheme.primary;
    final inactiveColor = unselectedItemColor ?? Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: 0.6);

    return SafeArea(
      minimum: safeAreaMinimum,
      child: GlassContainer(
        iosOnly: iosOnly,
        useNativeIosBlur: useNativeIosBlur,
        iosBlurStyle: iosBlurStyle,
        iosNativeViewType: iosNativeViewType,
        iosNativeCreationParams: iosNativeCreationParams,
        blurSigma: blurSigma,
        borderRadius: borderRadius,
        padding: padding,
        borderColor: borderColor,
        borderWidth: borderWidth,
        gradient: gradient,
        boxShadow: boxShadow,
        fallbackColor: fallbackColor,
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++)
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => onTap(i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          i == currentIndex
                              ? (items[i].activeIcon ?? items[i].icon)
                              : items[i].icon,
                          size: iconSize,
                          color: i == currentIndex
                              ? activeColor
                              : inactiveColor,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          items[i].label,
                          style: (i == currentIndex
                                  ? selectedLabelStyle
                                  : labelStyle) ??
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: i == currentIndex
                                        ? activeColor
                                        : inactiveColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
