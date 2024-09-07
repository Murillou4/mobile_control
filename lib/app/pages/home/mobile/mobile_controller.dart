import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_control/app/core/cores.dart';
import 'package:mobile_control/app/pages/home/mobile/connected_page_mobile.dart';
import 'package:mobile_control/app/pages/home/mobile/home_page_mobile.dart';

class MobileController {
  static final instance = MobileController();
  TextEditingController ipController = TextEditingController();
  WebSocket? socket;
  Future<void> connectToServer() async {
    try {
      socket = await WebSocket.connect('ws://${ipController.text}:3000');
      print('Conectado ao servidor WebSocket');

      // Escuta mensagens do servidor
      socket!.listen((message) {
        print('Resposta do servidor: $message');
      });

      // Ao desconectar
      socket!.done.then((_) {
        print('Desconectado do servidor WebSocket');
      });
    } catch (e) {
      print('Erro ao conectar ao servidor WebSocket: $e');
    }
  }

  moveMouse(double dx, double dy) {
    // Enviando comando 'move' com deslocamento dx e dy
    if (socket != null) {
      socket!.add('move,$dx,$dy');
    } else {
      print('Não conectado ao servidor');
    }
  }

  click() {
    // Enviando comando 'click' para um clique esquerdo
    if (socket != null) {
      socket!.add('click');
    } else {
      print('Não conectado ao servidor');
    }
  }

  rightClick() {
    // Enviando comando 'right_click' para um clique direito
    if (socket != null) {
      socket!.add('right_click');
    } else {
      print('Não conectado ao servidor');
    }
  }

  void closeConnection(BuildContext context) {
    if (socket != null) {
      socket!.close();
      context.mounted
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePageMobile()),
              (route) => false,
            )
          : null;
    }
  }

  Future<void> validateAndConnect(BuildContext context) async {
    // Primeiro, validar o formato do IP
    if (isValidIP(ipController.text)) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Cores.primary,
          ),
        ),
      );

      // Depois, tentar conectar ao servidor
      bool isConnected;
      String errorMessage = '';
      try {
        isConnected = await canConnectToServer(ipController.text, 3000);
      } catch (e) {
        isConnected = false;
        errorMessage = e.toString();
      }
      if (isConnected) {
        await connectToServer();

        context.mounted ? Navigator.pop(context) : null;
        context.mounted
            ? Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConnectedPageMobile(),
                ),
                (route) => false,
              )
            : null;
      } else {
        context.mounted ? Navigator.pop(context) : null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.red,
            content: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text(
            'IP inválido. Por favor, insira um IP válido.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

// Função para verificar conectividade com o servidor
  Future<bool> canConnectToServer(String ip, int port) async {
    try {
      final s =
          await Socket.connect(ip, port, timeout: const Duration(seconds: 5));
      s.destroy();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Validação do formato do IP
  bool isValidIP(String ip) {
    return InternetAddress.tryParse(ip) != null;
  }
}
