class LocalChecklistItem {
  const LocalChecklistItem({
    required this.id,
    required this.label,
    this.isDone = false,
  });

  final String id;
  final String label;
  final bool isDone;

  LocalChecklistItem copyWith({String? id, String? label, bool? isDone}) {
    return LocalChecklistItem(
      id: id ?? this.id,
      label: label ?? this.label,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'label': label,
      'isDone': isDone,
    };
  }

  factory LocalChecklistItem.fromJson(Map<String, dynamic> json) {
    return LocalChecklistItem(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? '',
      isDone: json['isDone'] as bool? ?? false,
    );
  }
}
