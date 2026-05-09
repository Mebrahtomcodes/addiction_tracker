class JournalModel {
  final String id;
  final DateTime date;
  final String content;
  final String? mood;
  final List<String> tags;

  JournalModel({
    required this.id,
    required this.date,
    required this.content,
    this.mood,
    this.tags = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'content': content,
      'mood': mood,
      'tags': tags,
    };
  }

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      content: json['content'],
      mood: json['mood'],
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}
