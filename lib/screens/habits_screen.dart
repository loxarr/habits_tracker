import 'package:flutter/material.dart'; // Обязательный импорт

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Трекер привычек'),
      ),
      body: const Center(
        child: Text('Здесь будет список привычек'),
      ),
    );
  }
}