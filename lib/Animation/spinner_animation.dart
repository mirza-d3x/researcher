import 'dart:math';
import 'package:flutter/material.dart';

class SpinnerAnimation extends StatefulWidget {
  const SpinnerAnimation({super.key});

  @override
  SpinnerAnimationState createState() => SpinnerAnimationState();
}

class SpinnerAnimationState extends State<SpinnerAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _rocketX = -100;
  double _rocketY = 0;
  double _rocketAngle = pi / 4;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {
          _rocketX = _animation.value;
          _rocketY = -_animation.value / 2;
          _rocketAngle = pi / 4 + _animation.value / 2;
        });
      });
    _animation = Tween<double>(begin: -100, end: 500).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CustomPaint(
          painter: RocketPainter(_rocketX, _rocketY, _rocketAngle),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.repeat();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RocketPainter extends CustomPainter {
  final double x;
  final double y;
  final double angle;

  RocketPainter(this.x, this.y, this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    canvas.translate(x, size.height + y);
    canvas.rotate(angle);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 100, 200),
        const Radius.circular(10),
      ),
      paint,
    );
    canvas.drawCircle(
      const Offset(50, -30),
      30,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
