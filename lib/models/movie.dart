class Movie {
  String title;
  String backDropPath;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  double voteAverage;

  Movie(
      {required this.title,
      required this.backDropPath,
      required this.originalTitle,
      required this.overview,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAverage});

  //for fetching the data from json file
  factory Movie.fromJson(Map<String,dynamic> json){
    return Movie(
      title: json["title"] ?? "No Title", //if there is no any title this will be the default value
      backDropPath: json["backdrop_path"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      voteAverage: json["vote_average"].toDouble(),
    );
  }

  //for posting data in json file but currently we dont need this
  // Map<String,dynamic> toJson()=>{
  //   "title": title,
  //   "overview":overview
  // };


}
