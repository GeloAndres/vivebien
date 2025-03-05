import 'package:flutter/material.dart';
import 'package:vivebien/screens/home/home_screen.dart';
import 'package:vivebien/service/auth/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Iniciar Sesión',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Lógica de autenticación
                print('correo: ${_emailController.text}');
                print('contraseña: ${_passwordController.text}');
                final bool validation = await AuthService().signIn(
                  email: _emailController.text,
                  password: _passwordController.text,
                );

                if (validation) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else {
                  print('error inesperadicimo');
                }
              },
              child: Text('Ingresar'),
            ),
            TextButton(
              onPressed: () {
                // espacio del crear cuenta
              },
              child: Text('Crear una cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
