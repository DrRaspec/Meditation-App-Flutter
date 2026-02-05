import 'package:flutter/material.dart';
import 'package:flutter_adaptive_kit/flutter_adaptive_kit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meditation_app/core/extensions/theme_extension.dart';
import 'package:meditation_app/core/widgets/glass_button.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation_app/core/navigation/route_paths.dart';
import 'package:meditation_app/core/widgets/glass_container.dart';
import 'package:meditation_app/core/widgets/native_ios_blur.dart';
import 'package:meditation_app/features/auth/presentation/controllers/login_controller.dart';
import 'package:meditation_app/gen/assets.gen.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final insets = MediaQuery.of(context).viewInsets.bottom;
    final hasKeyboard = insets > 0;
    final extraVerticalPadding = 16 + 24 + insets;

    final kb = MediaQuery.viewInsetsOf(context).bottom;

    // ShadowLog.d(
    //   'Login screen build',
    //   tag: 'Login Page',
    //   fields: {'body_medium_font_size': context.textTheme.bodyMedium?.fontSize},
    // );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: kb > 0
          ? null
          : SafeArea(
              minimum: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: SizedBox(
                width: double.infinity,
                child: GlassButton(
                  iosOnly: true,
                  iosBlurStyle: IosBlurStyle.systemChromeMaterial,
                  height: 63,
                  borderRadius: 31.5,
                  label: 'LOG IN',
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 1),
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.9),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              Assets.vectors.auth.loginBackgroundVector.path,
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                physics: hasKeyboard
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(20, 16, 20, 16 + kb),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        MediaQuery.of(context).size.height -
                        extraVerticalPadding,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.go(RoutePaths.authWelcome);
                              }
                            },
                            child: GlassContainer(
                              iosOnly: true,
                              iosBlurStyle:
                                  IosBlurStyle.systemUltraThinMaterial,
                              width: 55,
                              height: 55,
                              borderRadius: 27,
                              borderColor: const Color(0xFFEBEAEC),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                ],
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18,
                              ),
                            ),
                          ),
                        ),

                        24.gapH,

                        Text(
                          'Welcome Back!',
                          style: context.textTheme.headlineLarge,
                        ),

                        32.gapH,

                        GlassButton(
                          iosOnly: true,
                          iosBlurStyle: IosBlurStyle.systemChromeMaterial,
                          height: 63,
                          borderRadius: 32,
                          label: 'CONTINUE WITH FACEBOOK',
                          textStyle: context.textTheme.bodyMedium?.copyWith(
                            color: context.colors.onPrimary,
                            fontWeight: .w400,
                          ),
                          contentSpacing: 32,
                          leading: SvgPicture.asset(
                            Assets.icons.auth.facebookLogo.path,
                            width: 12,
                            height: 24,
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 1),
                              Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.9),
                            ],
                          ),
                          onTap: () {},
                        ),

                        20.gapH,

                        GlassButton(
                          iosOnly: true,
                          iosBlurStyle: IosBlurStyle.systemChromeMaterial,
                          height: 63,
                          borderRadius: 32,
                          label: 'CONTINUE WITH FACEBOOK',
                          textStyle: context.textTheme.bodyMedium?.copyWith(
                            color: context.colors.onSurface,
                            fontWeight: .w400,
                          ),
                          contentSpacing: 32,
                          leading: SvgPicture.asset(
                            Assets.icons.auth.googleLogo.path,
                            width: 12,
                            height: 24,
                          ),
                          borderColor: context.colors.onSurface,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(
                                context,
                              ).colorScheme.surface.withValues(alpha: 1),
                              Theme.of(
                                context,
                              ).colorScheme.surface.withValues(alpha: 0.9),
                            ],
                          ),
                          onTap: () {},
                        ),

                        Form(
                          key: formKey,
                          child: Column(children: []),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
