import 'package:flutter/material.dart';
import 'package:flutter_adaptive_kit/flutter_adaptive_kit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation_app/core/extensions/theme_extension.dart';
import 'package:meditation_app/core/navigation/route_paths.dart';
import 'package:meditation_app/core/widgets/glass_button.dart';
import 'package:meditation_app/core/widgets/glass_container.dart';
import 'package:meditation_app/core/widgets/native_ios_blur.dart';
import 'package:meditation_app/features/auth/presentation/controllers/register_controller.dart';
import 'package:meditation_app/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:meditation_app/gen/assets.gen.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();
    final userController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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
                              borderColor: context.colors.outline,
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
                          'Create your account',
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
                          label: 'CONTINUE WITH GOOGLE',
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
                          borderColor: context.colors.outline,
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

                        36.gapH,

                        Text(
                          'OR REGISTER WITH WITH EMAIL',
                          style: context.textTheme.bodyMedium,
                        ),

                        36.gapH,

                        Form(
                          key: loginFormKey,
                          child: Column(
                            children: [
                              AuthTextFormField(
                                controller: userController,
                                hintText: 'Username',
                                hintStyle: context.textTheme.bodyMedium
                                    ?.copyWith(fontSize: 16),
                                validator: controller.userValidator,
                                showErrorText: true,
                                showValidationIcon: true,
                                textStyle: context.textTheme.bodyMedium
                                    ?.copyWith(fontSize: 16),
                              ),

                              16.gapH,

                              AuthTextFormField(
                                controller: emailController,
                                hintText: 'Email address',
                                hintStyle: context.textTheme.bodyMedium
                                    ?.copyWith(fontSize: 16),
                                validator: controller.emailValidator,
                                showErrorText: true,
                                showValidationIcon: true,
                                textStyle: context.textTheme.bodyMedium
                                    ?.copyWith(fontSize: 16),
                              ),

                              16.gapH,

                              AuthTextFormField(
                                controller: passwordController,
                                hintText: 'Password',
                                hintStyle: context.textTheme.bodyMedium
                                    ?.copyWith(fontSize: 16),
                                validator: controller.passwordValidator,
                                showValidationIcon: false,
                                showErrorText: true,
                                isPassword: true,
                                textStyle: context.textTheme.bodyMedium
                                    ?.copyWith(fontSize: 16),
                              ),

                              32.gapH,

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  spacing: 4,
                                  runSpacing: 2,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      'I agree to the',
                                      style: context.textTheme.bodyMedium,
                                    ),
                                    _PolicyLink(
                                      label: 'Privacy Policy',
                                      onTap: controller.openPrivacyPolicy,
                                      style: context.textTheme.bodyMedium,
                                      color: context.colors.primary,
                                    ),
                                    Text(
                                      'and',
                                      style: context.textTheme.bodyMedium,
                                    ),
                                    _PolicyLink(
                                      label: 'Terms of Service',
                                      onTap: controller.openTermsOfService,
                                      style: context.textTheme.bodyMedium,
                                      color: context.colors.primary,
                                    ),
                                  ],
                                ),
                              ),

                              32.gapH,

                              SizedBox(
                                width: double.infinity,
                                child: GlassButton(
                                  iosOnly: true,
                                  iosBlurStyle:
                                      IosBlurStyle.systemChromeMaterial,
                                  height: 63,
                                  borderRadius: 31.5,
                                  label: 'GET STARTED',
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.primary
                                          .withValues(alpha: 1),
                                      Theme.of(context).colorScheme.primary
                                          .withValues(alpha: 0.9),
                                    ],
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
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

class _PolicyLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final TextStyle? style;
  final Color color;

  const _PolicyLink({
    required this.label,
    required this.onTap,
    required this.style,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Text(
        label,
        style: style?.copyWith(
          color: color,
          decoration: TextDecoration.underline,
          decorationThickness: 1.4,
        ),
      ),
    );
  }
}
