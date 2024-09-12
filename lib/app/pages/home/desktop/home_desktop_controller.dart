import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_auto_gui/flutter_auto_gui.dart';

class HomeDesktopController {
  static final instance = HomeDesktopController();
  ValueNotifier<bool> isMobileConnected = ValueNotifier(false);

  Future<void> init() async {
    // Define o handler para lidar com conexões WebSocket
    var handler = webSocketHandler((WebSocketChannel webSocket) {
      if (isMobileConnected.value) {
        //print('Conexão recusada. Já existe um cliente conectado.');
        webSocket.sink.add('Outro dispositivo já está conectado.');
        webSocket.sink.close();
        return; // Recusa a nova conexão
      }

      //print('Novo cliente conectado');
      isMobileConnected.value = true;

      // Escuta mensagens do cliente
      webSocket.stream.listen(
        (message) {
          //print('Mensagem recebida do cliente: $message');
          processCommand(message);

          // Envia resposta de volta ao cliente
          webSocket.sink.add('Comando processado com sucesso');
        },
        onDone: () {
          //print('Cliente desconectado');
          isMobileConnected.value = false; // Permitir novas conexões
        },
        onError: (error) {
          //print('Erro: $error');
          isMobileConnected.value =
              false; // Em caso de erro, permitir novas conexões
        },
      );
    });

    // Inicia o servidor na porta 3000
    var server = await shelf_io.serve(handler, '0.0.0.0', 3000);
    //print('Servidor rodando em ws://${server.address.host}:${server.port}');
  }

  // Processa o comando recebido e executa a ação apropriada
  Future<void> processCommand(String message) async {
    var commandParts = message.split(',');
    var action = commandParts[0];

    // Movimento do mouse
    if (action == 'move') {
      var dx = double.parse(commandParts[1]);
      var dy = double.parse(commandParts[2]);

      // Mover o mouse com base em dx e dy
      await FlutterAutoGUI.moveToRel(
        offset: Size(dx * 4, dy * 4),
        duration: const Duration(milliseconds: 50),
        curve: Curves.linear,
      );
    }
    // Clique esquerdo
    else if (action == 'click') {
      await FlutterAutoGUI.click(button: MouseButton.left);
    }
    // Clique direito
    else if (action == 'right_click') {
      await FlutterAutoGUI.click(button: MouseButton.right);
    }

    //print('Comando processado: $message');
  }
}
