import 'package:flutter/material.dart';

import '../constants.dart';

class MovieList extends StatelessWidget {
  const MovieList({Key? key, required this.snapshot}) : super(key: key);

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) => ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: Image.network(
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            '${Constants.imagepath}${snapshot.data[index].posterPath}'),
        title: Text(
          snapshot.data[index].title!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(snapshot.data[index].releaseDate!),
        trailing: Text(
          snapshot.data[index].voteAverage!,
          style: const TextStyle(color: Colors.amber),
        ),
      ),
    ),);
  }
}
