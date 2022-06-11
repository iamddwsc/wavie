import 'package:flutter/material.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double scrollOffset;
  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool visible;
  final Animation<double> animation;

  const CustomHomeAppBar(
      {Key? key,
      required this.child,
      required this.controller,
      required this.visible,
      this.scrollOffset = 0.0,
      this.animation = kAlwaysCompleteAnimation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    visible ? controller.reverse() : controller.forward();

    //print(controller.view.value);
    double visible2 = 1.0;
    //controller.duration = Duration(milliseconds: 200);
    return SlideTransition(
      position: controller.drive(
          Tween<Offset>(begin: Offset.zero, end: Offset(0, -1))
              .chain(CurveTween(curve: Curves.linear)))
        ..addListener(() {
          //print(1 - controller.view.value);
          // if (controller.view.value == 0) {
          //   visible2 = false;
          // } else {
          //   visible2 = true;
          // }
          visible2 = 1 - controller.view.value;
        }),
      child: Builder(builder: (context) {
        //print(visible2);

        return Opacity(
          child: child,
          opacity: visible ? 1 : visible2,
        );
      }),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => child.preferredSize;
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _AppBarButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
