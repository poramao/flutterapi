import 'package:flutter/material.dart';

import 'helpers/http_helper.dart';
import 'models/movie.dart';
import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final HttpHelper helper = HttpHelper();
  late Future<List<Movie>> movies;

  @override
  void initState() {
    super.initState();
    movies = helper.getUpcomingMovies() as Future<List<Movie>>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upcoming Movies')),
      body: FutureBuilder<List<Movie>>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final movies = snapshot.data!;

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                  child: ListTile(
                    leading: movie.posterPath.isNotEmpty
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.movie),
                    title: Text(movie.title),
                    subtitle: Text(
                      'Release: ${movie.releaseDate}  ⭐ ${movie.voteAverage}',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              MovieDetail(movie: movie),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error:\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}