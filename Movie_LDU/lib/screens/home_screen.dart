import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import 'detail_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService api = ApiService();
  List<Movie> movies = [];
  int page = 1;
  bool loading = false;
  bool hasMore = true;
  final ScrollController ctrl = ScrollController();

  @override
  void initState(){
    super.initState();
    _fetch();
    ctrl.addListener(() {
      if (ctrl.position.pixels > ctrl.position.maxScrollExtent - 300 && !loading && hasMore) {
        _fetch();
      }
    });
  }

  Future<void> _fetch() async {
    setState(() => loading = true);
    final newM = await api.fetchPopular(page: page);
    setState(() {
      page++;
      movies.addAll(newM);
      if (newM.isEmpty) hasMore = false;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Plus App'), actions: [
        IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())), icon: const Icon(Icons.search))
      ]),
      body: ListView.builder(
        controller: ctrl,
        itemCount: movies.length + (hasMore ? 1 : 0),
        itemBuilder: (context, idx){
          if (idx >= movies.length) return const Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator()));
          final m = movies[idx];
          return MovieCard(movie: m, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(movieId: m.id))));
        },
      ),
    );
  }
}
