import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mara_pub/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mara_pub/firebase_options.dart';
import 'package:mara_pub/models/cart_model.dart';
import 'package:mara_pub/pages/splash_screen.dart';
import 'package:mara_pub/pages/onboarding_screen.dart';
import 'package:mara_pub/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getInitialScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenOnboarding = prefs.getBool('seenOnboarding') ?? false;

    if (!hasSeenOnboarding) {
      return OnboardingScreen(); // Your onboarding screen
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen(); // Show splash while waiting
        } else if (snapshot.hasData) {
          return const HomeScreen(); // Authenticated
        } else {
          return const LoginScreen(); // Not authenticated
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mara Pub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: FutureBuilder<Widget>(
        future: _getInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('Something went wrong')),
            );
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
  }
}
