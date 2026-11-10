import 'dart:async';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  int _progress = 42;
  String _statusMessage = 'Initialisation atelier...';
  Timer? _timer;
  late AnimationController _pulseController;

  final List<Map<String, dynamic>> _steps = [
    {'p': 58, 'text': 'Chargement des recettes végétales...'},
    {'p': 76, 'text': 'Vérification des alertes Uniwax...'},
    {'p': 92, 'text': 'Prêt pour l’atelier du jour !'},
    {'p': 100, 'text': 'Ouverture sécurisée...'},
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    int stepIdx = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      if (stepIdx < _steps.length) {
        setState(() {
          _progress = _steps[stepIdx]['p'];
          _statusMessage = _steps[stepIdx]['text'];
        });
        if (_progress >= 100) {
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 600), _navigateToAuth);
        }
        stepIdx++;
      }
    });
  }

  void _navigateToAuth() {
    _timer?.cancel();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, anim, secAnim) => const AuthScreen(),
          transitionsBuilder: (context, animation, secAnim, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sand,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.2, -0.4),
              radius: 1.2,
              colors: [
                Color(0x33C85A32),
                Color(0x1AC85A32),
                AppColors.sand,
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Bouton Passer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'BASSAM · CI',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                        color: Color(0xFF5C3327),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _navigateToAuth,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'Passer',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7D4432),
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.chevron_right, size: 14, color: AppColors.terracotta),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Médaillon Animé J.COCO
              Column(
                children: [
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      final scale = 1.0 + (_pulseController.value * 0.08);
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.terracotta.withOpacity(0.35),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.terracotta.withOpacity(0.25),
                                blurRadius: 28,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [AppColors.terracotta, Color(0xFF9F3E1B)],
                                ),
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(
                                  color: const Color(0xFFECD5C7),
                                  width: 2,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x59A03C19),
                                    blurRadius: 18,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.water_drop_outlined,
                                    color: Color(0xFFECD5C7),
                                    size: 38,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'BATIK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'J.COCO',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF2B140C),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Text(
                    'Atelier Batik',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: AppColors.terracotta,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    width: 260,
                    child: Text(
                      'Système nomade d’atelier textile & gestion de manufacture professionnelle',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF5C3327),
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.terracotta.withOpacity(0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock_outline, size: 14, color: AppColors.terracotta),
                        SizedBox(width: 6),
                        Text(
                          'Accès sécurisé réservé à l’équipe',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3D1F14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Bas : Progression & Bouton Déverrouiller
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.terracotta,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _statusMessage,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF381A11),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$_progress%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: AppColors.terracotta,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 8,
                      color: Colors.white.withOpacity(0.6),
                      child: Stack(
                        children: [
                          FractionallySizedBox(
                            widthFactor: (_progress / 100).clamp(0.0, 1.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFFE58B68), AppColors.terracotta],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '✓ Base locale',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.emeraldSuccess),
                      ),
                      Text(
                        '⟳ Cuves indigo',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.terracotta),
                      ),
                      Text(
                        '○ Session PIN',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF8C6050)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.terracotta,
                        foregroundColor: Colors.white,
                        elevation: 6,
                        shadowColor: AppColors.terracotta.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _navigateToAuth,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'DÉVERROUILLER L’ATELIER',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
