import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobile_control/app/core/cores.dart';
import 'package:mobile_control/app/pages/home/mobile/mobile_controller.dart';

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.background,
      appBar: AppBar(
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
      ),
      body: Center(
        child: Material(
          elevation: 1,
          child: Container(
            height: 300,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Cores.dialog,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Bem vindo ao ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    ShaderMask(
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Cores.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                TextField(
                  controller: MobileController.instance.ipController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'IP do dispositivo',
                  ),
                ),
                const Gap(32),
                InkWell(
                  onTap: () async {
                    await MobileController.instance.validateAndConnect(context);
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Gap(48),
                const Text('© Murillo Castro.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
