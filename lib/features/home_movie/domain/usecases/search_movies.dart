import 'package:movie_search_app/features/home_movie/domain/entities/movie_detail_entity.dart';

import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<List<MovieEntity>> call(String query) => repository.searchMovies(query);

  Future<MovieDetailEntity> callSingle(String imdbId) => repository.getMovieDetailById(imdbId);

}