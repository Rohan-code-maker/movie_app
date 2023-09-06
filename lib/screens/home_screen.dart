import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/colors.dart';
import 'package:movie_app/screens/login_screen.dart';
import 'package:movie_app/screens/search_page.dart';
import 'package:movie_app/widgets/movie_slider.dart';
import 'package:movie_app/widgets/trending_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api.dart';
import '../models/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upComingMovies;
  late Future<List<Movie>> popularMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upComingMovies = Api().getUpComingMovies();
    popularMovies = Api().getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.scaffoldBgColor,
        elevation: 0,
        title: Text(
          "MovieZ",
          style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.normal,
              fontSize: mq.width * .1,
              color: Colors.red),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SearchPage()));
          }, icon: const Icon(Icons.search_sharp)),
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  title: const Text("Confirm Logout"),
                  content: const Text("Are you sure You want to Logout"),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    const Padding(padding: EdgeInsets.all(5.0)),
                    ElevatedButton(
                        onPressed: () async {
                          FirebaseAuth.instance.signOut();
                          Navigator.pop(context);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove('rememberMe');
                          navigateToLogin();
                        },
                        child: const Text("Confirm"))
                  ],
                );
              });
            },
          )
        ],
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Trending Movies",
                  style: GoogleFonts.aBeeZee(
                      fontSize: mq.width * .08, color: Colors.white),
                ),
                SizedBox(
                  height: mq.height * .02,
                ),
                SizedBox(
                  child: FutureBuilder(
                    future: trendingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return TrendingSlider(
                          snapshot: snapshot,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: mq.height * .05,
                ),
                Text(
                  "Top Rated Movies",
                  style: GoogleFonts.aBeeZee(
                    fontSize: mq.width * .08,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: mq.height * .02,
                ),
                SizedBox(
                  child: FutureBuilder(
                    future: topRatedMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (snapshot.hasData) {
                        return MovieSlider(snapshot: snapshot);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: mq.height * .05,
                ),
                Text(
                  "UpComing Movies",
                  style: GoogleFonts.aBeeZee(
                    fontSize: mq.width * .08,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: mq.height * .02,
                ),
                SizedBox(
                  child: FutureBuilder(
                    future: upComingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (snapshot.hasData) {
                        return MovieSlider(snapshot: snapshot);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: mq.height * .05,
                ),
                Text(
                  "Popular Movies",
                  style: GoogleFonts.aBeeZee(
                    fontSize: mq.width * .08,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: mq.height * .02,
                ),
                SizedBox(
                  child: FutureBuilder(
                    future: popularMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (snapshot.hasData) {
                        return MovieSlider(snapshot: snapshot);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const LoginScreen();
    }));
  }
}
