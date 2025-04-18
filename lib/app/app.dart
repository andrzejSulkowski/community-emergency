import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../features/home/presentation/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Item List Demo',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
