import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/models/rawg_game_summary_dto.dart';
import '../../../core/state/async_state.dart';
import '../../home/data/discovery_repository.dart';

class SearchState {
  const SearchState({
    this.query = '',
    this.results = const AsyncLoading(),
  });

  final String query;
  final AsyncState<List<RawgGameSummaryDto>> results;

  SearchState copyWith({
    String? query,
    AsyncState<List<RawgGameSummaryDto>>? results,
  }) {
    return SearchState(
      query: query ?? this.query,
      results: results ?? this.results,
    );
  }
}

class SearchNotifier extends ChangeNotifier {
  SearchNotifier(this._repository);

  final DiscoveryRepository _repository;

  SearchState _state = const SearchState();
  SearchState get state => _state;

  Timer? _debounceTimer;

  void updateQuery(String query) {
    _state = _state.copyWith(query: query);
    notifyListeners();

    _debounceTimer?.cancel();

    if (query.trim().isEmpty) {
      _state = _state.copyWith(results: const AsyncLoading());
      notifyListeners();
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _search(query);
    });
  }

  Future<void> _search(String query) async {
    _state = _state.copyWith(results: const AsyncLoading());
    notifyListeners();

    try {
      final games = await _repository.searchGames(query);

      _state = _state.copyWith(
        results: games.isEmpty ? const AsyncEmpty() : AsyncData(games),
      );
    } catch (e) {
      _state = _state.copyWith(results: AsyncError(e.toString()));
    }
    notifyListeners();
  }

  Future<void> retry() async {
    if (_state.query.isNotEmpty) {
      await _search(_state.query);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
