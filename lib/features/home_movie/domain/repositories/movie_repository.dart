import 'package:movie_search_app/features/home_movie/domain/entities/movie_detail_entity.dart';

import '../entities/movie_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> searchMovies(String query);
  Future<MovieDetailEntity> getMovieDetailById(String imdbId);
}