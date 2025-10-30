import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

const String API_URL =
    "http://10.0.2.2/APIAPPJAPON"; // Cambia según tu servidor

class ApiService {
  static Future<bool> createCategory(String nombre, String descripcion) async {
    final uri = Uri.parse('$API_URL/categorias.php');
    final res = await http.post(
      uri,
      headers: jsonHeaders(),
      body: jsonEncode({
        'nombre': nombre,
        'descripcion': descripcion,
      }),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['success'] == true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteProduct(int id) async {
    final uri = Uri.parse('$API_URL/productos.php?idProductos=$id');
    final res = await http.delete(uri, headers: jsonHeaders());
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['success'] == true;
    } else {
      return false;
    }
  }

  static Map<String, String> jsonHeaders() =>
      {'Content-Type': 'application/json'};

  /// Login
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final uri = Uri.parse('$API_URL/login.php');
    final res = await http.post(
      uri,
      headers: jsonHeaders(),
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (res.statusCode == 200) {
      try {
        final Map<String, dynamic> data = jsonDecode(res.body);
        return data;
      } catch (e) {
        return {
          'success': false,
          'message': 'Respuesta no válida del servidor'
        };
      }
    } else {
      return {'success': false, 'message': 'Error de red: ${res.statusCode}'};
    }
  }

  /// Obtener categorías
  static Future<List<Category>> getCategories() async {
    final uri = Uri.parse('$API_URL/categories.php');
    final res = await http.get(uri);

    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener categorías: ${res.statusCode}');
    }
  }

  /// Obtener productos
  static Future<List<dynamic>> fetchProducts() async {
    final uri = Uri.parse('$API_URL/productos.php');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data;
    } else {
      throw Exception('Error al obtener productos: ${res.statusCode}');
    }
  }

  static Future<bool> createProduct(
      String nombre, String descripcion, double precio, int idCategoria) async {
    final uri = Uri.parse('$API_URL/productos.php');
    final res = await http.post(
      uri,
      headers: jsonHeaders(),
      body: jsonEncode({
        'nombre': nombre,
        'descripcion': descripcion,
        'precio': precio,
        'idCategoria': idCategoria,
      }),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['success'] == true;
    } else {
      return false;
    }
  }
}
