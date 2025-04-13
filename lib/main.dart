import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habits Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HabitsScreen(),
    );
  }
}

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  // Список привычек (пока хранится в памяти)
  final List<Map<String, dynamic>> _habits = [
    {
      'id': '1',
      'name': 'Пить воду',
      'completed': false,
      'createdAt': DateTime.now(),
    },
    {
      'id': '2',
      'name': 'Утренняя зарядка',
      'completed': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    },
  ];

  // Отметить привычку выполненной/невыполненной
  void _toggleHabit(int index) {
    setState(() {
      _habits[index]['completed'] = !_habits[index]['completed'];
    });
  }

  // Добавить новую привычку
  void _addHabit(String habitName) {
    if (habitName.trim().isEmpty) return;
    
    setState(() {
      _habits.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': habitName,
        'completed': false,
        'createdAt': DateTime.now(),
      });
    });
  }

  // Диалог добавления привычки
  Future<void> _showAddHabitDialog() async {
    final textController = TextEditingController();
    
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Добавить привычку'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'Например: Читать книгу',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                _addHabit(textController.text);
                Navigator.pop(context);
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои привычки'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddHabitDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          final habit = _habits[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Checkbox(
                value: habit['completed'],
                onChanged: (_) => _toggleHabit(index),
              ),
              title: Text(
                habit['name'],
                style: TextStyle(
                  decoration: habit['completed']
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(
                'Создано: ${habit['createdAt'].toString().split(' ')[0]}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _habits.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHabitDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}