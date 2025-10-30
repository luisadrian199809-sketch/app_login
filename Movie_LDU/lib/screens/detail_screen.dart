import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import '../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final int movieId;
  const DetailScreen({super.key, required this.movieId});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ApiService api = ApiService();
  Movie? movie;
  bool loading = true;
  bool isFav = false;

  @override
  void initState(){
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final m = await api.getDetail(widget.movieId);
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favorites') ?? [];
    setState(() {
      movie = m;
      isFav = favs.contains(widget.movieId.toString());
      loading = false;
    });
  }

  Future<void> _toggle() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favorites') ?? [];
    final id = widget.movieId.toString();
    if (favs.contains(id)) favs.remove(id); else favs.add(id);
    await prefs.setStringList('favorites', favs);
    setState(() => isFav = favs.contains(id));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(actions: [IconButton(icon: Icon(isFav ? Icons.favorite : Icons.favorite_border), onPressed: _toggle)]),
      body: loading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            movie!.backdropPath.isNotEmpty ? CachedNetworkImage(imageUrl: '\$TMDB_IMAGE_BASE\${movie!.backdropPath}', height: 220, fit: BoxFit.cover) : Container(height:220, color: Colors.grey),
            Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
             Text(
  movie!.title,
  style: Theme.of(context).textTheme.titleLarge,
),
              const SizedBox(height:8),
              Text("Año: \${movie!.releaseDate.isNotEmpty ? movie!.releaseDate.split('-')[0] : 'N/A'}"),
              const SizedBox(height:8),
              Row(children: [const Icon(Icons.star, color: Colors.orange), const SizedBox(width:6), Text(movie!.voteAverage.toString())]),
              const SizedBox(height:12),
              const Text('Sinopsis', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height:6),
              Text(movie!.overview),
            ],))
          ],
        ),
      ),
    );
  }
}
