import 'package:flutter/material.dart';
import 'appscreen/splash_screen.dart';
import 'appscreen/welcome_screen.dart';
import 'appscreen/chat_welcome_screen.dart';
import 'appscreen/foodapp_onboarding_screen.dart';
import 'appscreen/login_screen.dart';
import 'appscreen/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // halaman awal
      initialRoute: '/login',

      // routing semua halaman
      routes: {
        '/login': (context) => const SignInScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/splash': (context) => SplashScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/chat': (context) => ChatWelcomeScreen(),
        '/onboarding': (context) => OnboardingScreen(),
      },
    );
  }
}