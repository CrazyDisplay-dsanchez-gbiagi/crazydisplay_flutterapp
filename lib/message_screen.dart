import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({
    Key? key,
    required this.isConnected,
    required this.isSidebarOpen,
    required this.mensajeList,
    required this.onToggleSidebar,
    required this.mensajeController,
    required this.sendMensajeCallback,
    required this.addMensajeCallback,
  }) : super(key: key);

  final bool isConnected;
  final bool isSidebarOpen;
  final List<String> mensajeList;
  final VoidCallback onToggleSidebar;
  final TextEditingController mensajeController;
  final Function(String) sendMensajeCallback;
  final Function(String) addMensajeCallback;

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
                Flexible(
                  fit: FlexFit.loose,
                  child: ElevatedButton(
                    onPressed: () {
                      onToggleSidebar();
                    },
                    child: Text('Mostrar Lista'),
                  ),
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
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lista de mensajes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: mensajeList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(mensajeList[index]),
                            onTap: () {
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
    );
  }
}
