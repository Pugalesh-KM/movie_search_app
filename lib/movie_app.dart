import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/features/home_movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_search_app/features/home_movie/domain/usecases/search_movies.dart';
import 'package:movie_search_app/features/home_movie/presentation/cubit/movie_cubit.dart';
import 'package:movie_search_app/features/home_movie/presentation/cubit/movie_detail_cubit.dart';
import 'package:movie_search_app/features/home_movie/presentation/pages/home_screen.dart';
import 'package:movie_search_app/shared/cubit/theme_cubit.dart';
import 'package:movie_search_app/shared/theme/app_theme.dart';

class MovieApp extends StatelessWidget {

  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<MovieRepositoryImpl>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieCubit>(
          create: (_) => MovieCubit(SearchMovies(repository)),
        ),
        BlocProvider<MovieDetailCubit>(
          create: (_) => MovieDetailCubit(repository),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Movie Search App',
            themeMode: themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
