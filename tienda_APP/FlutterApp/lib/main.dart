import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(TiendaApp());
}

class TiendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tienda App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: LoginPage(),
    );
  }
}
