import 'package:flutter/material.dart';

class EmergencyStateScreen extends StatefulWidget {
  const EmergencyStateScreen({super.key});

  @override
  State<EmergencyStateScreen> createState() => _EmergencyStateScreenState();
}

class _EmergencyStateScreenState extends State<EmergencyStateScreen> {
  bool _isEmergencyActive = true;
  bool _isDragging = false;
  double _dragPosition = 0.0;
  final double _toggleWidth = 200.0;
  final double _toggleHeight = 60.0;
  final double _toggleButtonWidth = 80.0;

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
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.red.shade900,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Drag to disable',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Colors.white),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onPanStart: (details) {
                      setState(() {
                        _isDragging = true;
                      });
                    },
                    onPanUpdate: (details) {
                      if (details.delta.dx > 0) {
                        setState(() {
                          _dragPosition = (_dragPosition + details.delta.dx)
                              .clamp(0.0, _toggleWidth - _toggleButtonWidth);
                        });
                      }
                    },
                    onPanEnd: (details) {
                      setState(() {
                        _isDragging = false;
                      });
                      if (_dragPosition >=
                          (_toggleWidth - _toggleButtonWidth) / 2) {
                        _disableEmergency();
                      } else {
                        setState(() {
                          _dragPosition = 0.0;
                        });
                      }
                    },
                    child: Container(
                      width: _toggleWidth,
                      height: _toggleHeight,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(_toggleHeight / 2),
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 200),
                            left:
                                _isDragging
                                    ? _dragPosition
                                    : (_isEmergencyActive
                                        ? 0
                                        : _toggleWidth - _toggleButtonWidth),
                            child: Container(
                              width: _toggleButtonWidth,
                              height: _toggleHeight,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(
                                  _toggleHeight / 2,
                                ),
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
