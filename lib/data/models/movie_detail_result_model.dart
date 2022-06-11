import 'package:wavie/data/models/movie_detail_model.dart';

class MovieDetailResultModel {
  bool? success;
  MovieDetailModel? movie;

  MovieDetailResultModel({this.success, this.movie});

  MovieDetailResultModel.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.movie = json["results"] == null
        ? null
        : MovieDetailModel.fromJson(json["results"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    if (this.movie != null) data["results"] = this.movie?.toJson();
    return data;
  }
}
