import 'dart:io';

import 'package:CrazyDisplay/imagen_enviada.dart';
import 'package:CrazyDisplay/message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class MessageScreen extends StatelessWidget {
  const MessageScreen({
    Key? key,
    required this.isConnected,
    required this.isSidebarOpen,
    required this.messageList,
    required this.imageList,
    required this.onToggleSidebar,
    required this.mensajeController,
    required this.sendMensajeCallback,
    required this.addMensajeCallback,
    required this.sendImagenCallback,
    required this.addImagenCallback,
  }) : super(key: key);

  final bool isConnected;
  final bool isSidebarOpen;
  final List<Message> messageList;
  final List<ImagenEnviada> imageList;
  final VoidCallback onToggleSidebar;
  final TextEditingController mensajeController;
  final Function(String) sendMensajeCallback;
  final Function(String) addMensajeCallback;
  final Function(String, String) sendImagenCallback;
  final Function(String, String) addImagenCallback;

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

  Future<void> pickImage() async {
    final picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (pickedFile != null) {
        File image = File(pickedFile.path);
        String extension = image.path.split('.').last;
        List<int> imageBytes = await image.readAsBytes();
        String imageString = base64Encode(imageBytes);
        print("Imagen seleccionada: $imageString");
        sendImagenCallback(imageString, extension);
        addImagenCallback(imageString, extension);
      } else {
        print("No hay imagen");
      }
    } catch (e) {
      print("Error picking image: $e");
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
                        pickImage();

                        // Este codigo funciona solo en windows?
                        // final result = await FilePicker.platform.pickFiles(
                        //     type: FileType.custom, allowedExtensions: ['png']);

                        // if (result != null) {
                        //   File image = File(result.files.single.path!);
                        //   List<int> imageBytes = image.readAsBytesSync();
                        //   String imageString = base64Encode(imageBytes);
                        //   sendImagenCallback(imageString);
                        //   addImagenCallback(imageString);
                        // } else {
                        //   print("No hay imagen");
                        // }
                      },
                      child: const Text('Enviar imagen'),
                    ),
                    const SizedBox(width: 25),
                    ElevatedButton(
                      onPressed: () {
                        onToggleSidebar();
                      },
                      child: const Text('Lista Mensajes'),
                    ),
                    // const SizedBox(width: 25),
                    // ElevatedButton(
                    //   onPressed: () {
                    // Ocultar galeria?
                    //   },
                    //   child: const Text('Galeria'),
                    // ),
                    const SizedBox(width: 25),
                    ElevatedButton(
                      onPressed: () {
                        guardarMensaje();
                      },
                      child: const Text('Guardar Mensajes'),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: imageList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar envío'),
                                    content: const Text(
                                        '¿Estás seguro de reenviar esta imagen?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Cerrar el diálogo
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Cerrar el diálogo
                                          // Lógica para enviar el mensaje
                                          sendImagenCallback(
                                              imageList[index].getImageString(),
                                              imageList[index].getExtension());
                                          print(
                                              'Mensaje enviado: ${messageList[index]}');
                                        },
                                        child: const Text('Aceptar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              print('Image clicked: $index');
                            },
                            child: Image.memory(
                              base64Decode(imageList[index].getImageString()),
                              fit: BoxFit.cover,
                              height: 20.0,
                              width: 20.0,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
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
                                        child: const Text('Cancelar'),
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
                                        child: const Text('Aceptar'),
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
