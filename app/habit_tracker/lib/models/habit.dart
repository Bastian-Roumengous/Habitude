class Habit {
  String name;
  bool isDone;

  Habit({required this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}
