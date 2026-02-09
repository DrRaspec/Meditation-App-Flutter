import 'package:flutter/material.dart';
import 'package:meditation_app/core/extensions/theme_extension.dart';
import 'package:meditation_app/gen/assets.gen.dart';

enum ValidationState { none, valid, invalid }

class AuthTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final bool autofocus;
  final bool enabled;
  final bool showValidationIcon;
  final bool showErrorText;
  final AutovalidateMode autovalidateMode;
  final String? Function(String value)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final double height;
  final double borderRadius;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  const AuthTextFormField({
    super.key,
    required this.controller,
    this.focusNode,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.isPassword = false,
    this.autofocus = false,
    this.enabled = true,
    this.showValidationIcon = true,
    this.showErrorText = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.contentPadding,
    this.height = 63,
    this.borderRadius = 15,
    this.textStyle,
    this.hintStyle,
  });

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  late bool _obscure;
  late ValidationState _validationState;
  FocusNode? _internalFocusNode;

  FocusNode get _focusNode => widget.focusNode ?? _internalFocusNode!;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
    _validationState = ValidationState.none;
    if (widget.focusNode == null) {
      _internalFocusNode = FocusNode();
    }
    widget.controller.addListener(_handleControllerChange);
    _updateValidationState(widget.controller.text, force: true);
  }

  @override
  void didUpdateWidget(covariant AuthTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_handleControllerChange);
      widget.controller.addListener(_handleControllerChange);
      _updateValidationState(widget.controller.text, force: true);
    }
    if (oldWidget.isPassword != widget.isPassword) {
      _obscure = widget.isPassword;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChange);
    _internalFocusNode?.dispose();
    super.dispose();
  }

  void _handleControllerChange() {
    _updateValidationState(widget.controller.text);
  }

  void _handleChanged(String value) {
    widget.onChanged?.call(value);
    _updateValidationState(value);
  }

  void _toggleObscure() {
    setState(() => _obscure = !_obscure);
  }

  ValidationState _computeValidation(String value) {
    if (!widget.showValidationIcon || widget.validator == null) {
      return ValidationState.none;
    }
    if (value.trim().isEmpty) return ValidationState.none;
    final message = widget.validator!(value);
    return message == null ? ValidationState.valid : ValidationState.invalid;
  }

  void _updateValidationState(String value, {bool force = false}) {
    final nextState = _computeValidation(value);
    if (force || nextState != _validationState) {
      setState(() => _validationState = nextState);
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide.none,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: widget.height),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        obscureText: widget.isPassword ? _obscure : false,
        enableSuggestions: !widget.isPassword,
        autocorrect: !widget.isPassword,
        autofocus: widget.autofocus,
        enabled: widget.enabled,
        style:
            widget.textStyle ??
            context.text.bodyLarge?.copyWith(color: context.colors.onSurface),
        autovalidateMode: widget.autovalidateMode,
        validator: widget.validator == null
            ? null
            : (value) => widget.validator!(value ?? ''),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        onChanged: _handleChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle:
              widget.hintStyle ??
              context.text.bodyMedium?.copyWith(
                color: context.colors.onSurface.withValues(alpha: 0.5),
              ),
          filled: true,
          fillColor: context.colors.surfaceContainerHighest,
          contentPadding:
              widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border,
          focusedErrorBorder: border,
          errorStyle: widget.showErrorText
              ? null
              : const TextStyle(height: 0, fontSize: 0),
          suffixIcon: _buildSuffix(context),
        ),
      ),
    );
  }

  Widget? _buildSuffix(BuildContext context) {
    final widgets = <Widget>[];
    if (widget.showValidationIcon && widget.validator != null) {
      widgets.add(
        AnimatedValidationIcon(
          state: _validationState,
          validColor: context.colors.primary,
          invalidColor: context.colors.error,
        ),
      );
    }
    if (widget.isPassword) {
      if (widgets.isNotEmpty) {
        widgets.add(const SizedBox(width: 8));
      }
      widgets.add(
        _AnimatedEyeButton(
          isObscured: _obscure,
          color: context.colors.onSurface.withValues(alpha: 0.6),
          onTap: _toggleObscure,
        ),
      );
    }
    if (widgets.isEmpty) return null;

    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Row(mainAxisSize: MainAxisSize.min, children: widgets),
    );
  }
}

