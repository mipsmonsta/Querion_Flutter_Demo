import 'package:flutter/material.dart';

class ItemFader extends StatefulWidget {
  final Widget child;
  const ItemFader({Key? key, required this.child}) : super(key: key);

  @override
  ItemFaderState createState() => ItemFaderState();
}

class ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  int position = 1;
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  void show() {
    setState(() => position = 1);
    _animationController.forward();
  }

  void hide() {
    setState(() => position = -1);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        child: widget.child,
        builder: (context, child) {
          return Transform.translate(
              offset: Offset(0, 64.0 * (1 - _animation.value) * position),
              child: Opacity(opacity: _animation.value, child: child));
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
