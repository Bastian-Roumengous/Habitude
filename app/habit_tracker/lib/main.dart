import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_habit_screen.dart';

void main() {
  runApp(const HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomeScreen(),
      routes: {
        '/add': (context) => const AddHabitScreen(),
      },
    );
  }
}
