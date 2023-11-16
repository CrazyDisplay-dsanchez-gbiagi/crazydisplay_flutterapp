import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CrazyDisplay(),
    );
  }
}

class CrazyDisplay extends StatefulWidget {
  @override
  _CrazyDisplayState createState() => _CrazyDisplayState();
}

class _CrazyDisplayState extends State<CrazyDisplay> {
  TextEditingController ipController = TextEditingController();
  TextEditingController mensajeController = TextEditingController();
  List<String> messageList = [];
  bool isConnected = false;
  bool isSidebarOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CrazyDisplay'),
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
                    decoration: const InputDecoration(
                      labelText: 'Mensaje',
                      hintText: 'Ingrese su mensaje',
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isConnected = !isConnected;
                          });
                        },
                        child: Text(isConnected ? 'Desconectar' : 'Conectar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Implement logic to send the message
                          String message = mensajeController.text;
                          if (message.isNotEmpty) {
                            setState(() {
                              messageList.add(message);
                              mensajeController.clear();
                            });
                          }
                        },
                        child: Text('Enviar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Hola David')));
                          // Toggle the visibility of the sidebar
                          setState(() {
                            isSidebarOpen = !isSidebarOpen;
                          });
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
            Container(
              width: 300, // Adjust the width as needed
              child: Drawer(
                child: Container(
                  padding: EdgeInsets.all(16.0),
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
                          itemCount: messageList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(messageList[index]),
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
