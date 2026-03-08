import '../models/rawg_game_details_dto.dart';
import '../models/rawg_game_summary_dto.dart';
import 'api_client.dart';
import 'rawg_endpoints.dart';

class RawgApiClient {
  RawgApiClient(this._apiClient);

  final ApiClient _apiClient;

  Future<List<RawgGameSummaryDto>> fetchGames({String? search, int page = 1}) async {
    final response = await _apiClient.get(
      RawgEndpoints.games,
      queryParameters: <String, dynamic>{
        'page': page,
        if (search != null && search.trim().isNotEmpty) 'search': search,
      },
    );

    final Map<String, dynamic> json = response.data as Map<String, dynamic>;
    final List<dynamic> results = json['results'] as List<dynamic>? ?? <dynamic>[];

    return results
        .map((dynamic item) => RawgGameSummaryDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<RawgGameDetailsDto> fetchGameDetails(String id) async {
    final response = await _apiClient.get(RawgEndpoints.gameDetails(id));
    return RawgGameDetailsDto.fromJson(response.data as Map<String, dynamic>);
  }
}
