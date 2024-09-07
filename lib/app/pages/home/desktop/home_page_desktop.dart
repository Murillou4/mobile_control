import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:mobile_control/app/pages/home/desktop/home_desktop_controller.dart';
import 'package:mobile_control/app/services/ip_service.dart';

class HomePageDesktop extends StatelessWidget {
  const HomePageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 80,
            width: 400,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text('Local IP:'),
                        Gap(8),
                        Tooltip(
                          message:
                              'Insira este endereço IP no seu dispositivo mobile',
                          child: Icon(
                            Icons.help_outline_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        FutureBuilder(
                          future: IpService().getLocalIP(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data.toString());
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                            }

                            return const Text('Unknown IP');
                          },
                        ),
                        const Gap(8),
                        InkWell(
                          onTap: () async {
                            Clipboard.setData(
                              ClipboardData(
                                text: await IpService().getLocalIP(),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.green,
                                content: Text(
                                    'Copiado para a área de transferência'),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: const Icon(
                            Icons.copy,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text('Visitantes ?'),
                        const Gap(8),
                        ValueListenableBuilder(
                          valueListenable:
                              HomeDesktopController.instance.isMobileConnected,
                          builder: (context, value, child) {
                            if (value) {
                              return const Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 16,
                              );
                            } else {
                              return const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 16,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const Gap(8),
                    const Text(''),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
