import 'package:flutter/material.dart';
import '../models/habit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Habit> _habits = [];

  void _toggleHabit(int index) {
    setState(() {
      _habits[index].toggleDone();
    });
  }

  void _addHabit(String name) {
    setState(() {
      _habits.add(Habit(name: name));
    });
  }

  void _navigateToAddHabit() {
    Navigator.pushNamed(context, '/add').then((value) {
      if (value != null && value is String) {
        _addHabit(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes habitudes')),
      body: ListView.builder(
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          final habit = _habits[index];
          return CheckboxListTile(
            title: Text(habit.name),
            value: habit.isDone,
            onChanged: (_) => _toggleHabit(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddHabit,
        child: const Icon(Icons.add),
      ),
    );
  }
}
