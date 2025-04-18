import 'package:flutter/material.dart';
import '../screens/emergency_state_screen.dart';

class EmergencyDialog extends StatefulWidget {
  const EmergencyDialog({super.key});

  @override
  State<EmergencyDialog> createState() => _EmergencyDialogState();
}

class _EmergencyDialogState extends State<EmergencyDialog> {
  int _pressCount = 0;
  DateTime? _lastPressTime;

  void _handleEmergencyPress() {
    final now = DateTime.now();

    // Reset count if more than 2 seconds have passed since last press
    if (_lastPressTime != null &&
        now.difference(_lastPressTime!) > const Duration(seconds: 2)) {
      setState(() {
        _pressCount = 0;
      });
    }

    setState(() {
      _pressCount++;
      _lastPressTime = now;
    });

    if (_pressCount >= 5) {
      Navigator.of(context).pop(); // Close the dialog
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const EmergencyStateScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Emergency Alert'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Press the button 5 times to trigger emergency:',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            '$_pressCount/5',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _handleEmergencyPress,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              'PRESS TO CONFIRM',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
