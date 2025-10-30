import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Stack(
      children: [
        // Imagen de fondo
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/ligafondo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // importante para que se vea el fondo
          appBar: AppBar(
            title: Text("Registro"),
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Campo usuario
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                      ),
                      onChanged: (val) => username = val,
                      validator: (val) => val!.isEmpty ? 'Ingrese usuario' : null,
                    ),
                    SizedBox(height: 10),
                    // Campo email
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                      ),
                      onChanged: (val) => email = val,
                      validator: (val) => val!.isEmpty ? 'Ingrese email' : null,
                    ),
                    SizedBox(height: 10),
                    // Campo password
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                      ),
                      obscureText: true,
                      onChanged: (val) => password = val,
                      validator: (val) => val!.isEmpty ? 'Ingrese contraseña' : null,
                    ),
                    SizedBox(height: 20),
                    // Botón registrar
                    loading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                await userProvider.registerUser(
                                  User(username: username, email: email, password: password),
                                );
                                setState(() => loading = false);
                                Navigator.pushReplacementNamed(context, '/home');
                              }
                            },
                            child: Text('Registrarse'),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
