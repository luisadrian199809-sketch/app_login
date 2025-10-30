
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProductsPage extends StatefulWidget {
  final Map<String, dynamic> user;
  ProductsPage({required this.user});
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List products = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    setState(() => loading = true);
    try {
      final prods = await ApiService.fetchProducts();
      setState(() { products = prods; });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: \$e')));
    } finally {
      setState(() => loading = false);
    }
  }

  void openCreate() {
    String nombre = '';
    String descripcion = '';
    String precio = '';
    int idCategoria = 1;
    showDialog(context: context, builder: (_) {
      return AlertDialog(
        title: Text('Crear producto'),
        content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(onChanged: (v) => nombre = v, decoration: InputDecoration(labelText: 'Nombre')),
          TextField(onChanged: (v) => descripcion = v, decoration: InputDecoration(labelText: 'Descripcion')),
          TextField(onChanged: (v) => precio = v, decoration: InputDecoration(labelText: 'Precio'), keyboardType: TextInputType.number),
          TextField(onChanged: (v) => idCategoria = int.tryParse(v) ?? 1, decoration: InputDecoration(labelText: 'idCategoria (1,2,3...)')),
        ])),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancelar')),
          ElevatedButton(onPressed: () async {
            final ok = await ApiService.createProduct(nombre, descripcion, double.tryParse(precio) ?? 0.0, idCategoria);
            Navigator.pop(context);
            if (ok) load();
          }, child: Text('Crear'))
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = widget.user['rol'] == 'admin';
    return Scaffold(
      appBar: AppBar(title: Text('Productos')),
      body: loading ? Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, i) {
          final p = products[i];
          final name = p['nombre'] ?? (p.nombre ?? '');
          final price = (p['precio'] ?? (p.precio?.toString() ?? '0')).toString();
          final cat = p['categoria'] ?? (p.categoria ?? '');
          return ListTile(
            title: Text(name),
            subtitle: Text(cat + '\nPrecio: \$' + price),
            isThreeLine: true,
            trailing: isAdmin ? IconButton(icon: Icon(Icons.delete), onPressed: () async {
              final id = p['idProductos'] ?? (p.idProductos ?? 0);
              final ok = await ApiService.deleteProduct(int.parse(id.toString()));
              if (ok) load();
            }) : null,
          );
        }
      ),
      floatingActionButton: isAdmin ? FloatingActionButton(onPressed: openCreate, child: Icon(Icons.add)) : null,
    );
  }
}
