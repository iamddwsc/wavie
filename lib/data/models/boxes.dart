import 'package:hive/hive.dart';
import '../../domain/entities/movie_detail_entity.dart';
import 'movie_detail_model.dart';

class Boxes {
  static Box<MovieDetailEntity> getPlaying() =>
      Hive.box<MovieDetailEntity>('currentPlaying');
  static Box<MovieDetailEntity> getMyList() =>
      Hive.box<MovieDetailEntity>('myList');
  static Box<bool> getIsAlwaysDown() => Hive.box<bool>('isAlwaysDown');
  static Box<String> getTimeStamp() => Hive.box<String>('timeStamp');
}
