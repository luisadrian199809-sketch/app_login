import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
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
            title: Text("Login"),
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
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
                    // Botón de login
                    loading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                bool success = await userProvider.login(email, password);
                                setState(() => loading = false);
                                if (success) {
                                  Navigator.pushReplacementNamed(context, '/home');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Usuario o contraseña incorrecta')),
                                  );
                                }
                              }
                            },
                            child: Text('Iniciar Sesión'),
                          ),
                    SizedBox(height: 10),
                    // Botón registro
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('Registrarse', style: TextStyle(color: Colors.white)),
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
