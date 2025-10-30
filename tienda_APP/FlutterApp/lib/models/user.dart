
class User {
  final int idUsuario;
  final String nombre;
  final String email;
  final int idRol;
  final String rol;
  User({required this.idUsuario, required this.nombre, required this.email, required this.idRol, required this.rol});
  factory User.fromJson(Map<String, dynamic> json) => User(
    idUsuario: int.parse(json['idUsuario'].toString()),
    nombre: json['nombre'],
    email: json['email'],
    idRol: int.parse(json['idRol'].toString()),
    rol: json['rol']
  );
}
