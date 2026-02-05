import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum IosBlurStyle {
  systemUltraThinMaterial,
  systemThinMaterial,
  systemMaterial,
  systemThickMaterial,
  systemChromeMaterial,
}

/// iOS-only native blur surface backed by `UIVisualEffectView`.
///
/// This widget is used by [GlassContainer] when native blur is enabled.
class NativeIosBlur extends StatelessWidget {
  const NativeIosBlur({
    super.key,
    required this.borderRadius,
    this.style = IosBlurStyle.systemMaterial,
    this.viewType = 'native_blur_view',
    this.extraCreationParams,
  });

  /// Corner radius forwarded to the native iOS view.
  final double borderRadius;

  /// Native material style for the blur surface.
  final IosBlurStyle style;
  /// Platform view type id. Override when embedding a custom native implementation.
  final String viewType;
  /// Extra creation params merged into platform-view params.
  final Map<String, dynamic>? extraCreationParams;

  @override
  Widget build(BuildContext context) {
    final params = <String, dynamic>{
      'cornerRadius': borderRadius,
      'style': style.name,
      ...?extraCreationParams,
    };

    return UiKitView(
      viewType: viewType,
      creationParams: params,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
