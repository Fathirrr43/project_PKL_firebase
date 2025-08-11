// ignore_for_file: unnecessary_import

import 'dart:async';
import 'dart:math' as math; // Import math with prefix
import 'package:flutter/material.dart';
import '/auth/onboarding.dart'; // Import OnBoarding instead of Login

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _assembleController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _assembleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeController.forward();
    Future.delayed(
      const Duration(milliseconds: 800),
      () => _assembleController.forward(),
    );

    Timer(const Duration(milliseconds: 3500), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => const OnBoarding())); // Navigate to OnBoarding
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _assembleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: AnimatedBackground()),
          Center(
            child: FadeTransition(
              opacity: _fadeController,
              child: AnimatedBuilder(
                animation: _assembleController,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // Glowing crescent moon
                      Positioned(
                        top: 80,
                        child: Opacity(
                          opacity: _assembleController.value,
                          child: Icon(
                            Icons.brightness_2,
                            size: 100,
                            color: Colors.amber.shade100.withOpacity(0.6),
                          ),
                        ),
                      ),
                      // Tridaya logo image
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.25,
                        child: FadeTransition(
                          opacity: _assembleController,
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 120,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset:
                            Offset.lerp(
                              const Offset(-100, -100),
                              const Offset(-80, -80),
                              _assembleController.value,
                            )!,
                        child: Transform.rotate(
                          angle: math.pi / 6 * _assembleController.value, // Use math.pi
                          child: _LogoPiece(
                            color: Colors.blue.shade700.withOpacity(
                              _assembleController.value,
                            ),
                            size: 80,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset:
                            Offset.lerp(
                              const Offset(80, -80),
                              const Offset(64, -64),
                              _assembleController.value,
                            )!,
                        child: Transform.rotate(
                          angle: -math.pi / 6 * _assembleController.value, // Use math.pi
                          child: _LogoPiece(
                            color: Colors.blue.shade400.withOpacity(
                              _assembleController.value,
                            ),
                            size: 80,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset:
                            Offset.lerp(
                              const Offset(-80, 80),
                              const Offset(-64, 64),
                              _assembleController.value,
                            )!,
                        child: Transform.rotate(
                          angle: math.pi / 3 * _assembleController.value, // Use math.pi
                          child: _LogoPiece(
                            color: Colors.blue.shade900.withOpacity(
                              _assembleController.value,
                            ),
                            size: 80,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset:
                            Offset.lerp(
                              const Offset(80, 80),
                              const Offset(64, 64),
                              _assembleController.value,
                            )!,
                        child: Transform.rotate(
                          angle: -math.pi / 3 * _assembleController.value, // Use math.pi
                          child: _LogoPiece(
                            color: Colors.blue.shade300.withOpacity(
                              _assembleController.value,
                            ),
                            size: 80,
                          ),
                        ),
                      ),
                      ScaleTransition(
                        scale: Tween<double>(begin: 0.5, end: 1.0).animate(
                          CurvedAnimation(
                            parent: _assembleController,
                            curve: Curves.elasticOut,
                          ),
                        ),
                        child: FadeTransition(
                          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _assembleController,
                              curve: Curves.easeIn,
                            ),
                          ),
                          child: _LogoPiece(
                            color: Colors.amberAccent.shade200,
                            size: 80,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 60,
                        child: Opacity(
                          opacity: _assembleController.value,
                          child: Text(
                            'Tridaya Tour & Travel',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade200,
                              shadows: [
                                Shadow(
                                  color: Colors.white.withOpacity(0.3),
                                  offset: const Offset(1, 1),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoPiece extends StatelessWidget {
  final Color color;
  final double size;
  const _LogoPiece({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 8)],
      ),
    );
  }
}

class AnimatedBackground extends StatefulWidget {
  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final math.Random _random = math.Random(); // Use math.Random

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    for (int i = 0; i < 30; i++) {
      _particles.add(Particle(random: _random));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
        ),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children:
                _particles.map((particle) {
                  final x =
                      particle.initialX + particle.speedX * _controller.value;
                  final y =
                      particle.initialY + particle.speedY * _controller.value;
                  return Positioned(
                    left: x % MediaQuery.of(context).size.width,
                    top: y % MediaQuery.of(context).size.height,
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 0.2, end: 0.8).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(
                            0.0,
                            1.0,
                            curve: Curves.easeInOut,
                          ),
                        ),
                      ),
                      child: Container(
                        width: particle.size,
                        height: particle.size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          );
        },
      ),
    );
  }
}

class Particle {
  final math.Random random; // Use math.Random
  final double initialX;
  final double initialY;
  final double size;
  final double speedX;
  final double speedY;

  Particle({required this.random})
    : initialX = random.nextDouble() * 400,
      initialY = random.nextDouble() * 800,
      size = random.nextDouble() * 3 + 1,
      speedX = random.nextDouble() * 10 - 5,
      speedY = random.nextDouble() * 10 - 5;
}
