import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies_app_flutter/providers/providers.dart';
import 'package:movies_app_flutter/widgets/widgets.dart';
import 'package:movies_app_flutter/search/search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies in cinema'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(
              movies: moviesProvider.onDisplayMovies,
            ),
            MovieSlider(
              title: 'Populares!',
              movies: moviesProvider.popularMovies,
              onNextPage: moviesProvider.getPopularMovies,
            ),
          ],
        ),
      ),
    );
  }
}
