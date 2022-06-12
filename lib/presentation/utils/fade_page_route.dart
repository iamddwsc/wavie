import 'package:flutter/cupertino.dart';

import '../../data/models/boxes.dart';

class FadePageRouteBuilder extends PageRouteBuilder {
  final WidgetBuilder child;
  @override
  final RouteSettings settings;
  final bool isAlwaysDown;

  FadePageRouteBuilder(
      {required this.child, required this.settings, this.isAlwaysDown = true})
      : super(
            transitionDuration: const Duration(milliseconds: 450),
            reverseTransitionDuration: const Duration(milliseconds: 450),
            pageBuilder: (context, animation, secondaryAnimation) =>
                child(context),
            settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    {
      var curve = Curves.ease;
      var tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
      bool isAlwaysDownKey = false;
      try {
        var box = Boxes.getIsAlwaysDown();
        isAlwaysDownKey = box.get('isAlwaysDownKey') ?? false;
      } catch (e) {
        print(e);
      }
      if (animation.status == AnimationStatus.reverse &&
          isAlwaysDown == true &&
          isAlwaysDownKey == true) {
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
              .animate(animation),
          child: child,
        );
      }

      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    }
  }
}
