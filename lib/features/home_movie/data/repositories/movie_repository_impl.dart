
import 'package:movie_search_app/core/constants/api_constants.dart';
import 'package:movie_search_app/core/network/network_services.dart';
import 'package:movie_search_app/features/home_movie/data/models/movie_detail_model.dart';
import 'package:movie_search_app/features/home_movie/domain/entities/movie_detail_entity.dart';
import 'package:movie_search_app/features/home_movie/domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final NetworkServices network;

  MovieRepositoryImpl({required this.network});

  @override
  Future<List<MovieEntity>> searchMovies(String query) async {
    final response = await network.get('', params: {
      'apikey': ApiConstants.apiKey,
      's': query,
    });

    final data = response.data;

    if (data['Response'] == 'True') {
      return List<MovieEntity>.from(data['Search'].map((e) => MovieModel.fromJson(e)));
    } else {
      throw Exception(data['Error'] ?? 'No results found');
    }
  }

  @override
  Future<MovieDetailEntity> getMovieDetailById(String imdbId) async {
    final response = await network.get('', params: {
      'apikey': ApiConstants.apiKey,
      'i': imdbId,
    });

    final data = response.data;

    if (data['Response'] == 'True') {
      return MovieDetailModel.fromJson(data);
    } else {
      throw Exception(data['Error'] ?? 'Movie not found');
    }
  }

}