import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'login_screen.dart';
import 'message_screen.dart';

class CrazyDisplay extends StatefulWidget {
  const CrazyDisplay({Key? key});

  @override
  _CrazyDisplayState createState() => _CrazyDisplayState();
}

class _CrazyDisplayState extends State<CrazyDisplay> {
  String _serverIp = '';
  final String _serverPort = '8888';

  IOWebSocketChannel? _channel;

  TextEditingController ipController = TextEditingController();
  TextEditingController mensajeController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> mensajeList = [];
  bool isConnected = false;
  bool isSidebarOpen = false;
  bool isLoggedIn = false;

  void _connectToServer() {
    print(ipController.text);
    if (ipController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ingrese una dirección IP válida')));
      return;
    }
    _serverIp = ipController.text;
    String server = "ws://$_serverIp:$_serverPort";
    _channel = IOWebSocketChannel.connect(server);

    _channel!.stream.listen(
      (mensaje) {
        final data = jsonDecode(mensaje);
      },
      onError: (error) {
        print("Error: $error");
        _channel!.sink.close();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Error al conectar')));
      },
      onDone: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Conectado')));
        setState(() {
          isConnected = true;
        });
      },
    );
  }

  void _disconnectFromServer() {
    _channel!.sink.close();
  }

  void _login() {
    // Implement your login logic here
    // For simplicity, just check if the username and password are not empty
    if (userController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() {
        isLoggedIn = true;
        _connectToServer(); // Automatically connect to the server after login
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ingrese un usuario y contraseña')));
    }
  }

  void _sendMensaje(String mensaje) {
    if (_channel != null) {
      _channel!.sink.add(mensaje);
    }
  }

  void addMensaje(String mensaje) {
    bool repetido = false;
    for (int i = 0; i < mensajeList.length; i++) {
      if (mensajeList[i] == mensaje) {
        repetido = true;
      }
    }
    if (!repetido) {
      mensajeList.add(mensaje);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CrazyDisplay'),
        centerTitle: true,
      ),
      body: isLoggedIn
          ? MessageScreen(
              isConnected: isConnected,
              isSidebarOpen: isSidebarOpen,
              mensajeList: mensajeList,
              onToggleSidebar: () {
                setState(() {
                  isSidebarOpen = !isSidebarOpen;
                });
              },
              mensajeController: mensajeController,
              sendMensajeCallback: _sendMensaje,
              addMensajeCallback: addMensaje,
            )
          : LoginScreen(
              ipController: ipController,
              userController: userController,
              passwordController: passwordController,
              onLogin: _login,
            ),
    );
  }
}
