import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../widgets/habit_group.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Habit> morningHabits = [];
  final List<Habit> dayHabits = [];
  final List<Habit> eveningHabits = [];

  void _addHabit(List<Habit> targetList) async {
    final result = await Navigator.pushNamed(context, '/add');
    if (result != null && result is String) {
      setState(() {
        targetList.add(Habit(name: result));
      });
    }
  }

  void _toggleHabit(List<Habit> list, int index) {
    setState(() {
      list[index].toggleDone();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes habitudes')),
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: [
          HabitGroup(
            title: 'Matin',
            habits: morningHabits,
            onAddHabit: () => _addHabit(morningHabits),
            onToggleHabit: (i) => _toggleHabit(morningHabits, i),
          ),
          HabitGroup(
            title: 'Journée',
            habits: dayHabits,
            onAddHabit: () => _addHabit(dayHabits),
            onToggleHabit: (i) => _toggleHabit(dayHabits, i),
          ),
          HabitGroup(
            title: 'Soir',
            habits: eveningHabits,
            onAddHabit: () => _addHabit(eveningHabits),
            onToggleHabit: (i) => _toggleHabit(eveningHabits, i),
          ),
        ],
      ),
    );
  }
}
