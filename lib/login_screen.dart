import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
    required this.ipController,
    required this.userController,
    required this.passwordController,
    required this.onLogin,
  }) : super(key: key);

  final TextEditingController ipController;
  final TextEditingController userController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            controller: userController,
            decoration: const InputDecoration(
              labelText: 'Usuario',
              hintText: 'Ingrese su usuario',
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              hintText: 'Ingrese su contraseña',
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: onLogin,
            child: const Text('Iniciar sesión'),
          ),
        ],
      ),
    );
  }
}
