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
          child: Text('Formulario'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    final ip = ipController.text;
                    final mensaje = mensajeController.text;
                    // Por ejemplo, imprimirlos en consola
                    print('IP: $ip');
                    print('Mensaje: $mensaje');
                  },
                  child: Text('Enviar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aqui se puede controlar que hacer con el texto de los campos
                    final ip = ipController.text;
                    _serverIp = ip;
                    _connectToServer();
                    // Por ejemplo, imprimirlos en consola
                    print('IP: $ip');
                  },
                  child: Text('Conectar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
