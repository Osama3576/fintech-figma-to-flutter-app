import 'package:flutter/material.dart';

import 'screens/fintech_home_screen.dart';

void main() {
  runApp(const FintechDashboardApp());
}

class FintechDashboardApp extends StatelessWidget {
  const FintechDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fintech Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7F8),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4E73F8),
          background: const Color(0xFFF7F7F8),
        ),
      ),
      home: const FintechHomeScreen(),
    );
  }
}