class AnimatedValidationIcon extends StatelessWidget {
  final ValidationState state;
  final Color validColor;
  final Color invalidColor;
  final double size;

  const AnimatedValidationIcon({
    super.key,
    required this.state,
    required this.validColor,
    required this.invalidColor,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    if (state == ValidationState.none) {
      return SizedBox(width: size, height: size);
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      transitionBuilder: (child, animation) {
        final scale = Tween<double>(begin: 0.85, end: 1).animate(animation);
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: scale, child: child),
        );
      },
      child: _AnimatedMark(
        key: ValueKey(state),
        state: state,
        color: state == ValidationState.valid ? validColor : invalidColor,
        size: size,
      ),
    );
  }
}

class _AnimatedMark extends StatelessWidget {
  final ValidationState state;
  final Color color;
  final double size;

  const _AnimatedMark({
    super.key,
    required this.state,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 320),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return CustomPaint(
          size: Size.square(size),
          painter: state == ValidationState.valid
              ? _CheckMarkPainter(progress: value, color: color)
              : _XMarkPainter(progress: value, color: color),
        );
      },
    );
  }
}

class _CheckMarkPainter extends CustomPainter {
  final double progress;
  final Color color;

  const _CheckMarkPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final path = Path()
      ..moveTo(size.width * 0.12, size.height * 0.55)
      ..lineTo(size.width * 0.42, size.height * 0.78)
      ..lineTo(size.width * 0.88, size.height * 0.26);

    final metric = path.computeMetrics().first;
    final drawPath = metric.extractPath(0, metric.length * progress);
    canvas.drawPath(drawPath, paint);
  }

  @override
  bool shouldRepaint(covariant _CheckMarkPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

class _XMarkPainter extends CustomPainter {
  final double progress;
  final Color color;

  const _XMarkPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final path1 = Path()
      ..moveTo(size.width * 0.2, size.height * 0.2)
      ..lineTo(size.width * 0.8, size.height * 0.8);
    final path2 = Path()
      ..moveTo(size.width * 0.2, size.height * 0.8)
      ..lineTo(size.width * 0.8, size.height * 0.2);

    if (progress <= 0.5) {
      final metric = path1.computeMetrics().first;
      final local = progress / 0.5;
      canvas.drawPath(metric.extractPath(0, metric.length * local), paint);
    } else {
      canvas.drawPath(path1, paint);
      final metric = path2.computeMetrics().first;
      final local = (progress - 0.5) / 0.5;
      canvas.drawPath(metric.extractPath(0, metric.length * local), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _XMarkPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

class _AnimatedEyeButton extends StatelessWidget {
  final bool isObscured;
  final Color color;
  final VoidCallback onTap;

  const _AnimatedEyeButton({
    required this.isObscured,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 20,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 320),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          final scale = Tween<double>(begin: 0.92, end: 1).animate(animation);
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: scale, child: child),
          );
        },
        child: _EyeImage(
          key: ValueKey(isObscured),
          asset: isObscured
              ? Assets.images.auth.eyeClose
              : Assets.images.auth.visible,
          color: color,
        ),
      ),
    );
  }
}

class _EyeImage extends StatelessWidget {
  final AssetGenImage asset;
  final Color color;

  const _EyeImage({super.key, required this.asset, required this.color});

  @override
  Widget build(BuildContext context) {
    return asset.image(
      width: 20,
      height: 20,
      color: color,
      colorBlendMode: BlendMode.srcIn,
      filterQuality: FilterQuality.high,
    );
  }
}
