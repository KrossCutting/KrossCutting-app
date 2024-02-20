import 'package:flutter/material.dart';

class MovingIcon extends StatefulWidget {
  final bool isVertical;
  final Icon icon;

  const MovingIcon({super.key, required this.isVertical, required this.icon});

  @override
  _MovingIcon createState() => _MovingIcon();
}

class _MovingIcon extends State<MovingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: widget.isVertical ? const Offset(0, -5) : const Offset(-10, 0),
      end: widget.isVertical ? const Offset(0, 5) : const Offset(10, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: _animation.value,
          child: child,
        );
      },
      child: widget.icon,
    );
  }
}
