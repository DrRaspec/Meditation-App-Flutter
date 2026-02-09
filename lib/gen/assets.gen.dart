// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/auth
  $AssetsIconsAuthGen get auth => const $AssetsIconsAuthGen();

  /// Directory path: assets/icons/common
  $AssetsIconsCommonGen get common => const $AssetsIconsCommonGen();

  /// Directory path: assets/icons/shell
  $AssetsIconsShellGen get shell => const $AssetsIconsShellGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/auth
  $AssetsImagesAuthGen get auth => const $AssetsImagesAuthGen();
}

class $AssetsVectorsGen {
  const $AssetsVectorsGen();

  /// Directory path: assets/vectors/auth
  $AssetsVectorsAuthGen get auth => const $AssetsVectorsAuthGen();
}

class $AssetsIconsAuthGen {
  const $AssetsIconsAuthGen();

  /// File path: assets/icons/auth/facebook_logo.svg
  SvgGenImage get facebookLogo =>
      const SvgGenImage('assets/icons/auth/facebook_logo.svg');

  /// File path: assets/icons/auth/google_logo.svg
  SvgGenImage get googleLogo =>
      const SvgGenImage('assets/icons/auth/google_logo.svg');

  /// List of all assets
  List<SvgGenImage> get values => [facebookLogo, googleLogo];
}

class $AssetsIconsCommonGen {
  const $AssetsIconsCommonGen();

  /// File path: assets/icons/common/logo-2.svg
  SvgGenImage get logo2 => const SvgGenImage('assets/icons/common/logo-2.svg');

  /// File path: assets/icons/common/logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/icons/common/logo.svg');

  /// List of all assets
  List<SvgGenImage> get values => [logo2, logo];
}

class $AssetsIconsShellGen {
  const $AssetsIconsShellGen();

  /// File path: assets/icons/shell/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/shell/home.svg');

  /// File path: assets/icons/shell/meditate.svg
  SvgGenImage get meditate =>
      const SvgGenImage('assets/icons/shell/meditate.svg');

  /// File path: assets/icons/shell/music.svg
  SvgGenImage get music => const SvgGenImage('assets/icons/shell/music.svg');

  /// File path: assets/icons/shell/profile.svg
  SvgGenImage get profile =>
      const SvgGenImage('assets/icons/shell/profile.svg');

  /// File path: assets/icons/shell/sleep.svg
  SvgGenImage get sleep => const SvgGenImage('assets/icons/shell/sleep.svg');

  /// List of all assets
  List<SvgGenImage> get values => [home, meditate, music, profile, sleep];
}

class $AssetsImagesAuthGen {
  const $AssetsImagesAuthGen();

  /// File path: assets/images/auth/eye_close.png
  AssetGenImage get eyeClose =>
      const AssetGenImage('assets/images/auth/eye_close.png');

  /// File path: assets/images/auth/visible.png
  AssetGenImage get visible =>
      const AssetGenImage('assets/images/auth/visible.png');

  /// List of all assets
  List<AssetGenImage> get values => [eyeClose, visible];
}

class $AssetsVectorsAuthGen {
  const $AssetsVectorsAuthGen();

  /// File path: assets/vectors/auth/login_background_vector.svg
  SvgGenImage get loginBackgroundVector =>
      const SvgGenImage('assets/vectors/auth/login_background_vector.svg');

  /// File path: assets/vectors/auth/welcome_vector.svg
  SvgGenImage get welcomeVector =>
      const SvgGenImage('assets/vectors/auth/welcome_vector.svg');

  /// List of all assets
  List<SvgGenImage> get values => [loginBackgroundVector, welcomeVector];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsVectorsGen vectors = $AssetsVectorsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
