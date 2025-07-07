import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.title,
    required super.year,
    required super.poster,
    required super.imdbID,
    required super.type,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['Title'],
      year: json['Year'],
      poster: json['Poster'],
      imdbID: json['imdbID'],
      type: json['Type'],
    );
  }
}
