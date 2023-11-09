import 'package:flutter/material.dart';

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
  TextEditingController ipController = TextEditingController();
  TextEditingController mensajeController = TextEditingController();

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
          ],
        ),
      ),
    );
  }
}
