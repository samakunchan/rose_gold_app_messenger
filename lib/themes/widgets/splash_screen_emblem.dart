import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/extensions/front_theme_extension.dart';
import 'package:rose_gold_app_messenger/themes/static_spacing.dart';
import 'package:rose_gold_app_messenger/themes/widgets/splash_screen_main_title.dart';

// import 'package:rose_gold_app_chat/presentation/front_widgets/splash_screen_main_title.dart';
// import 'package:rose_gold_app_chat/themes/themes.dart';

const double kMedallionRadius = 140;

class SplashScreenEmblem extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;

    return Column(
      spacing: AppSpacing.spaceXl.value,
      children: <Widget>[
        /// Emblem medallion with Ambient RoseGold & Jewelry Detailing
        SizedBox(
          width: kMedallionRadius + 24,
          height: kMedallionRadius + 24,
          child: Stack(
            alignment: .center,
            clipBehavior: Clip.none,
            children: <Widget>[
              /// Outer Bezel Medallion
              Container(
                width: kMedallionRadius,
                height: kMedallionRadius,
                decoration: BoxDecoration(
                  shape: .circle,
                  border: frontTheme.border,
                  color: frontTheme.medallionDialColor,
                  boxShadow: frontTheme.medallionShadows,
                ),
                child: Center(
                  /// Inner Cameo Dial
                  child: Container(
                    width: 106,
                    height: 106,
                    decoration: BoxDecoration(
                      shape: .circle,
                      border: frontTheme.medallionInnerBorder,
                      gradient: frontTheme.medallionInnerGradient,
                    ),
                    child: Center(
                      /// Shiny Metallic Icon via ShaderMask
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: frontTheme.medallionGradient.createShader,
                        child: const Icon(
                          Icons.auto_awesome,
                          size: 46,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              /// Top-Right Floating Star Sparkle (Stitch design signature)
              Positioned(
                top: 4,
                right: 12,
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: frontTheme.medallionGradient.createShader,
                  child: const Icon(
                    Icons.auto_awesome,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// Title & Tagline
        const SplashScreenMainTitle(title: 'R O S E O R', tagline: 'HAUTE MESSAGERIE PRIVÉE'),
      ],
    );
  }
}
