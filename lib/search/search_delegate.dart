import 'package:flutter/material.dart';
import 'package:movies_app_flutter/models/models.dart';
import 'package:movies_app_flutter/providers/providers.dart';
import 'package:movies_app_flutter/router/router.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search Movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    if (query.isEmpty || query.trim() == "") {
      return const _EmptyContainer();
    } else {
      moviesProvider.getSuggestionByQuery(query);
      return StreamBuilder(
        stream: moviesProvider.suggestionStream,
        builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return _MovieItem(movie: snapshot.data![index]);
                  },
                )
              : const _EmptyContainer();
        },
      );
    }
  }
}

class _EmptyContainer extends StatelessWidget {
  const _EmptyContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.movie_creation_outlined,
        color: Colors.black38,
        size: 100,
      ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    movie.heroId = "search-${movie.id}";
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/images/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
        ),
      ),
      title: Text(movie.title),
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.detailsRoute,
          arguments: movie,
        );
      },
    );
  }
}
