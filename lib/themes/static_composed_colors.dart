// ============================================================================
// GRADIENTS (Tailwind: Idle & Pressed Button States)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';

/// Tailwind "bg-gradient-to-r from-primary-container via-surface-tint to-primary" (Default idle state)
const LinearGradient kLightElevatedButtonGradient = LinearGradient(
  colors: <Color>[
    kLightPrimaryContainerColor,
    kLightSurfaceTintColor,
    kLightPrimaryColor,
  ],
);

const LinearGradient kLightSubmitButtonGradient = LinearGradient(
  colors: <Color>[
    kLightPrimaryColor,
    kLightPrimaryContainerColor,
    kLightPrimaryColor,
  ],
  stops: <double>[0, .9, 1],
);

/// Tailwind "bg-gradient-to-r from-primary via-primary-container to-primary" (Pressed state)
const LinearGradient kLightElevatedButtonPressedGradient = LinearGradient(
  colors: <Color>[
    kLightPrimaryColor,
    kLightPrimaryContainerColor,
    kLightPrimaryColor,
  ],
);

/// Dark variant "bg-gradient-to-r from-primary-container via-surface-tint to-primary" (Default idle state)
const LinearGradient kDarkElevatedButtonGradient = LinearGradient(
  begin: .topLeft,
  end: .bottomRight,
  colors: <Color>[
    kDarkPrimaryContainerColor,
    kDarkPrimaryColor,
    kDarkPrimaryContainerColor,
  ],
  stops: <double>[0, .5, 1],
);

const LinearGradient kLightBubbleGradient = kDarkElevatedButtonGradient;
const LinearGradient kDarkBubbleGradient = kDarkElevatedButtonGradient;

// A revoir pour faire un jolie gradient en dark mode pour les bulles.
// const LinearGradient kDarkBubbleGradient = LinearGradient(
//   begin: .topLeft,
//   end: .bottomRight,
//   colors: <Color>[
//     kDarkPrimaryContainerColor,
//     kDarkPrimaryColor,
//     kDarkPrimaryColor,
//     kDarkPrimaryColor,
//     kDarkPrimaryColor,
//     kDarkPrimaryContainerColor,
//   ],
//   stops: [0, .3, .5, .8, 1],
// );

/// Dark variant "bg-gradient-to-r from-primary via-primary-container to-primary" (Pressed state)
const LinearGradient kDarkElevatedButtonPressedGradient = LinearGradient(
  colors: <Color>[
    kDarkPrimaryColor,
    kDarkPrimaryContainerColor,
    kDarkPrimaryColor,
  ],
);

/// Disabled button gradient (neutral muted left to right)
const LinearGradient kDisabledElevatedButtonGradient = LinearGradient(
  colors: <Color>[kLightSurfaceContainerHighestColor, kLightSurfaceDimColor],
);

const LinearGradient kDarkDisabledElevatedButtonGradient = LinearGradient(
  colors: <Color>[kDarkSurfaceContainerLowColor, kDarkSurfaceContainerColor],
);

/// Screen canvas background gradient (Light): iridescent mother-of-pearl cream to soft blush warmth
const LinearGradient kLightScreenBackgroundGradient = LinearGradient(
  begin: .topCenter,
  end: .bottomCenter,
  colors: <Color>[
    Color(0xFFFCF9F4),
    Color(0xFFFAF4EE),
    Color(0xFFF7ECE4),
  ],
);

/// Screen canvas background gradient (Dark): obsidian velvet to deep espresso
const LinearGradient kDarkScreenBackgroundGradient = LinearGradient(
  begin: .topCenter,
  end: .bottomCenter,
  colors: <Color>[
    Color(0xFF161513),
    Color(0xFF1C1919),
    Color(0xFF221A1D),
  ],
);
