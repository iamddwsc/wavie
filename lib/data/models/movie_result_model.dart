import 'package:wavie/data/models/movie_model.dart';

class MovieResultModel {
  bool? success;
  List<MovieModel>? movies;

  MovieResultModel({this.success, this.movies});

  MovieResultModel.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.movies = json["results"] == null
        ? null
        : (json["results"] as List).map((e) => MovieModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    if (this.movies != null)
      data["results"] = this.movies?.map((e) => e.toJson()).toList();
    return data;
  }
}
