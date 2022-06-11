// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieModelAdapter extends TypeAdapter<MovieModel> {
  @override
  final int typeId = 0;

  @override
  MovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieModel(
      movieId: fields[0] as int?,
      title: fields[1] as String?,
      genres: (fields[2] as List?)?.cast<String>(),
      description: fields[3] as String?,
      rating: fields[4] as String?,
      duration: fields[5] as String?,
      director_stars: fields[6] as String?,
      year: fields[7] as int?,
      vote: fields[8] as String?,
      metascoreFavorable: fields[9] as String?,
      metascoreMixed: fields[10] as String?,
      image_url: fields[11] as String?,
      videoUrl: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.movieId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.genres)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.director_stars)
      ..writeByte(7)
      ..write(obj.year)
      ..writeByte(8)
      ..write(obj.vote)
      ..writeByte(9)
      ..write(obj.metascoreFavorable)
      ..writeByte(10)
      ..write(obj.metascoreMixed)
      ..writeByte(11)
      ..write(obj.image_url)
      ..writeByte(12)
      ..write(obj.videoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
