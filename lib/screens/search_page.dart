import 'package:flutter/material.dart';
import 'package:movie_app/colors.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/widgets/movie_list.dart';
import 'package:movie_app/widgets/back_button.dart';

import '../api/api.dart';
import '../models/movie.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<List<Movie>> mainMoviesList = Api().searchMovies();
  final TextEditingController _searchController = TextEditingController();
  //List<Movie> display_list = List.from(mainMoviesList);

  // void updateList(String value){
  //   setState(() {
  //     display_list = mainMoviesList.;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: const BackBtn(),
        backgroundColor: MyColors.scaffoldBgColor,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            MyColors.scaffoldBgColor,
            Color(0xff09203f),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Search for a Movie",
                style: TextStyle(fontSize: mq.width * .08),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none),
                    hintText: "eg: The Dark Knight",
                    prefixIcon: const Icon(Icons.search_sharp)),
              ),
              const Padding(padding: EdgeInsets.all(11.0)),
              Expanded(
                child: FutureBuilder(
                    future: mainMoviesList,
                    builder: (context, snapshot) =>
                        MovieList(snapshot: snapshot)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
