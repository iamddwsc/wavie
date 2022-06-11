import 'package:hive/hive.dart';
import 'package:wavie/domain/entities/movie_detail_entity.dart';

part 'movie_detail_model.g.dart';

@HiveType(typeId: 1)
class MovieDetailModel extends MovieDetailEntity {
  @HiveField(0)
  int movieId;
  @HiveField(1)
  String title;
  @HiveField(2)
  List<String> genres;
  @HiveField(3)
  String description;
  @HiveField(4)
  String rating;
  @HiveField(5)
  String duration;
  @HiveField(6)
  int year;
  @HiveField(7)
  String? vote;
  @HiveField(8)
  String? metascoreFavorable;
  @HiveField(9)
  String? metascoreMixed;
  @HiveField(10)
  String imageUrl;
  @HiveField(11)
  String videoUrl;
  @HiveField(12)
  List<String>? director;
  @HiveField(13)
  List<String>? cast;

  MovieDetailModel(
      {required this.movieId,
      required this.title,
      required this.genres,
      required this.description,
      required this.rating,
      required this.duration,
      required this.director,
      required this.cast,
      required this.year,
      this.vote,
      this.metascoreFavorable,
      this.metascoreMixed,
      required this.imageUrl,
      required this.videoUrl})
      : super(
            movieId: movieId,
            title: title,
            genres: genres,
            director: director,
            cast: cast,
            description: description,
            rating: rating,
            duration: duration,
            year: year,
            imageUrl: imageUrl,
            videoUrl: videoUrl);

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      movieId: json["movieId"],
      title: json["title"],
      genres: List<String>.from(json["genres"]),
      description: json["description"],
      rating: json["rating"],
      duration: json["duration"],
      director:
          json["director"] == null ? null : List<String>.from(json["director"]),
      cast: json["cast"] == null ? null : List<String>.from(json["cast"]),
      year: json["year"],
      vote: json["vote"],
      metascoreFavorable: json["metascore_favorable"],
      metascoreMixed: json["metascore_mixed"],
      imageUrl: json["image_url"],
      videoUrl: json["video_url"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["movieId"] = this.movieId;
    data["title"] = this.title;
    data["genres"] = this.genres;
    data["description"] = this.description;
    data["rating"] = this.rating;
    data["duration"] = this.duration;
    data["director"] = this.director;
    data["cast"] = this.cast;
    data["year"] = this.year;
    data["vote"] = this.vote;
    data["metascore_favorable"] = this.metascoreFavorable;
    data["metascore_mixed"] = this.metascoreMixed;
    data["image_url"] = this.imageUrl;
    data["video_url"] = this.videoUrl;
    return data;
  }
}
