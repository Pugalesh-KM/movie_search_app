import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/movie_repository.dart';
import 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final MovieRepository repository;

  MovieDetailCubit(this.repository) : super(MovieDetailInitial());

  void fetchDetailById(String imdbId) async {
    emit(MovieDetailLoading());
    try {
      final detail = await repository.getMovieDetailById(imdbId);
      emit(MovieDetailLoaded(detail));
    } catch (e) {
      emit(MovieDetailError(e.toString()));
    }
  }
}
