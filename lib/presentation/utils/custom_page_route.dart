import 'package:flutter/material.dart';

import '../../data/models/boxes.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  final bool isAlwaysDown;

  CustomPageRoute(
      {required this.child, required this.direction, this.isAlwaysDown = false})
      : super(
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    final bool isAlwaysDownKey =
        Boxes.getIsAlwaysDown().get('isAlwaysDownKey') ?? false;
    if (animation.status == AnimationStatus.reverse &&
        isAlwaysDown == true &&
        isAlwaysDownKey == true) {
      return SlideTransition(
        position: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
            .animate(animation),
        child: child,
      );
    }
    return SlideTransition(
      position: Tween<Offset>(begin: getBeginOffset(), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }

  Offset getBeginOffset() {
    switch (direction) {
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.left:
        return Offset(-1, 0);
      case AxisDirection.right:
        return Offset(1, 0);
    }
  }
}
