import 'package:flutter/material.dart';
import 'dart:math' as math;

class FloatingParticles extends StatefulWidget {
  final int particleCount;
  final Color particleColor;
  final double maxSize;
  final double minSize;

  const FloatingParticles({
    super.key,
    this.particleCount = 20,
    this.particleColor = const Color(0xFFF0B81B),
    this.maxSize = 4.0,
    this.minSize = 1.0,
  });

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<FloatingParticles>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> particles;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    particles = List.generate(widget.particleCount, (index) {
      return Particle(
        x: math.Random().nextDouble(),
        y: math.Random().nextDouble(),
        size:
            widget.minSize +
            math.Random().nextDouble() * (widget.maxSize - widget.minSize),
        speed: 0.1 + math.Random().nextDouble() * 0.3,
        opacity: 0.3 + math.Random().nextDouble() * 0.4,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlesPainter(
            particles: particles,
            animationValue: _controller.value,
            color: widget.particleColor,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class Particle {
  double x;
  double y;
  final double size;
  final double speed;
  final double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;
  final Color color;

  ParticlesPainter({
    required this.particles,
    required this.animationValue,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var particle in particles) {
      // Update particle position
      particle.y -= particle.speed * 0.01;
      if (particle.y < 0) {
        particle.y = 1.0;
        particle.x = math.Random().nextDouble();
      }

      // Calculate screen position
      final dx = particle.x * size.width;
      final dy = particle.y * size.height;

      // Create gradient effect
      paint.color = color.withOpacity(particle.opacity * (1.0 - particle.y));

      // Draw particle
      canvas.drawCircle(Offset(dx, dy), particle.size, paint);

      // Add subtle glow effect
      paint.color = color.withOpacity(
        particle.opacity * 0.3 * (1.0 - particle.y),
      );
      canvas.drawCircle(Offset(dx, dy), particle.size * 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
