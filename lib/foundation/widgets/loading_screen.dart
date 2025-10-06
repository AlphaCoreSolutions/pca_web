import 'package:flutter/material.dart';
import 'package:pca_website/foundation/widgets/animated_progress_indicator.dart';
import 'package:pca_website/foundation/widgets/floating_particles.dart';

class LoadingScreen extends StatefulWidget {
  final String? message;
  final bool showLogo;
  final Color backgroundColor;
  final Color primaryColor;
  final Duration progressDuration;
  final VoidCallback? onComplete;

  const LoadingScreen({
    super.key,
    this.message,
    this.showLogo = true,
    this.backgroundColor = Colors.white,
    this.primaryColor = const Color(0xFFF0B81B),
    this.progressDuration = const Duration(milliseconds: 3000),
    this.onComplete,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _progressController;
  late final Animation<double> _logoAnimation;
  late final Animation<double> _progressAnimation;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: widget.progressDuration,
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _startSequence();
  }

  void _startSequence() async {
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _progressController.forward();

    _progressController.addListener(() {
      setState(() {
        _progress = _progressAnimation.value;
      });
    });

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  widget.backgroundColor,
                  widget.primaryColor.withOpacity(0.05),
                ],
              ),
            ),
          ),

          // Floating particle background
          const Positioned.fill(
            child: FloatingParticles(
              particleCount: 15,
              particleColor: Color(0xFFF0B81B),
              maxSize: 3.0,
              minSize: 1.0,
            ),
          ),

          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.showLogo) ...[
                AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 0.8 + (_logoAnimation.value * 0.2),
                      child: Opacity(
                        opacity: _logoAnimation.value,
                        child: Container(
                          width: isSmallScreen ? 90 : 110,
                          height: isSmallScreen ? 90 : 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: widget.primaryColor.withOpacity(0.25),
                                blurRadius: 18,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.asset(
                              'assets/images/pca_logo.jpg',
                              fit: BoxFit.contain,
                              filterQuality: FilterQuality.high,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: widget.primaryColor,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Icon(
                                    Icons.business,
                                    size: isSmallScreen ? 45 : 55,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoAnimation.value,
                      child: Column(
                        children: [
                          Text(
                            'PCA',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 22 : 28,
                              fontWeight: FontWeight.bold,
                              color: widget.primaryColor,
                              fontFamily: 'Cairo',
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Power Construction Arabia',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 12 : 14,
                              color: Colors.grey[700],
                              fontFamily: 'Cairo',
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),
              ],

              // Progress
              AnimatedProgressIndicator(
                progress: _progress,
                size: isSmallScreen ? 60 : 70,
                strokeWidth: 6,
                primaryColor: widget.primaryColor,
                backgroundColor: Colors.grey,
                showPercentage: true,
              ),

              const SizedBox(height: 20),

              if (widget.message != null) ...[
                Text(
                  widget.message!,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    color: Colors.grey[600],
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
              ],

              const LoadingDots(color: Color(0xFFF0B81B), size: 6),

              const SizedBox(height: 18),

              AnimatedBuilder(
                animation: _logoAnimation,
                builder: (context, child) => Opacity(
                  opacity: _logoAnimation.value * 0.7,
                  child: Text(
                    'Powered by Flutter',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OverlayLoadingWidget extends StatelessWidget {
  final String? message;
  final bool isVisible;

  const OverlayLoadingWidget({super.key, this.message, this.isVisible = true});

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AnimatedProgressIndicator(
                progress: 0.0,
                size: 50,
                strokeWidth: 3,
                showPercentage: false,
              ),
              if (message != null) ...[
                const SizedBox(height: 15),
                Text(
                  message!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
