import 'local_game_progress.dart';
import 'local_game_status.dart';

class LocalSavedGame {
  const LocalSavedGame({
    required this.id,
    required this.title,
    this.coverUrl,
    this.status = LocalGameStatus.planToPlay,
    this.progress = const LocalGameProgress(completionPercent: 0),
  });

  final int id;
  final String title;
  final String? coverUrl;
  final LocalGameStatus status;
  final LocalGameProgress progress;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'coverUrl': coverUrl,
      'status': status.name,
      'progress': progress.toJson(),
    };
  }

  factory LocalSavedGame.fromJson(Map<String, dynamic> json) {
    final String statusName =
        json['status'] as String? ?? LocalGameStatus.planToPlay.name;

    return LocalSavedGame(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? 'Unknown title',
      coverUrl: json['coverUrl'] as String?,
      status: LocalGameStatus.values.firstWhere(
        (LocalGameStatus status) => status.name == statusName,
        orElse: () => LocalGameStatus.planToPlay,
      ),
      progress: LocalGameProgress.fromJson(
        json['progress'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
    );
  }
}
