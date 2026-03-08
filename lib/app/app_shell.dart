import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/network/api_client.dart';
import '../core/network/rawg_api_client.dart';
import '../features/home/data/discovery_repository.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/home/state/home_notifier.dart';
import '../features/library/presentation/library_screen.dart';
import '../features/search/presentation/search_screen.dart';
import '../features/search/state/search_notifier.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (int index) {
          navigationShell.goBranch(index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.video_library_outlined),
            selectedIcon: Icon(Icons.video_library),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}

final _apiClient = ApiClient();
final _rawgApiClient = RawgApiClient(_apiClient);
final _discoveryRepository = DiscoveryRepository(_rawgApiClient);
final _homeNotifier = HomeNotifier(_discoveryRepository);
final _searchNotifier = SearchNotifier(_discoveryRepository);

final Widget homeBranchRoot = const HomeScaffold();
final Widget searchBranchRoot = const SearchScaffold();
final Widget libraryBranchRoot = const LibraryScaffold();

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: HomeScreen(homeNotifier: _homeNotifier),
    );
  }
}

class SearchScaffold extends StatelessWidget {
  const SearchScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SearchScreen(searchNotifier: _searchNotifier),
    );
  }
}

class LibraryScaffold extends StatelessWidget {
  const LibraryScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Library'),
      ),
      body: const LibraryScreen(),
    );
  }
}
