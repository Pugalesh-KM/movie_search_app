import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/features/home_movie/presentation/pages/movie_detail_page.dart';
import 'package:movie_search_app/features/home_movie/presentation/widgets/custom_search_bar.dart';
import 'package:movie_search_app/shared/config/dimens.dart';
import 'package:movie_search_app/shared/cubit/theme_cubit.dart';
import 'package:movie_search_app/shared/theme/text_styles.dart';

import '../cubit/movie_cubit.dart';
import '../cubit/movie_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Search', style: AppTextStyles.openSansBold24),
        centerTitle: true,
        actions: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) {
              final isDark = mode == ThemeMode.dark;
              return IconButton(
                icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme(!isDark);
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimens.standard_12),
        child: Column(
          children: [
            CustomSearchBar(
              controller: _controller,
              onSubmitted: (query) => context.read<MovieCubit>().search(query),
              onClear: () {
                _controller.clear();
              },
            ),
            const SizedBox(height: Dimens.standard_12),
            Expanded(
              child: BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieLoaded) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: state.movies.length,
                      itemBuilder: (_, index) {
                        final movie = state.movies[index];
                        final hasPoster = movie.poster != 'N/A';
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MovieDetailPage(imdbID: movie.imdbID, repository: RepositoryProvider.of(context),),
                              ),
                            );
                          },
                          child: Card(
                            elevation: Dimens.standard_3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: hasPoster
                                      ? Image.network(
                                          movie.poster,
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                        )
                                      : const Center(
                                          child: Icon(Icons.image_not_supported),
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(Dimens.standard_8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.openSansBold18,
                                      ),
                                      Text(
                                        movie.year,
                                        style:
                                            AppTextStyles.openSansRegular14w400,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is MovieError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(
                      child: Text(
                        'Search for a movie',
                        style: AppTextStyles.openSansBold24,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
