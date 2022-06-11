import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'movie_detail_entity.g.dart';

@HiveType(typeId: 2)
class MovieDetailEntity extends Equatable {
  @HiveField(0)
  final int movieId;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final int year;
  @HiveField(4)
  final List<String>? genres;
  @HiveField(5)
  final List<String>? director;
  @HiveField(6)
  final List<String>? cast;
  @HiveField(7)
  final String rating;
  @HiveField(8)
  final String duration;
  @HiveField(9)
  final String imageUrl;
  @HiveField(10)
  final String videoUrl;

  MovieDetailEntity(
      {required this.movieId,
      required this.title,
      required this.description,
      required this.year,
      required this.genres,
      required this.director,
      required this.cast,
      required this.rating,
      required this.duration,
      required this.imageUrl,
      required this.videoUrl});
  @override
  // TODO: implement props
  List<Object?> get props => [movieId];
}
