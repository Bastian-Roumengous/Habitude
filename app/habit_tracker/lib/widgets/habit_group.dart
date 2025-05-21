import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitGroup extends StatefulWidget {
  final String title;
  final List<Habit> habits;
  final VoidCallback onAddHabit;
  final void Function(int) onToggleHabit;

  const HabitGroup({
    Key? key,
    required this.title,
    required this.habits,
    required this.onAddHabit,
    required this.onToggleHabit,
  }) : super(key: key);

  @override
  State<HabitGroup> createState() => _HabitGroupState();
}

class _HabitGroupState extends State<HabitGroup>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  double get _progress {
    if (widget.habits.isEmpty) return 0.0;
    final completed = widget.habits.where((h) => h.isDone).length;
    return completed / widget.habits.length;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                // Fond blanc
                Positioned.fill(child: Container(color: Colors.white)),
                // Remplissage animé
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: constraints.maxWidth * _progress,
                      decoration: BoxDecoration(
                        color: _progress == 1.0
                            ? Colors.green[200]
                            : Colors.blue[200],
                      ),
                    ),
                  ),
                ),
                // Contenu du groupe
                Column(
                  children: [
                    // Bandeau supérieur (titre)
                    GestureDetector(
                      onTap: () => setState(() => _isExpanded = !_isExpanded),
                      child: Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Icon(
                              _isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Liste des habitudes
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Visibility(
                        visible: _isExpanded,
                        child: Column(
                          children: [
                            ...widget.habits.asMap().entries.map((entry) {
                              final index = entry.key;
                              final habit = entry.value;

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  child: Row(
                                    children: [
                                      // Icône avec fond coloré
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: habit.iconBackground ??
                                              Colors.transparent,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          habit.icon,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Nom de l’habitude avec couleur de bandeau
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          decoration: habit.color != null
                                              ? BoxDecoration(
                                                  color: habit.color,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                )
                                              : null,
                                          child: Center(
                                            child: Text(
                                              habit.name,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                decoration: habit.isDone
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Case à cocher
                                      Checkbox(
                                        value: habit.isDone,
                                        onChanged: (_) =>
                                            widget.onToggleHabit(index),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: TextButton.icon(
                                onPressed: widget.onAddHabit,
                                icon: const Icon(Icons.add),
                                label: const Text("Ajouter une habitude"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
