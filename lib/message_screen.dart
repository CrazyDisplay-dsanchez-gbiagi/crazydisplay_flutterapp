import 'dart:io';

import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({
    Key? key,
    required this.isConnected,
    required this.isSidebarOpen,
    required this.messageList,
    required this.onToggleSidebar,
    required this.mensajeController,
    required this.sendMensajeCallback,
    required this.addMensajeCallback,
  }) : super(key: key);

  final bool isConnected;
  final bool isSidebarOpen;
  final List<String> messageList;
  final VoidCallback onToggleSidebar;
  final TextEditingController mensajeController;
  final Function(String) sendMensajeCallback;
  final Function(String) addMensajeCallback;

  void guardarMensaje() {
    // Get the path of the document directory
    //String dir = Directory.current.path;

    // Crear el archivo
    File file = File('./assets/messages.txt');

    // Abrir el archivo en modo escritura
    RandomAccessFile raf = file.openSync(mode: FileMode.write);

    // Escribir mensajes en el archivo
    for (String mensaje in messageList) {
      raf.writeStringSync('$mensaje\n');
    }
    // Cerrar archivo
    raf.closeSync();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: mensajeController,
                        decoration: const InputDecoration(
                          labelText: 'Mensaje',
                          hintText: 'Ingrese su mensaje',
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    FloatingActionButton(
                      onPressed: () {
                        String mensaje = mensajeController.text;
                        if (mensaje.isNotEmpty) {
                          sendMensajeCallback(mensaje);
                          addMensajeCallback(mensaje);
                          mensajeController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error al enviar el mensaje'),
                            ),
                          );
                        }
                      },
                      child: const Icon(Icons.send),
                      //child: const Text('Enviar'),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        onToggleSidebar();
                      },
                      child: const Text('Mostrar Lista'),
                    ),
                    SizedBox(width: 25),
                    ElevatedButton(
                      onPressed: () {
                        guardarMensaje();
                      },
                      child: const Text('Guardar Mensajes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isSidebarOpen)
          SizedBox(
            width: 300,
            child: Drawer(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Lista de mensajes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(messageList[index]),
                            onTap: () {
                              print('Item clicked: ${messageList[index]}');
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
    );
  }
}
