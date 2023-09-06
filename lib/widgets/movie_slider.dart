import 'package:flutter/material.dart';
import 'package:movie_app/screens/details_screen.dart';

import '../constants.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key, required this.snapshot});

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return SizedBox(
      height: mq.height * .25,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailScreen(
                                movie: snapshot.data[index],
                              )));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: mq.height * .25,
                    width: mq.width * .35,
                    child: Image.network(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        '${Constants.imagepath}${snapshot.data![index].posterPath}'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
