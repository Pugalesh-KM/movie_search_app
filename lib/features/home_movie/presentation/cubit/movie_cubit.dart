import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/search_movies.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final SearchMovies searchMovies;

  MovieCubit(this.searchMovies) : super(MovieInitial());

  void search(String query) async {
    emit(MovieLoading());
    try {
      final result = await searchMovies(query);
      emit(MovieLoaded(result));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
}