import 'package:flutter/material.dart';

class EmergencyStateScreen extends StatefulWidget {
  const EmergencyStateScreen({super.key});

  @override
  State<EmergencyStateScreen> createState() => _EmergencyStateScreenState();
}

class _EmergencyStateScreenState extends State<EmergencyStateScreen> {
  bool _isEmergencyActive = true;

  void _disableEmergency() {
    setState(() {
      _isEmergencyActive = false;
    });
    // Navigate back to home screen after a short delay for animation
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'EMERGENCY RAISED',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Text(
                    'Hold to disable',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Colors.white),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onPanUpdate: (details) {
                      if (details.delta.dx > 0) {
                        // Only allow right movement
                        _disableEmergency();
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 200),
                            left: _isEmergencyActive ? 0 : 50,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
