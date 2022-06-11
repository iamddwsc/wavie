import 'package:hive/hive.dart';
import 'package:wavie/domain/entities/movie_entity.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel extends MovieEntity {
  @HiveField(0)
  int? movieId;
  @HiveField(1)
  String? title;
  @HiveField(2)
  List<String>? genres;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? rating;
  @HiveField(5)
  String? duration;
  @HiveField(6)
  String? director_stars;
  @HiveField(7)
  int? year;
  @HiveField(8)
  String? vote;
  @HiveField(9)
  String? metascoreFavorable;
  @HiveField(10)
  String? metascoreMixed;
  @HiveField(11)
  String? image_url;
  @HiveField(12)
  String? videoUrl;

  MovieModel(
      {this.movieId,
      this.title,
      this.genres,
      this.description,
      this.rating,
      this.duration,
      this.director_stars,
      this.year,
      this.vote,
      this.metascoreFavorable,
      this.metascoreMixed,
      this.image_url,
      this.videoUrl})
      : super(
            movieId: movieId,
            title: title,
            genres: genres,
            description: description,
            rating: rating,
            duration: duration,
            director_stars: director_stars,
            year: year,
            image_url: image_url,
            video_url: videoUrl);

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      movieId: json["movieId"],
      title: json["title"],
      genres: List<String>.from(json["genres"]),
      description: json["description"],
      rating: json["rating"],
      duration: json["duration"],
      director_stars: json["director_stars"],
      year: json["year"],
      vote: json["vote"],
      metascoreFavorable: json["metascore_favorable"],
      metascoreMixed: json["metascore_mixed"],
      image_url: json["image_url"],
      videoUrl: json["video_url"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["movieId"] = this.movieId;
    data["title"] = this.title;
    if (this.genres != null) {
      data["genres"] = this.genres;
    }
    data["description"] = this.description;
    data["rating"] = this.rating;
    data["duration"] = this.duration;
    data["director_stars"] = this.director_stars;
    data["year"] = this.year;
    data["vote"] = this.vote;
    data["metascore_favorable"] = this.metascoreFavorable;
    data["metascore_mixed"] = this.metascoreMixed;
    data["image_url"] = this.image_url;
    data["video_url"] = this.videoUrl;
    return data;
  }
}
