import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie.dart';
import '../utils/constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  const MovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context){
    final image = movie.posterPath.isNotEmpty ? '\$TMDB_IMAGE_BASE\${movie.posterPath}' : null;
    return ListTile(
      onTap: onTap,
      leading: image != null ? CachedNetworkImage(imageUrl: image, width: 50, fit: BoxFit.cover, placeholder: (c,u)=>Container(width:50,color:Colors.grey), errorWidget:(c,u,e)=>const Icon(Icons.broken_image)) : Container(width:50,color:Colors.grey),
      title: Text(movie.title, maxLines:1, overflow: TextOverflow.ellipsis),
      subtitle: Row(children: [const Icon(Icons.star, size:14, color: Colors.orange), const SizedBox(width:4), Text(movie.voteAverage.toString())]),
    );
  }
}
