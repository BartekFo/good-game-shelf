import 'package:flutter/foundation.dart';

import '../../../core/models/rawg_game_summary_dto.dart';
import '../../../core/state/async_state.dart';
import '../data/discovery_repository.dart';

class HomeState {
  const HomeState({
    this.trendingGames = const AsyncLoading(),
    this.popularGames = const AsyncLoading(),
    this.recentlyReleasedGames = const AsyncLoading(),
  });

  final AsyncState<List<RawgGameSummaryDto>> trendingGames;
  final AsyncState<List<RawgGameSummaryDto>> popularGames;
  final AsyncState<List<RawgGameSummaryDto>> recentlyReleasedGames;

  HomeState copyWith({
    AsyncState<List<RawgGameSummaryDto>>? trendingGames,
    AsyncState<List<RawgGameSummaryDto>>? popularGames,
    AsyncState<List<RawgGameSummaryDto>>? recentlyReleasedGames,
  }) {
    return HomeState(
      trendingGames: trendingGames ?? this.trendingGames,
      popularGames: popularGames ?? this.popularGames,
      recentlyReleasedGames: recentlyReleasedGames ?? this.recentlyReleasedGames,
    );
  }
}

class HomeNotifier extends ChangeNotifier {
  HomeNotifier(this._repository);

  final DiscoveryRepository _repository;

  HomeState _state = const HomeState();
  HomeState get state => _state;

  Future<void> loadGames() async {
    _state = _state.copyWith(
      trendingGames: const AsyncLoading(),
      popularGames: const AsyncLoading(),
      recentlyReleasedGames: const AsyncLoading(),
    );
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.getTrendingGames(),
        _repository.getTrendingGames(page: 2),
        _repository.getRecentlyReleasedGames(),
      ]);
      final trending = results[0];
      final popular = results[1];
      final recentlyReleased = results[2];

      _state = _state.copyWith(
        trendingGames: trending.isEmpty
            ? const AsyncEmpty()
            : AsyncData(trending),
        popularGames: popular.isEmpty
            ? const AsyncEmpty()
            : AsyncData(popular),
        recentlyReleasedGames: recentlyReleased.isEmpty
            ? const AsyncEmpty()
            : AsyncData(recentlyReleased),
      );
    } catch (e) {
      _state = _state.copyWith(
        trendingGames: AsyncError(e.toString()),
        popularGames: AsyncError(e.toString()),
        recentlyReleasedGames: AsyncError(e.toString()),
      );
    }
    notifyListeners();
  }

  Future<void> refresh() async {
    await loadGames();
  }
}
