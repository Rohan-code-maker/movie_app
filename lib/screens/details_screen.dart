import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/api/api.dart';
import 'package:movie_app/colors.dart';
import 'package:movie_app/constants.dart';

import '../models/movie.dart';
import '../widgets/back_button.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [MyColors.scaffoldBgColor,Color(0xff09203f),],
              begin: Alignment.topCenter,end: Alignment.bottomCenter
          ),
        ),
        child: CustomScrollView(slivers: [
          SliverAppBar.large(
            leading: const BackBtn(),
            backgroundColor: MyColors.scaffoldBgColor,
            expandedHeight: mq.height * .5,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                style: GoogleFonts.belleza(
                    fontSize: mq.width * .04, fontWeight: FontWeight.w600),
              ),
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24)),
                child: Image.network(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    '${Constants.imagepath}${movie.posterPath}'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    "Overview",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w800, fontSize: mq.width * .1,color: Colors.redAccent),
                  ),
                  SizedBox(
                    height: mq.height * .02,
                  ),
                  Text(movie.overview,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400, fontSize: mq.width * .08,color: Colors.white)),
                  SizedBox(
                    height: mq.height * .02,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Release Date: ",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold, fontSize: mq.width * .04,color: Colors.white54),
                              ),
                              Text(movie.releaseDate,style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold, fontSize: mq.width * .04,color: Colors.white),)
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(children: [
                            Text("Rating",style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold, fontSize: mq.width * .04,color: Colors.white54),),
                             Icon(Icons.star,color: Colors.amber,size: mq.width * .04,),
                            Text(":${movie.voteAverage.toStringAsFixed(1)}/10",style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold, fontSize: mq.width * .04,color: Colors.white),)
                          ],),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
