import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/features/home_movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_search_app/shared/config/dimens.dart';
import 'package:movie_search_app/shared/theme/text_styles.dart';
import '../cubit/movie_detail_cubit.dart';
import '../cubit/movie_detail_state.dart';

class MovieDetailPage extends StatelessWidget {
  final String imdbID;
  final MovieRepositoryImpl repository;

  const MovieDetailPage({
    super.key,
    required this.imdbID,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieDetailCubit(repository)..fetchDetailById(imdbID),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movie Detail'),
          centerTitle: true,
        ),
        body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailLoaded) {
              final movie = state.movie;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(Dimens.standard_16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimens.standard_12),
                        child: Hero(
                          tag: movie.imdbID,
                          child: Image.network(
                            movie.poster,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: Dimens.standard_100),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimens.standard_20),
                    Text(
                      movie.title,
                      style: AppTextStyles.openSansBold24,
                    ),
                    const SizedBox(height: Dimens.standard_4),
                    Text(
                      '${movie.year} • ${movie.runtime} • ${movie.genre}',
                      style: AppTextStyles.openSansRegular14w400,
                    ),
                    const SizedBox(height: Dimens.standard_16),
                    _buildInfoBlock('Director', movie.director),
                    _buildInfoBlock('Actors', movie.actors),
                    _buildInfoBlock('Plot', movie.plot),
                    _buildInfoBlock('IMDB Rating', movie.imdbRating),
                    _buildInfoBlock('Box Office', movie.boxOffice),
                  ],
                ),
              );
            } else if (state is MovieDetailError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: AppTextStyles.openSansRegular14w400,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfoBlock(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.standard_12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.openSansBold18),
          const SizedBox(height: Dimens.standard_4),
          Text(
            value.isNotEmpty ? value : 'N/A',
            style: AppTextStyles.openSansRegular14w400,
          ),
        ],
      ),
    );
  }
}
