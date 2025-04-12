import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_ott/utils/constants.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Search'),
        actions: [
          IconButton(
            icon: Icon(
              provider.showFavorites ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: provider.toggleShowFavorites,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed:
                      () => provider.searchMovies(_searchController.text),
                ),
              ),
              onSubmitted: (value) => provider.searchMovies(value),
            ),
          ),
          _buildBody(provider),
        ],
      ),
    );
  }

  Widget _buildBody(MovieProvider provider) {
    if (!provider.isConnected) {
      return Center(child: Text(AppConstants.noInternetMessage));
    }
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.error.isNotEmpty) return Center(child: Text(provider.error));
    if (provider.movies.isEmpty) {
      return const Center(child: Text('No movies found'));
    }

    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: provider.movies.length,
        itemBuilder:
            (context, index) => MovieCard(movie: provider.movies[index]),
      ),
    );
  }
}
