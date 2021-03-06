// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDetailEntityAdapter extends TypeAdapter<MovieDetailEntity> {
  @override
  final int typeId = 2;

  @override
  MovieDetailEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDetailEntity(
      movieId: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      year: fields[3] as int,
      genres: (fields[4] as List?)?.cast<String>(),
      director: (fields[5] as List?)?.cast<String>(),
      cast: (fields[6] as List?)?.cast<String>(),
      rating: fields[7] as String,
      duration: fields[8] as String,
      imageUrl: fields[9] as String,
      videoUrl: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MovieDetailEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.movieId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.year)
      ..writeByte(4)
      ..write(obj.genres)
      ..writeByte(5)
      ..write(obj.director)
      ..writeByte(6)
      ..write(obj.cast)
      ..writeByte(7)
      ..write(obj.rating)
      ..writeByte(8)
      ..write(obj.duration)
      ..writeByte(9)
      ..write(obj.imageUrl)
      ..writeByte(10)
      ..write(obj.videoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDetailEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
