import 'dart:convert';

class Todo {
  final int? id;
  final String title;
  final String description;
  final bool completed;
  final int canLevel;
  final int durationInMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.canLevel,
    required this.durationInMinutes,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'can_level': canLevel,
      'duration_in_minutes': durationInMinutes,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      description: map['description'] as String,
      completed: map['completed'] as bool,
      canLevel: map['can_level'] as int,
      durationInMinutes: map['duration_in_minutes'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, description: $description, completed: $completed, canLevel: $canLevel, durationInMinutes: $durationInMinutes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.completed == completed &&
        other.canLevel == canLevel &&
        other.durationInMinutes == durationInMinutes &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        completed.hashCode ^
        canLevel.hashCode ^
        durationInMinutes.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
