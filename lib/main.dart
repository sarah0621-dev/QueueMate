import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const QueueMateApp());
}

class QueueMateApp extends StatelessWidget {
  const QueueMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QueueMate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
    );
  }
}
