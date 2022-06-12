import 'package:hive/hive.dart';
import 'package:wavie/data/models/user.dart';
import '../../domain/entities/movie_detail_entity.dart';

class Boxes {
  static Box<bool> getIsAlwaysDown() => Hive.box<bool>('isAlwaysDown');
  static Box<MovieDetailEntity> getPlaying() =>
      Hive.box<MovieDetailEntity>('currentPlaying');
  static Box<MovieDetailEntity> getMyList() =>
      Hive.box<MovieDetailEntity>('myList');

  static Box<String> getTimeStamp() => Hive.box<String>('timeStamp');
  static Box<User> getMyUser() => Hive.box<User>('myUserBox');
  static Box<String> getMyToken() => Hive.box<String>('authenticationBox');
}
