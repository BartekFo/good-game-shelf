import 'package:flutter/foundation.dart';

import '../../../core/models/rawg_game_summary_dto.dart';
import '../../../core/state/async_state.dart';
import '../data/discovery_repository.dart';

class HomeState {
  const HomeState({
    this.trendingGames = const AsyncLoading(),
    this.popularGames = const AsyncLoading(),
  });

  final AsyncState<List<RawgGameSummaryDto>> trendingGames;
  final AsyncState<List<RawgGameSummaryDto>> popularGames;

  HomeState copyWith({
    AsyncState<List<RawgGameSummaryDto>>? trendingGames,
    AsyncState<List<RawgGameSummaryDto>>? popularGames,
  }) {
    return HomeState(
      trendingGames: trendingGames ?? this.trendingGames,
      popularGames: popularGames ?? this.popularGames,
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
    );
    notifyListeners();

    try {
      final trending = await _repository.getTrendingGames();
      final popular = await _repository.getTrendingGames(page: 2);

      _state = _state.copyWith(
        trendingGames: trending.isEmpty
            ? const AsyncEmpty()
            : AsyncData(trending),
        popularGames: popular.isEmpty
            ? const AsyncEmpty()
            : AsyncData(popular),
      );
    } catch (e) {
      _state = _state.copyWith(
        trendingGames: AsyncError(e.toString()),
        popularGames: AsyncError(e.toString()),
      );
    }
    notifyListeners();
  }

  Future<void> refresh() async {
    await loadGames();
  }
}
