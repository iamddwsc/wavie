import 'package:flutter/material.dart';

class MovieEntity {
  final int? movieId;
  final String? title;
  final String? genres;
  final String? description;
  final String? rating;
  final String? duration;
  final String? director_stars;
  final int? year;
  final String? image_url;

  const MovieEntity(
      {required this.movieId,
      required this.title,
      required this.genres,
      required this.description,
      required this.rating,
      required this.duration,
      required this.director_stars,
      required this.year,
      required this.image_url});

  List<Object> get probs => [movieId!, title!];

  bool get stringify => true;
}
