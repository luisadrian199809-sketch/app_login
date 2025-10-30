import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CategoriesPage extends StatefulWidget {
  final Map<String, dynamic> user;
  CategoriesPage({required this.user});
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List categories = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    setState(() => loading = true);
    try {
      final cats = await ApiService.getCategories();
      setState(() {
        categories = cats;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ' + e.toString())));
    } finally {
      setState(() => loading = false);
    }
  }

  void openCreate() {
    String nombre = '';
    String descripcion = '';
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Crear categoría'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                  onChanged: (v) => nombre = v,
                  decoration: InputDecoration(labelText: 'Nombre')),
              TextField(
                  onChanged: (v) => descripcion = v,
                  decoration: InputDecoration(labelText: 'Descripción')),
            ]),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar')),
              ElevatedButton(
                  onPressed: () async {
                    final ok =
                        await ApiService.createCategory(nombre, descripcion);
                    Navigator.pop(context);
                    if (ok) load();
                  },
                  child: Text('Crear'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = widget.user['rol'] == 'admin';
    return Scaffold(
      appBar: AppBar(title: Text('Categorias')),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final c = categories[i];
                return ListTile(
                    title: Text(c.nombre ?? c['nombre']),
                    subtitle: Text(c.descripcion ?? c['descripcion'] ?? ''));
              }),
      floatingActionButton: isAdmin
          ? FloatingActionButton(onPressed: openCreate, child: Icon(Icons.add))
          : null,
    );
  }
}
