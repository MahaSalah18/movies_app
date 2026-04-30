import 'package:flutter/material.dart';
import 'package:movies_app/features/widgets/movie_card.dart';
import 'package:movies_app/features/search/viewModel/search_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                controller: _controller,
                onChanged: (query) =>
                    context.read<SearchProvider>().searchMovies(query),
                decoration: InputDecoration(
                  hintText: 'Search for movies',
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          onPressed: () {
                            _controller.clear();
                            context.read<SearchProvider>().clearSearch();
                          },
                        )
                      : null,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
              ),
              SizedBox(height: 30),
              Expanded(child: _buildBody(provider, context)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildBody(SearchProvider provider, BuildContext context) {
  if (!provider.hasSearched) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.search,
              size: 80,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Find Your Next Movie',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Search for movies, actors, or genres',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall?.color,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
  if (provider.isLoading) {
    return const Center(child: CircularProgressIndicator());
  }

  if (provider.errorMessage != null) {
    return Center(
      child: Text(
        provider.errorMessage!,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }

  // ── No Results ──
  if (provider.searchResults.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_outlined,
            color: Theme.of(context).textTheme.bodySmall?.color,
            size: 80,
          ),
          SizedBox(height: 16),
          Text(
            'No movies found',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall?.color,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // ── Results Grid ──
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 16,
      childAspectRatio: 0.65,
    ),
    itemCount: provider.searchResults.length,
    itemBuilder: (context, index) => MovieCard(
      heroTag: 'search',
      movie: provider.searchResults[index],
      width: 120,
      height: 120,
    ),
  );
}
