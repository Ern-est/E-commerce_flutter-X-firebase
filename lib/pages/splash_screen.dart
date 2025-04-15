import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mara_pub/pages/onboarding_screen.dart';
import '../login_screen.dart'; // Ensure this exists

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_bar_rounded,
              size: 100,
              color: Colors.amberAccent.withAlpha(
                (0.9 * 255).round(),
              ), // was withOpacity(0.9)
            ),
            const SizedBox(height: 20),
            Text(
              'MARA PUB',
              style: GoogleFonts.bebasNeue(
                fontSize: 48,
                color: Colors.amberAccent,
                letterSpacing: 6,
                fontWeight: FontWeight.w400,
                shadows: [
                  Shadow(
                    blurRadius: 15.0,
                    color: Colors.purpleAccent.withAlpha(
                      (0.6 * 255).round(),
                    ), // was withOpacity(0.6)
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
