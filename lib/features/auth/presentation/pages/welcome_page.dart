import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_adaptive_kit/flutter_adaptive_kit.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:meditation_app/features/auth/presentation/controllers/welcome_controller.dart';
import 'package:meditation_app/features/auth/presentation/widgets/welcome_wave_section.dart';
import 'package:meditation_app/gen/assets.gen.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logoSize = context.adaptive<double>(
      phone: 30,
      foldable: context.isLandscape ? 24 : 28,
      tablet: 34,
      desktop: 36,
    );
    final brandTextSize = context.adaptive<double>(
      phone: 16,
      foldable: context.isLandscape ? 14 : 15,
      tablet: 18,
      desktop: 20,
    );
    final brandGap = context.adaptive<double>(
      phone: 10,
      foldable: 8,
      tablet: 12,
      desktop: 14,
    );
    final topBrandOffset = context.adaptiveOrientation<double>(
      phonePortrait: 56,
      phoneLandscape: 20,
      tabletPortrait: 56,
      tabletLandscape: 28,
      desktopPortrait: 56,
      desktopLandscape: 28,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF8F5),
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompactHeight = constraints.maxHeight < 700;
            final heroTopFactor = context.adaptiveOrientation<double>(
              phonePortrait: isCompactHeight ? 0.16 : 0.2,
              phoneLandscape: context.isFoldable ? 0.14 : 0.16,
              tabletPortrait: 0.2,
              tabletLandscape: 0.16,
              desktopPortrait: 0.18,
              desktopLandscape: 0.15,
            );
            final heroWidthFactor = context.adaptive<double>(
              phone: context.isLandscape ? 0.52 : 0.72,
              foldable: context.isLandscape ? 0.46 : 0.64,
              tablet: context.isLandscape ? 0.42 : 0.56,
              desktop: 0.34,
            );
            final waveMaxHeight =
                constraints.maxHeight *
                context.adaptiveOrientation<double>(
                  phonePortrait: 0.72,
                  phoneLandscape: 0.58,
                  tabletPortrait: 0.68,
                  tabletLandscape: 0.56,
                  desktopPortrait: 0.62,
                  desktopLandscape: 0.52,
                );

            return Stack(
              children: [
                WelcomeWaveSection(maxHeight: waveMaxHeight),
                Positioned(
                  top: topBrandOffset,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Silent',
                        style: TextStyle(
                          fontSize: brandTextSize,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(width: brandGap),

                      SvgPicture.asset(
                        Assets.icons.common.logo.path,
                        width: logoSize,
                        height: logoSize,
                      ),

                      SizedBox(width: brandGap),

                      Text(
                        'Moon',
                        style: TextStyle(
                          fontSize: brandTextSize,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: constraints.maxHeight * heroTopFactor,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.vectors.auth.welcomeVector.path,
                      width: constraints.maxWidth * heroWidthFactor,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
