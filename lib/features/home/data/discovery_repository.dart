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
}
