import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobile_control/app/core/cores.dart';
import 'package:mobile_control/app/pages/home/mobile/mobile_controller.dart';

double moveToX = 0;
double moveToY = 0;

class ConnectedPageMobile extends StatelessWidget {
  const ConnectedPageMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Cores.background,
        appBar: AppBar(
          backgroundColor: Cores.background,
          centerTitle: true,
          title: ShaderMask(
            shaderCallback: (shader) {
              return const LinearGradient(
                colors: [Cores.primary, Colors.white],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(shader);
            },
            child: const Text(
              'Mobile Control',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Cores.primary,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: GestureDetector(
                onTap: () => MobileController.instance.closeConnection(context),
                child: const Icon(
                  Icons.exit_to_app_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () => MobileController.instance.click(),
              onLongPress: () => MobileController.instance.rightClick(),
              onPanUpdate: (details) {
                moveToX = details.delta.dx;
                moveToY = details.delta.dy;

                MobileController.instance.moveMouse(moveToX, moveToY);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                color: Cores.dialog,
                child: const Center(
                  child: Text(
                    'TOUCH PAD!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => MobileController.instance.click(),
                    child: const Text('Left Click'),
                  ),
                  ElevatedButton(
                    onPressed: () => MobileController.instance.rightClick(),
                    child: const Text('Right Click'),
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
