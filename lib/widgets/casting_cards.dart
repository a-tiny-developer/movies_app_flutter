import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:movies_app_flutter/models/models.dart';
import 'package:movies_app_flutter/providers/providers.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MoviesProvider>(context, listen: false)
          .getMovieCast(movieId),
      builder: (context, AsyncSnapshot<List<Cast>> snapshot) {
        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: snapshot.hasData
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return _CastCard(actor: snapshot.data![index]);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({
    Key? key,
    required this.actor,
  }) : super(key: key);

  final Cast actor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
