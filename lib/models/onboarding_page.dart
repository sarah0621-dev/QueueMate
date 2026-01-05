import 'package:flutter/material.dart';

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isFirst;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.isFirst = false,
  });
}
