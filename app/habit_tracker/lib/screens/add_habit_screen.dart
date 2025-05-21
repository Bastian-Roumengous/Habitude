import 'package:flutter/material.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({Key? key}) : super(key: key);

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController _controller = TextEditingController();

  void _saveHabit() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      Navigator.pop(context, text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle habitude')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Nom de l’habitude'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveHabit,
              child: const Text('Ajouter'),
            )
          ],
        ),
      ),
    );
  }
}
