import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'login_screen.dart';
import 'message_screen.dart';
import 'message.dart';

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
  TextEditingController messageController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<Message> messageList = [];
  bool isConnected = false;
  bool isSidebarOpen = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    recuperarMensajes();
  }

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
  }

  void _disconnectFromServer() {
    _channel!.sink.close();
  }

  void _login() {
    _connectToServer();
    print("Conectado al servidor");
    Future.delayed(const Duration(seconds: 2));
    // Comprobar usuario y contraseña
    if (userController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        _channel != null) {
      final message = {
        'type': 'login',
        'user': userController.text,
        'password': passwordController.text,
      };
      _channel!.sink.add(jsonEncode(message));
      print("Esperando respuesta");
      Future.delayed(const Duration(seconds: 2));
      _channel!.stream.listen(
        (mensaje) {
          final data = jsonDecode(mensaje);
          if (data['valid'] == true) {
            final platform = {
              'type': 'platform',
              'name': 'Desktop',
            };
            _channel!.sink.add(jsonEncode(platform));
            print("Login correcto");
            setState(() {
              isLoggedIn = true;
            });
          } else if (data['valid'] == false) {
            print("Login incorrecto");
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Usuario o contraseña incorrecta')));
          }
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
  }

  void _sendMensaje(String mensaje) {
    if (_channel != null) {
      final message = {
        'type': 'message',
        'value': mensaje,
        'format': 'text',
      };
      _channel!.sink.add(jsonEncode(message));
    }
  }

  void _sendImage(String imageString) {
    if (_channel != null) {
      final message = {
        'type': 'message',
        'value': imageString,
        'format': 'img'
      };
      _channel!.sink.add(jsonEncode(message));
    }
  }

  void addMensaje(String mensaje) {
    bool repetido = false;
    for (int i = 0; i < messageList.length; i++) {
      if (messageList[i].getMessage() == mensaje) {
        repetido = true;
      }
    }
    if (!repetido) {
      DateTime currentDate = DateTime.now();
      String date =
          "${currentDate.year}-${currentDate.month}-${currentDate.day} ${currentDate.hour}:${currentDate.minute}:${currentDate.second}";
      messageList.add(Message(date, mensaje));
    }
  }

  void recuperarMensajes() async {
    String filePath = "./assets/messages.txt";
    // Lee el archivo y obtiene su contenido como una lista de líneas
    List<String> lines = await File(filePath).readAsLines();

    // Verificar si el archivo existe
    File file = File(filePath);
    if (!(await file.exists())) {
      print("No hay mensajes para recuperar");
      return;
    }

    // Itera sobre cada línea del archivo
    for (String line in lines) {
      // Divide la línea en partes usando el punto y coma como separador
      List<String> parts = line.split('; ');

      // Asegurar que la línea tenga el formato esperado
      if (parts.length == 2) {
        // Obtiene la fecha y el mensaje
        String date = parts[0];
        String messageText = parts[1];

        // Crea un objeto Message y agrega a la lista
        Message message = Message(date, messageText);
        messageList.add(message);
      }
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
              messageList: messageList,
              onToggleSidebar: () {
                setState(() {
                  isSidebarOpen = !isSidebarOpen;
                });
              },
              mensajeController: messageController,
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
