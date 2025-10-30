import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ApiService api = ApiService();
  List<Movie> favs = [];
  bool loading = true;

  @override
  void initState(){ super.initState(); _load(); }

  Future<void> _load() async {
    setState(() => loading = true);
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('favorites') ?? [];
    List<Movie> movies = [];
    for (var id in ids) {
      try {
        final m = await api.getDetail(int.parse(id));
        movies.add(m);
      } catch (e) {}
    }
    setState(() { favs = movies; loading = false; });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: const Text('Favoritos')), body: loading ? const Center(child: CircularProgressIndicator()) : favs.isEmpty ? const Center(child: Text('No tienes favoritas')) : ListView.builder(itemCount: favs.length, itemBuilder: (c,i){
      final m = favs[i];
      return MovieCard(movie: m, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(movieId: m.id))).then((_) => _load()));
    }));
  }
}
