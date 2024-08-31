import 'package:flutter/material.dart';
import 'package:mobile_control/app/core/cores.dart';

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mobile Control',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Cores.primary,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.purpleAccent,
                ],
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
          ),
        ),
      ),
    );
  }
}
