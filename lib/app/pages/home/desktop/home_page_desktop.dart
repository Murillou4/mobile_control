import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobile_control/app/services/ip_service.dart';

class HomePageDesktop extends StatelessWidget {
  const HomePageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Este é o ip para inserir no seu dispositivo mobile:'),
            const Gap(10),
            FutureBuilder(
              future: IpService().getLocalIP(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.toString());
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                }

                return const Text('Unknown IP');
              },
            ),
          ],
        ),
      ),
    );
  }
}
