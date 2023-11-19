// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CrazyDisplay(),
    );
  }
}

class CrazyDisplay extends StatefulWidget {
  const CrazyDisplay({super.key});
  @override
  _CrazyDisplayState createState() => _CrazyDisplayState();
}

class _CrazyDisplayState extends State<CrazyDisplay> {
  String _serverIp = '';
  final String _serverPort = '8888';

  IOWebSocketChannel? _channel;

  TextEditingController ipController = TextEditingController();
  TextEditingController mensajeController = TextEditingController();

  List<String> mensajeList = [];
  bool isConnected = false;
  bool isSidebarOpen = false;

  void _connectToServer() {
    print(ipController.text);
    print("Hola");
    if (ipController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ingrese una dirección IP válida')));
      return;
    }
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

  void _onOpen() {
    _sendmensaje("~FlutterClient");
    print("Conectado");
  }

  void _sendmensaje(String mensaje) {
    if (_channel != null) {
      _channel!.sink.add(mensaje);
    }
  }

  _disconnectFromServer() {
    _channel!.sink.close();
  }

  void addmensaje(String mensaje) {
    bool repetido = false;
    setState(() {
      for (int i = 0; i < mensajeList.length; i++) {
        if (mensajeList[i] == mensaje) {
          repetido = true;
        }
      }
      if (!repetido) {
        mensajeList.add(mensaje);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CrazyDisplay'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: ipController,
                    decoration: const InputDecoration(
                      labelText: 'IP',
                      hintText: 'Ingrese una dirección IP',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: mensajeController,
                    enabled: isConnected,
                    decoration: const InputDecoration(
                      labelText: 'Mensaje',
                      hintText: 'Ingrese su mensaje',
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // CONECTAR / DESCONECTAR SERVER
                      ElevatedButton(
                        onPressed: () {
                          final ip = ipController.text;
                          if (!isConnected) {
                            _serverIp = ip;
                            _connectToServer();
                          }
                          if (isConnected) {
                            _disconnectFromServer();
                          }
                        },
                        child: Text(isConnected ? 'Desconectar' : 'Conectar'),
                      ),
                      // ENVIAR EL MENSAJE
                      ElevatedButton(
                        onPressed: () {
                          // Implement logic to send the mensaje
                          String mensaje = mensajeController.text;
                          if (mensaje.isNotEmpty && isConnected) {
                            setState(() {
                              _sendmensaje(mensaje);
                              addmensaje(mensaje);
                              mensajeController.clear();
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Error al enviar el mensaje')));
                          }
                        },
                        child: const Text('Enviar'),
                      ),
                      // MOSTRAR LA LISTA DE MENSAJES
                      ElevatedButton(
                        onPressed: () {
                          if (isConnected) {
                            // Toggle the visibility of the sidebar
                            setState(() {
                              isSidebarOpen = !isSidebarOpen;
                            });
                          } else if (isSidebarOpen) {
                            setState(() {
                              isSidebarOpen = !isSidebarOpen;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Lista no disponible sin conexión')));
                          }
                        },
                        child: Text('Mostrar Lista'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isSidebarOpen)
            SizedBox(
              width: 300, // Adjust the width as needed
              child: Drawer(
                child: Container(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lista de mensajes',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: mensajeList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(mensajeList[index]),
                              onTap: () {
                                // Add your logic to handle item click here
                                print('Item clicked: ${mensajeList[index]}');
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
