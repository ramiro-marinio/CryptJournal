class Entry {
  final int id;
  final int diaryId;
  final String title;
  final String body;
  final DateTime createdAt;
  final DateTime updatedAt;

  Entry({
    required this.id,
    required this.diaryId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      id: json['id'],
      diaryId: json['diary_id'],
      title: json['title'],
      body: json['body'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'diary_id': diaryId,
      'title': title,
      'body': body,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
