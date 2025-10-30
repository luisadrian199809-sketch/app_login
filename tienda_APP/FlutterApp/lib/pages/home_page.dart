
import 'package:flutter/material.dart';
import 'categories_page.dart';
import 'products_page.dart';

class HomePage extends StatelessWidget {
  final Map<String, dynamic> user;
  HomePage({required this.user});

  @override
  Widget build(BuildContext context) {
    final rol = user['rol'];
    return Scaffold(
      appBar: AppBar(title: Text('Tienda - Bienvenido')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Usuario: ' + (user['nombre'] ?? ''), style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoriesPage(user: user))), child: Text('Categorias')),
            SizedBox(height: 8),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductsPage(user: user))), child: Text('Productos')),
            SizedBox(height: 12),
            Text('Rol: ' + rol)
          ],
        ),
      ),
    );
  }
}
