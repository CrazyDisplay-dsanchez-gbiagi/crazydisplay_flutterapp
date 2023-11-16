import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CrazyDisplay",
      home: FormularioScreen(),
    );
  }
}

class FormularioScreen extends StatefulWidget {
  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  String _serverIp = 'localhost';
  String _serverPort = '8888';

  IOWebSocketChannel? _channel;

  TextEditingController ipController = TextEditingController();
  TextEditingController mensajeController = TextEditingController();

  void _connectToServer() {
    String server = "ws://$_serverIp:$_serverPort";
    _channel = IOWebSocketChannel.connect(server);

    _channel!.stream.listen(
      (message) {
        final data = jsonDecode(message);
      },
    );
    _onOpen();
  }

  void _onOpen() {
    _sendMessage("~FlutterClient");
    print("Conectado");
  }

  void _sendMessage(String message) {
    if (_channel != null) {
      _channel!.sink.add(message);
    }
  }

  _disconnectFromServer() {
    _channel!.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          // Centrar el titulo
          child: Text('CrazyDisplay'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 80, right: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: ipController,
              decoration: InputDecoration(
                labelText: 'IP',
                hintText: 'Ingrese una dirección IP',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: mensajeController,
              decoration: InputDecoration(
                labelText: 'Mensaje',
                hintText: 'Ingrese su mensaje',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Aqui se puede controlar que hacer con el texto de los campos
                    final mensaje = mensajeController.text;
                    _sendMessage(mensaje);
                    // Por ejemplo, imprimirlos en consola
                    print('Mensaje: $mensaje');
                  },
                  child: Text('Enviar'),
                ),
                ElevatedButton(
                    child: Text(_channel == null ? 'Conectar' : 'Desconectar'),
                    onPressed: () {
                      if (_channel == null) {
                        final ip = ipController.text;
                        _serverIp = ip;
                        _connectToServer();
                        print('IP: $ip');
                      } else {
                        _disconnectFromServer();
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
