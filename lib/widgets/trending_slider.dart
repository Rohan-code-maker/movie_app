import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/details_screen.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({super.key, required this.snapshot});

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
          itemCount: snapshot.data!.length,
          options: CarouselOptions(
              height: mq.height * .35,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              autoPlayCurve: Curves.fastOutSlowIn,
              pageSnapping: true,
              enlargeCenterPage: true,
              viewportFraction: 0.55),
          itemBuilder: (context, itemIndex, PageViewIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailScreen(
                              movie: snapshot.data[itemIndex],
                            )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: mq.height * .35,
                  width: mq.width * .5,
                  child: Image.network(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    '${Constants.imagepath}${snapshot.data[itemIndex].posterPath}',
                  ),
                ),
              ),
            );
          }),
    );
  }
}
