import 'package:flutter/material.dart';
import 'package:mobile_control/app/pages/home/desktop/home_desktop_controller.dart';
import 'package:mobile_control/app/pages/home/desktop/home_page_desktop.dart';
import 'dart:io' show Platform;
import 'package:mobile_control/app/pages/home/mobile/home_page_mobile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isWindows ? HomeDesktopController.instance.init() : null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mouse Control',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home:
          Platform.isAndroid ? const HomePageMobile() : const HomePageDesktop(),
    );
  }
}
