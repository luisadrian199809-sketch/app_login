import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../utils/dummy_data.dart';

class BooksProvider with ChangeNotifier {
  final List<Book> _all = bookList;

  String _selectedCategory = 'Todo';

  // Mapa para asignar cada libro a su categoría
  final Map<String, String> bookCategories = {
    // Medicina
    "Anatomía y Fisiología": "Medicina",
    "Asociación Europea de Urología Guía de Bolsillo": "Medicina",
    "Cardiología en la práctica clínica Tomo 1": "Medicina",
    "Cardiología Fundamental": "Medicina",
    "Cardiología hoy 2022": "Medicina",
    "Curso Básico Sistema de Comandos de Incidentes": "Medicina",
    "Fundamentos de Nefrología Clínica": "Medicina",
    "INTRODUCCIÓN A LA CARDIOLOGÍA": "Medicina",
    "Medicina General Integral": "Medicina",
    "Propedéutica Clínica y Semiología Médica": "Medicina",
    // Tecnología (ejemplo)
    "Curso de Flutter": "Tecnología",
    "Introducción a Dart": "Tecnología",
    "Algoritmos y Estructuras de Datos": "Tecnología",
  };

  List<Book> get allBooks => [..._all];

  String get selectedCategory => _selectedCategory;

  // Filtrado de libros según categoría
  List<Book> get books {
    if (_selectedCategory == 'Todo') return [..._all];
    return _all
        .where((b) => bookCategories[b.title] == _selectedCategory)
        .toList();
  }

  void setCategory(String c) {
    _selectedCategory = c;
    notifyListeners();
  }

  // Método para obtener libros por categoría directamente
  List<Book> getBooksByCategory(String category) {
    if (category == 'Todo') return [..._all];
    return _all.where((b) => bookCategories[b.title] == category).toList();
  }
}
