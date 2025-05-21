import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../widgets/habit_group.dart';
import 'add_habit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Habit> _morningHabits = [];
  final List<Habit> _dayHabits = [];
  final List<Habit> _eveningHabits = [];

  void _addHabitToGroup(List<Habit> group) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddHabitScreen(
          onAdd: (name, description, color, icon, iconBackground) {
            setState(() {
              group.add(Habit(
                name: name,
                description: description,
                color: color,
                icon: icon,
                iconBackground: iconBackground,
              ));
            });
          },
        ),
      ),
    );
  }

  void _toggleHabit(List<Habit> group, int index) {
    setState(() {
      group[index].isDone = !group[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Fond d’écran gris
      appBar: AppBar(
        title: const Text("Mes habitudes"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          HabitGroup(
            title: "Matin",
            habits: _morningHabits,
            onAddHabit: () => _addHabitToGroup(_morningHabits),
            onToggleHabit: (index) => _toggleHabit(_morningHabits, index),
          ),
          HabitGroup(
            title: "Journée",
            habits: _dayHabits,
            onAddHabit: () => _addHabitToGroup(_dayHabits),
            onToggleHabit: (index) => _toggleHabit(_dayHabits, index),
          ),
          HabitGroup(
            title: "Soir",
            habits: _eveningHabits,
            onAddHabit: () => _addHabitToGroup(_eveningHabits),
            onToggleHabit: (index) => _toggleHabit(_eveningHabits, index),
          ),
        ],
      ),
    );
  }
}
