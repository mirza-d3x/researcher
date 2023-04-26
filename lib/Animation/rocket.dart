import 'dart:async';
import 'package:flutter/material.dart';

class RocketAnimation extends StatefulWidget {
  const RocketAnimation({super.key});

  @override
  RocketAnimationState createState() => RocketAnimationState();
}

class RocketAnimationState extends State<RocketAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.1),
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _x = 150;
  double _y = 530;
  void _moveRocket(double dx, double dy) {
    setState(() {
      _x += dx;
      _y += dy;
    });
  }

  bool isShooting = false;
  late Timer timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flying Rocket'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sky.jpg'),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: _y,
              left: _x,
              child: SlideTransition(
                position: _animation,
                child: Transform.scale(
                  scale: 5,
                  child: Image.asset(
                    'assets/rocket.png',
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: _y + 30,
              top: _x + 30,
              child: isShooting
                  ? CustomPaint(painter: BulletPainter())
                  : const SizedBox.shrink(),
            ),
            Positioned(
              left: _y + 70,
              top: _x + 30,
              child: isShooting
                  ? CustomPaint(painter: BulletPainter())
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onLongPress: () {
              timer = Timer.periodic(
                const Duration(milliseconds: 50),
                (timer) {
                  _moveRocket(-5, 0);
                },
              );
            },
            onLongPressEnd: (details) {
              timer.cancel();
            },
            child: IconButton(
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                color: Colors.white,
              ),
              iconSize: 50,
              onPressed: () {
                _moveRocket(-5, 0);
              },
            ),
          ),
          GestureDetector(
            onLongPress: () {
              timer = Timer.periodic(
                const Duration(milliseconds: 50),
                (timer) {
                  _moveRocket(0, -5);
                },
              );
            },
            onLongPressEnd: (details) {
              timer.cancel();
            },
            child: IconButton(
              icon: const Icon(
                Icons.arrow_circle_up_rounded,
                color: Colors.white,
              ),
              iconSize: 50,
              onPressed: () {
                _moveRocket(0, -5);
              },
            ),
          ),
          GestureDetector(
            onLongPress: () {
              timer = Timer.periodic(
                const Duration(milliseconds: 50),
                (timer) {
                  _moveRocket(5, 0);
                },
              );
            },
            onLongPressEnd: (details) {
              timer.cancel();
            },
            child: IconButton(
              icon: const Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.white,
              ),
              iconSize: 50,
              onPressed: () {
                _moveRocket(5, 0);
              },
            ),
          ),
          GestureDetector(
            onLongPress: () {
              timer = timer = Timer.periodic(
                const Duration(milliseconds: 50),
                (timer) {
                  _moveRocket(0, 5);
                },
              );
            },
            onLongPressEnd: (details) {
              timer.cancel();
            },
            child: IconButton(
              icon: const Icon(
                Icons.arrow_circle_down,
                color: Colors.white,
              ),
              iconSize: 50,
              onPressed: () {
                _moveRocket(0, 5);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BulletPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.red;
    canvas.drawCircle(const Offset(5, 5), 5, paint);
  }

  @override
  bool shouldRepaint(BulletPainter oldDelegate) {
    return false;
  }
}
