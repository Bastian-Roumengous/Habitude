import 'package:flutter/material.dart';

class Habit {
  final String name;
  final String? description;
  final Color? color;
  final IconData? icon;
  final Color? iconBackground;

  bool isDone;

  Habit({
    required this.name,
    this.description,
    this.color,
    this.isDone = false,
    required this.icon,
    this.iconBackground,
  });
}
