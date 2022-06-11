// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDetailModelAdapter extends TypeAdapter<MovieDetailModel> {
  @override
  final int typeId = 1;

  @override
  MovieDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDetailModel(
      movieId: fields[0] as int,
      title: fields[1] as String,
      genres: (fields[2] as List).cast<String>(),
      description: fields[3] as String,
      rating: fields[4] as String,
      duration: fields[5] as String,
      director: (fields[12] as List?)?.cast<String>(),
      cast: (fields[13] as List?)?.cast<String>(),
      year: fields[6] as int,
      vote: fields[7] as String?,
      metascoreFavorable: fields[8] as String?,
      metascoreMixed: fields[9] as String?,
      imageUrl: fields[10] as String,
      videoUrl: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MovieDetailModel obj) {
    writer
      ..writeByte(14)
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
      ..write(obj.year)
      ..writeByte(7)
      ..write(obj.vote)
      ..writeByte(8)
      ..write(obj.metascoreFavorable)
      ..writeByte(9)
      ..write(obj.metascoreMixed)
      ..writeByte(10)
      ..write(obj.imageUrl)
      ..writeByte(11)
      ..write(obj.videoUrl)
      ..writeByte(12)
      ..write(obj.director)
      ..writeByte(13)
      ..write(obj.cast);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
