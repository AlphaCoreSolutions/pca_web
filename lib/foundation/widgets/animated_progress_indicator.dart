import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedProgressIndicator extends StatefulWidget {
  final double progress;
  final Color primaryColor;
  final Color backgroundColor;
  final double size;
  final double strokeWidth;
  final bool showPercentage;

  const AnimatedProgressIndicator({
    super.key,
    required this.progress,
    this.primaryColor = const Color(0xFFF0B81B),
    this.backgroundColor = Colors.grey,
    this.size = 60.0,
    this.strokeWidth = 4.0,
    this.showPercentage = true,
  });

  @override
  State<AnimatedProgressIndicator> createState() =>
      _AnimatedProgressIndicatorState();
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();

    // Rotation animation for the background
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Scale animation for pulse effect
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_rotationController, _scaleController]),
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_scaleController.value * 0.1),
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background circle with rotation
                Transform.rotate(
                  angle: _rotationController.value * 2 * math.pi,
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          widget.backgroundColor.withOpacity(0.3),
                          widget.backgroundColor.withOpacity(0.1),
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                  ),
                ),

                // Progress circle
                SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: CircularProgressIndicator(
                    value: widget.progress,
                    strokeWidth: widget.strokeWidth,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      widget.primaryColor,
                    ),
                    backgroundColor: widget.backgroundColor.withOpacity(0.3),
                  ),
                ),

                // Center content
                if (widget.showPercentage)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${(widget.progress * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: widget.size * 0.18,
                          fontWeight: FontWeight.bold,
                          color: widget.primaryColor,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(height: widget.size * 0.02),
                      Icon(
                        Icons.flash_on,
                        color: widget.primaryColor.withOpacity(0.7),
                        size: widget.size * 0.15,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LoadingDots extends StatefulWidget {
  final Color color;
  final double size;

  const LoadingDots({
    super.key,
    this.color = const Color(0xFFF0B81B),
    this.size = 8.0,
  });

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();

    // Start animations with staggered delays
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: widget.size * 0.25),
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withOpacity(
                  0.3 + (_animations[index].value * 0.7),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
