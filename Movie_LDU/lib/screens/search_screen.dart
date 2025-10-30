import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService api = ApiService();
  List<Movie> results = [];
  bool loading = false;
  final TextEditingController ctrl = TextEditingController();

  // 🔹 Nueva función de búsqueda
  void _onSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() => results = []);
      return;
    }

    setState(() => loading = true);

    try {
      final List<Movie> r = await api.searchMovies(query);
      setState(() {
        results = r;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al buscar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: ctrl,
          decoration: const InputDecoration(
            hintText: 'Buscar películas...',
            border: InputBorder.none,
          ),
          onChanged: _onSearch,
          textInputAction: TextInputAction.search,
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : results.isEmpty
              ? const Center(child: Text('No se encontraron resultados'))
              : ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, i) {
                    final m = results[i];
                    return MovieCard(
                      movie: m,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(movieId: m.id),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
