
class Category {
  final int idCategoria;
  final String nombre;
  final String descripcion;
  Category({required this.idCategoria, required this.nombre, required this.descripcion});
  factory Category.fromJson(Map<String, dynamic> json) => Category(
    idCategoria: int.parse(json['idCategoria'].toString()),
    nombre: json['nombre'],
    descripcion: json['descripcion'] ?? ''
  );
}
