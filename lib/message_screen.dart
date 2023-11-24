import 'dart:io';

import 'package:CrazyDisplay/message.dart';
import 'package:file_picker/file_picker.dart';
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
  final List<Message> messageList;
  final VoidCallback onToggleSidebar;
  final TextEditingController mensajeController;
  final Function(String) sendMensajeCallback;
  final Function(String) addMensajeCallback;

  void guardarMensaje() {
    // Crear el archivo
    File file = File('./assets/messages.txt');

    // Abrir el archivo en modo escritura
    RandomAccessFile raf = file.openSync(mode: FileMode.write);

    // Escribir mensajes en el archivo
    for (Message mensaje in messageList) {
      raf.writeStringSync('$mensaje\n');
    }
    // Cerrar archivo
    raf.closeSync();
  }

  void recuperarMensajes() async {
    // Lee el archivo y obtiene su contenido como una lista de líneas
    List<String> lines = await File("./assets/messages.txt").readAsLines();

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
                    const SizedBox(width: 16),
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
                    const SizedBox(width: 25),
                    ElevatedButton(
                      onPressed: () {
                        guardarMensaje();
                      },
                      child: const Text('Guardar Mensajes'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles();

                        if (result != null) {
                          File file = File(result.files.single.path!);
                        } else {
                          print("No hay imagen");
                        }
                      },
                      child: const Text('Enviar imagen'),
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
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            // Mostrar solo el mensaje  y no la hora.

                            title: Text(messageList[index].getMessage()),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar envío'),
                                    content: const Text(
                                        '¿Estás seguro de enviar este mensaje?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Cerrar el diálogo
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Cerrar el diálogo
                                          // Lógica para enviar el mensaje
                                          sendMensajeCallback(
                                              messageList[index].getMessage());
                                          print(
                                              'Mensaje enviado: ${messageList[index]}');
                                        },
                                        child: Text('Aceptar'),
                                      ),
                                    ],
                                  );
                                },
                              );
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
