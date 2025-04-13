class Habit {
  final int? id;
  final String name;
  final bool completed;
  final DateTime createdAt;

  Habit({
    this.id,
    required this.name,
    required this.completed,
    required this.createdAt,
  });

  // Конвертация в Map для SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'completed': completed ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Создание объекта из Map
  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      name: map['name'],
      completed: map['completed'] == 1,
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}