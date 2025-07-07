import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_search_app/core/constants/api_constants.dart';
import 'package:movie_search_app/core/network/network_services.dart';
import 'package:movie_search_app/features/home_movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_search_app/movie_app.dart';
import 'package:movie_search_app/shared/cubit/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final settingsBox = await Hive.openBox('settings');
  final network = NetworkServices(baseUrl: ApiConstants.baseUrl);
  final repository = MovieRepositoryImpl(network: network);

  final savedThemeIndex = settingsBox.get('themeMode', defaultValue: 0);
  final initialTheme = ThemeMode.values[savedThemeIndex];

  runApp(
    RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (context) => ThemeCubit(initialTheme),
        child: MovieApp(),
      ),
    ),
  );
}
