import 'package:flutter/foundation.dart';

import '../../../core/models/rawg_game_details_dto.dart';
import '../../../core/state/async_state.dart';
import '../../home/data/discovery_repository.dart';

class GameDetailsNotifier extends ChangeNotifier {
  GameDetailsNotifier(this._repository);

  final DiscoveryRepository _repository;

  AsyncState<RawgGameDetailsDto> _state = const AsyncLoading();
  AsyncState<RawgGameDetailsDto> get state => _state;

  String? _gameId;

  Future<void> loadGameDetails(String id) async {
    _gameId = id;
    _state = const AsyncLoading();
    notifyListeners();

    try {
      final details = await _repository.getGameDetails(id);
      _state = AsyncData(details);
    } catch (e) {
      _state = AsyncError(e.toString());
    }
    notifyListeners();
  }

  Future<void> retry() async {
    if (_gameId != null) {
      await loadGameDetails(_gameId!);
    }
  }
}
