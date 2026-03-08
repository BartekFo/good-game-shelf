import 'local_checklist_item.dart';

class LocalGameProgress {
  const LocalGameProgress({
    required this.completionPercent,
    this.checklist = const <LocalChecklistItem>[],
  });

  final int completionPercent;
  final List<LocalChecklistItem> checklist;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'completionPercent': completionPercent,
      'checklist': checklist
          .map((LocalChecklistItem item) => item.toJson())
          .toList(),
    };
  }

  factory LocalGameProgress.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawChecklist =
        json['checklist'] as List<dynamic>? ?? <dynamic>[];

    return LocalGameProgress(
      completionPercent: (json['completionPercent'] as num?)?.toInt() ?? 0,
      checklist: rawChecklist
          .map(
            (dynamic item) =>
                LocalChecklistItem.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
