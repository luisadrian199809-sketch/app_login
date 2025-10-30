import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  // Base URL y API key correctos
  final String _base = 'https://api.themoviedb.org/3';
  final String _key = '91ffa1fec3f585b6a846caecf9ece777';

  // 🔹 Obtener películas populares
  Future<List<Movie>> fetchPopular({int page = 1}) async {
    final url = Uri.parse('$_base/movie/popular?api_key=$_key&page=$page&language=es-ES');

    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);

      // Si la respuesta tiene 'results', los convertimos en objetos Movie
      if (data['results'] != null) {
        final List results = data['results'];
        return results.map((e) => Movie.fromJson(e)).toList();
      } else {
        throw Exception('No se encontraron resultados en la respuesta');
      }
    } else {
      // Muestra el código de error y el cuerpo de respuesta en consola
      print('⚠️ Error al obtener películas populares');
      print('Código: ${res.statusCode}');
      print('Respuesta: ${res.body}');
      throw Exception('Error al obtener películas populares');
    }
  }

  // 🔹 Obtener detalles de una película por ID
  Future<Movie> getDetail(int id) async {
    final url = Uri.parse('$_base/movie/$id?api_key=$_key&language=es-ES');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return Movie.fromJson(json.decode(res.body));
    } else {
      print('⚠️ Error al obtener detalle');
      print('Código: ${res.statusCode}');
      print('Respuesta: ${res.body}');
      throw Exception('Error al obtener detalle de la película');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.parse('$_base/search/movie?api_key=$_key&language=es-ES&query=$query');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      if (data['results'] != null) {
        final List results = data['results'];
        return results.map((e) => Movie.fromJson(e)).toList();
      } else {
        throw Exception('No se encontraron resultados en la respuesta');
      }
    } else {
      print('⚠️ Error al buscar películas');
      print('Código: ${res.statusCode}');
      print('Respuesta: ${res.body}');
      throw Exception('Error al buscar películas');
    }
  }
}
