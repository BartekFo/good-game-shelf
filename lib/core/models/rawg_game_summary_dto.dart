class RawgGameSummaryDto {
  const RawgGameSummaryDto({
    required this.id,
    required this.name,
    this.backgroundImage,
    this.rating,
    this.released,
  });

  final int id;
  final String name;
  final String? backgroundImage;
  final double? rating;
  final String? released;

  factory RawgGameSummaryDto.fromJson(Map<String, dynamic> json) {
    return RawgGameSummaryDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? 'Unknown title',
      backgroundImage: json['background_image'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      released: json['released'] as String?,
    );
  }
}
