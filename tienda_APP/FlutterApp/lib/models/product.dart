
class Product {
  final int idProductos;
  final String nombre;
  final String descripcion;
  final double precio;
  final int idCategoria;
  final String? categoria;
  Product({required this.idProductos, required this.nombre, required this.descripcion, required this.precio, required this.idCategoria, this.categoria});
  factory Product.fromJson(Map<String, dynamic> json) => Product(
    idProductos: int.parse(json['idProductos'].toString()),
    nombre: json['nombre'],
    descripcion: json['descripcion'] ?? '',
    precio: double.tryParse(json['precio'].toString()) ?? 0.0,
    idCategoria: int.parse(json['idCategoria'].toString()),
    categoria: json['categoria'] ?? null
  );
}
