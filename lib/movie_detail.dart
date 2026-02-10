import 'package:flutter/material.dart';
import 'models/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;

  const MovieDetail({super.key, required this.movie});

  static const String imgBase =
      'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            if (movie.posterPath.isNotEmpty)
              Image.network(
                '$imgBase${movie.posterPath}',
                width: double.infinity,
                fit: BoxFit.cover,
              )
            else
              Container(
                height: 300,
                color: Colors.black12,
                child: const Center(
                  child: Icon(
                    Icons.movie,
                    size: 100,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Release date: ${movie.releaseDate}',
                    style: const TextStyle(
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rating: ⭐ ${movie.voteAverage}',
                  ),
                  const SizedBox(height: 16),
                  Text(
                    movie.overview,
                    style: const TextStyle(
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}