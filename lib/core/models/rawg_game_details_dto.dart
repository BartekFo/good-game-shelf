class RawgGameDetailsDto {
  const RawgGameDetailsDto({
    required this.id,
    required this.name,
    this.description,
    this.backgroundImage,
    this.rating,
    this.released,
    this.genres = const <String>[],
    this.platforms = const <String>[],
  });

  final int id;
  final String name;
  final String? description;
  final String? backgroundImage;
  final double? rating;
  final String? released;
  final List<String> genres;
  final List<String> platforms;

  factory RawgGameDetailsDto.fromJson(Map<String, dynamic> json) {
    final List<String> genres = (json['genres'] as List<dynamic>? ?? <dynamic>[])
        .map((dynamic item) => (item as Map<String, dynamic>)['name'] as String? ?? '')
        .where((String item) => item.isNotEmpty)
        .toList();

    final List<String> platforms =
        (json['platforms'] as List<dynamic>? ?? <dynamic>[])
            .map((dynamic item) {
              final Map<String, dynamic> platformWrapper =
                  item as Map<String, dynamic>;
              final Map<String, dynamic>? platform =
                  platformWrapper['platform'] as Map<String, dynamic>?;
              return platform?['name'] as String? ?? '';
            })
            .where((String item) => item.isNotEmpty)
            .toList();

    return RawgGameDetailsDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? 'Unknown title',
      description: json['description_raw'] as String? ?? json['description'] as String?,
      backgroundImage: json['background_image'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      released: json['released'] as String?,
      genres: genres,
      platforms: platforms,
    );
  }
}
