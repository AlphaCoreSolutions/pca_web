import 'package:flutter/material.dart';
import 'package:pca_website/foundation/widgets/animated_progress_indicator.dart';
import 'package:pca_website/foundation/widgets/floating_particles.dart';
import 'package:pca_website/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _progressController;
  late Animation<double> _logoAnimation;
  late Animation<double> _progressAnimation;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();

    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Progress animation controller
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Logo fade in and scale animation
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    // Progress animation
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    // Start animations
    _startSplashSequence();
  }

  void _startSplashSequence() async {
    // Start logo animation
    _logoController.forward();

    // Wait a bit then start progress
    await Future.delayed(const Duration(milliseconds: 800));
    _progressController.forward();

    // Listen to progress animation and update progress value
    _progressController.addListener(() {
      setState(() {
        _progress = _progressAnimation.value;
      });
    });

    // Navigate to home screen when animation completes
    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top status bar progress (linear)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 8,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    minHeight: 6,
                    value: _progress.clamp(0.0, 1.0),
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation(Color(0xFFF0B81B)),
                  ),
                ),
              ),
            ),
          ),
          // Background gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  const Color(0xFFF0B81B).withOpacity(0.1),
                ],
              ),
            ),
          ),

          // Floating particles background
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
              // Logo with animation
              AnimatedBuilder(
                animation: _logoAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 0.8 + (_logoAnimation.value * 0.2),
                    child: Opacity(
                      opacity: _logoAnimation.value,
                      child: Container(
                        width: isSmallScreen ? 140 : 180,
                        height: isSmallScreen ? 140 : 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFF0B81B).withOpacity(0.3),
                              blurRadius: 25,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/logo2.jpeg',
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0B81B),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Icon(
                                  Icons.business,
                                  size: isSmallScreen ? 70 : 90,
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

              const SizedBox(height: 30),

              // Company name with animation
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
                            fontSize: isSmallScreen ? 28 : 36,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF0B81B),
                            fontFamily: 'Cairo',
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Power Construction Arabia',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
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

              const SizedBox(height: 50),

              // Progress indicator
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _progressAnimation.value > 0 ? 1.0 : 0.0,
                    child: Column(
                      children: [
                        // Enhanced progress indicator
                        AnimatedProgressIndicator(
                          progress: _progress,
                          size: 80,
                          strokeWidth: 6,
                          primaryColor: const Color(0xFFF0B81B),
                          backgroundColor: Colors.grey,
                          showPercentage: true,
                        ),

                        const SizedBox(height: 30),

                        // Loading text with animated dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _statusForProgress(_progress),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const LoadingDots(
                              color: Color(0xFFF0B81B),
                              size: 6,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),

              // Powered by text
              AnimatedBuilder(
                animation: _logoAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _logoAnimation.value * 0.7,
                    child: Text(
                      'Powered by Flutter',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontFamily: 'Cairo',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _statusForProgress(double p) {
    if (p < 0.20) return 'Initializing...';
    if (p < 0.45) return 'Loading assets...';
    if (p < 0.70) return 'Preparing interface...';
    if (p < 0.90) return 'Finalizing setup...';
    return 'Launching';
  }
}
