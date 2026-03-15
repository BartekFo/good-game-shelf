import '../../../core/models/rawg_game_details_dto.dart';
import '../../../core/models/rawg_game_summary_dto.dart';
import '../../../core/network/rawg_api_client.dart';

class DiscoveryRepository {
  DiscoveryRepository(this._apiClient);

  final RawgApiClient _apiClient;

  Future<List<RawgGameSummaryDto>> getTrendingGames({int page = 1}) async {
    return _apiClient.fetchGames(page: page);
  }

  Future<List<RawgGameSummaryDto>> searchGames(String query, {int page = 1}) async {
    if (query.trim().isEmpty) {
      return [];
    }
    return _apiClient.fetchGames(search: query, page: page);
  }

  Future<List<RawgGameSummaryDto>> getRecentlyReleasedGames({int page = 1}) async {
    final now = DateTime.now();
    final threeMonthsAgo = now.subtract(const Duration(days: 90));
    final dates =
        '${threeMonthsAgo.toIso8601String().split('T').first},${now.toIso8601String().split('T').first}';
    return _apiClient.fetchGames(page: page, ordering: '-released', dates: dates);
  }

  Future<RawgGameDetailsDto> getGameDetails(String id) async {
    return _apiClient.fetchGameDetails(id);
  }
}
