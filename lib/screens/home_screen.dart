import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_catalog/models/movie.dart';
import 'package:movie_catalog/services/api_services.dart';
import 'package:movie_catalog/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices _apiServices = ApiServices();
  final TextEditingController _searchController = TextEditingController();

  List<Movie> _movies = [];
  bool _isLoading = true;
  bool _isSearching = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchNowPlayingMovies();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _fetchNowPlayingMovies() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final movies = await _apiServices.getNowPlayingMovies();
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load movies: $e')));
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final query = _searchController.text;
      if (query.isNotEmpty) {
        setState(() {
          _isLoading = true;
        });
        try {
          final movies = await _apiServices.searchMovies(query);
          setState(() {
            _movies = movies;
            _isLoading = false;
          });
        } catch (e) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to search movies: $e')),
          );
        }
      } else {
        _fetchNowPlayingMovies();
      }
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search movies...',
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            )
          : const Text('Movie Catalog'),
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) {
                _searchController.clear();
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_movies.isEmpty) {
      return const Center(
        child: Text(
          'No movies found.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3.5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _movies.length,
      itemBuilder: (context, index) {
        final movie = _movies[index];
        return MovieCard(movie: movie);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Movie Catalog'),
  //       backgroundColor: Colors.deepPurple,
  //       foregroundColor: Colors.white,
  //     ),
  //     body: FutureBuilder<List<Movie>>(
  //       future: nowPlayingMovies,
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(child: CircularProgressIndicator());
  //         } else if (snapshot.hasError) {
  //           return Center(child: Text('Error: ${snapshot.error}'));
  //         } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
  //           final movies = snapshot.data!;
  //           return ListView.builder(
  //             itemCount: movies.length,
  //             itemBuilder: (context, index) {
  //               final movie = movies[index];
  //               return ListTile(
  //                 title: Text(movie.title),
  //                 subtitle: Text('Release Date: ${movie.releaseDate}'),
  //                 leading: Image.network(
  //                   'https://image.tmdb.org/t/p/w200${movie.posterPath}',
  //                   errorBuilder: (context, error, stackTrace) {
  //                     return const Icon(Icons.movie);
  //                   },
  //                 ),
  //               );
  //             },
  //           );
  //         } else {
  //           return const Center(child: Text('No movies found :('));
  //         }
  //       },
  //     ),
  //   );
  // }
}
