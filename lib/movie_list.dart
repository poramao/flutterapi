import 'package:flutter/material.dart';
import 'http_helper.dart';
import 'movie_detail.dart';
import 'movie.dart';

class MovieList extends StatefulWidget {
  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  late HttpHelper helper;

  List<Movie> movies = [];

  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  Icon visibleIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Movies');

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    initialize();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: searchBar,
        actions: [

          IconButton(
            icon: visibleIcon,

            onPressed: () {

              setState(() {

                if (visibleIcon.icon == Icons.search) {

                  visibleIcon = const Icon(Icons.cancel);

                  searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: search,
                    style: const TextStyle(color: Colors.white,fontSize: 20),
                  );

                } else {

                  visibleIcon = const Icon(Icons.search);
                  searchBar = const Text('Movies');

                }
              });
            },
          ),
        ],
      ),

      body: ListView.builder(

        itemCount: movies.length,

        itemBuilder: (context, index) {

          final movie = movies[index];

          final image = NetworkImage(
            movie.posterPath != null
                ? iconBase + movie.posterPath!
                : defaultImage,
          );

          return Card(

            child: ListTile(

              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetail(movie),
                  ),
                );
              },

              leading: CircleAvatar(backgroundImage: image),

              title: Text(movie.title),

              subtitle: Text(
                'Released: ${movie.releaseDate} - Vote: ${movie.voteAverage}',
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> search(String text) async {

    final result = await helper.findMovies(text);

    if (!mounted) return;

    setState(() {
      movies = result;
    });
  }

  Future<void> initialize() async {

    final result = await helper.getUpcoming();

    if (!mounted) return;

    setState(() {
      movies = result;
    });
  }
}
