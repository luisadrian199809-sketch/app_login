import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String email;

  HomePage({required this.email});

  get name => 'LUIS HINCHA DE LIGA DEPORTIVA UNIVERSITARIA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BIENVENIDO LIGUISTA DE CORAZÓN'),
        backgroundColor: const Color.fromARGB(
          255,
          255,
          69,
          246,
        ), // AppBar rosado
      ),
      backgroundColor: const Color.fromARGB(
        255,
        125,
        251,
        255,
      ), // Fondo rosado claro
      body: Center(
        child: Text(
          '¡HOLA, $name!',
          style: TextStyle(
            fontSize: 24,
            color: const Color.fromARGB(255, 210, 71, 252),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
