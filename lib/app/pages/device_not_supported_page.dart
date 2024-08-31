import 'package:flutter/material.dart';

class DeviceNotSupportedPage extends StatelessWidget {
  const DeviceNotSupportedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Device not supported',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
