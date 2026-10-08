import 'package:flutter/material.dart';

class AuthAnimatedController {
  static Widget transitionBuilder(Widget child, Animation<double> animation) {
    final bool isRegister = child.key == const ValueKey<String>('register_form');
    final Offset beginOffset = isRegister ? const Offset(0.08, 0) : const Offset(-0.08, 0);

    final Animation<Offset> slideAnimation = Tween<Offset>(begin: beginOffset, end: .zero).animate(
      CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: SlideTransition(position: slideAnimation, child: child),
    );
  }

  static Widget layoutBuilder(Widget? currentChild, List<Widget> previousChildren) {
    return Stack(
      alignment: .topCenter,
      children: <Widget>[...previousChildren, ?currentChild],
    );
  }
}
