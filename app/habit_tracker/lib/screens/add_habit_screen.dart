import 'package:flutter/material.dart';
import '../models/habit.dart';

class AddHabitScreen extends StatefulWidget {
  final void Function(String, String?, Color?, IconData?, Color?) onAdd;

  const AddHabitScreen({Key? key, required this.onAdd}) : super(key: key);

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  Color? _selectedColor;
  Color? _selectedIconBackground;
  IconData? _selectedIcon;

  final List<IconData> _availableIcons = [
    Icons.bedtime,
    Icons.book,
    Icons.fitness_center,
    Icons.fastfood,
    Icons.brush,
    Icons.music_note,
    Icons.local_florist,
    Icons.run_circle,
    Icons.work,
    Icons.coffee,
    Icons.tv,
    Icons.computer,
    Icons.language,
    Icons.light_mode,
    Icons.nightlight_round,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nouvelle habitude")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _descriptionController,
              decoration:
                  const InputDecoration(labelText: 'Description (optionnel)'),
            ),
            const SizedBox(height: 16),
            const Text("Couleur du bandeau :"),
            Wrap(
              spacing: 8,
              children: [
                Colors.green,
                Colors.blue,
                Colors.yellow,
                Colors.red,
                Colors.purple,
                Colors.orange,
                null
              ]
                  .map(
                    (color) => GestureDetector(
                      onTap: () => setState(() => _selectedColor = color),
                      child: CircleAvatar(
                        backgroundColor: color ?? Colors.grey[300],
                        radius: 14,
                        child: _selectedColor == color
                            ? const Icon(Icons.check,
                                color: Colors.white, size: 16)
                            : null,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            const Text("Couleur du cadre de l'icône :"),
            Wrap(
              spacing: 8,
              children: [
                Colors.green,
                Colors.blue,
                Colors.yellow,
                Colors.red,
                Colors.purple,
                Colors.orange,
                null
              ]
                  .map(
                    (color) => GestureDetector(
                      onTap: () =>
                          setState(() => _selectedIconBackground = color),
                      child: CircleAvatar(
                        backgroundColor: color ?? Colors.grey[300],
                        radius: 14,
                        child: _selectedIconBackground == color
                            ? const Icon(Icons.check,
                                color: Colors.white, size: 16)
                            : null,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            const Text("Choisir une icône :"),
            Wrap(
              spacing: 8,
              children: _availableIcons.map((icon) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedIcon = icon),
                  child: CircleAvatar(
                    backgroundColor: _selectedIcon == icon
                        ? Colors.black
                        : Colors.grey[300],
                    child: Icon(icon, color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final name = _nameController.text.trim();
                  final description = _descriptionController.text.trim();
                  if (name.isNotEmpty) {
                    widget.onAdd(
                      name,
                      description.isNotEmpty ? description : null,
                      _selectedColor,
                      _selectedIcon,
                      _selectedIconBackground,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text("Ajouter"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
