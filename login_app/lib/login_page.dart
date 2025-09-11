import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text;

      if (email == 'luisadrian199809@gmail.com' && password == 'Luis199800') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage(email: email)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('CORREO O CONTRASEÑA INCORRECTOS')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INICIO DE SESIÓN L.D.U'),
        backgroundColor: const Color.fromARGB(
          255,
          240,
          112,
          229,
        ), // AppBar rosado
      ),
      backgroundColor: const Color.fromARGB(
        253,
        74,
        231,
        231,
      ), // Fondo rosado claro
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'CORREO ELECTRÓNICO L.D.U',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'INGRESA TU CORREO L.D.U';
                  if (!value.contains('@')) return 'CORREO NO VÁLIDO L.D.U';
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'CONTRASEÑA L.D.U',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'INGRESA TU CONTRASEÑA L.D.U';
                  if (value.length < 6) return 'Mínimo 6 caracteres';
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                child: Text('INICIAR SESIÓN L.D.U'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
