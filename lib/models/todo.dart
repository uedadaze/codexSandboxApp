class Todo {
  const Todo({
    required this.title,
    required this.createdAt,
    required this.deadline,
    required this.description,
  });

  final String title;
  final DateTime createdAt;
  final DateTime deadline;
  final String description;

  Todo copyWith({
    String? title,
    DateTime? createdAt,
    DateTime? deadline,
    String? description,
  }) {
    return Todo(
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
      description: description ?? this.description,
    );
  }
}
