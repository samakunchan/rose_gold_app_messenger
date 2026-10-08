import 'dart:ui';

import 'package:flutter/material.dart';

class TransparencyLayer extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          /// Transparence pour que le filtre fonctionne
          color: Colors.white.withValues(alpha: 0),
        ),
      ),
    );
  }
}
