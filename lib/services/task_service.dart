import 'dart:collection';
import 'dart:io';
import '../models/task.dart';

class TaskService {
  final List<Task> _tasks = [];

  void addTask({
    required String id,
    required String name,
  }) {
    // Check for duplicate task ID
    if (_tasks.any((task) => task.id == id)) {
      print('Error: A task with ID "$id" already exists.');
      return; // Exit the method if the task ID is not unique
    }

    // Add the task if the ID is unique
    _tasks.add(Task(id: id, name: name));
    print('Task added successfully!');
  }

  void deleteTask(String id) {
    // Remove the task with the specified ID
    _tasks.removeWhere((task) => task.id == id);
    print('Task with ID "$id" has been deleted successfully!');
  }

  List<Task> getTasks() {
    return UnmodifiableListView(_tasks);
  }

  void toggleTaskCompletion(String id) {
    final task = _tasks.firstWhere(
      (task) => task.id == id,
      orElse: () => Task(id: '', name: ''), // Return an empty Task if not found
    );

    if (task.id.isNotEmpty) {
      final index = _tasks.indexOf(task);
      _tasks[index] = Task(
        id: task.id,
        name: task.name,
        isCompleted: !task.isCompleted,
      );
      print('Task "${task.name}" marked as ${!task.isCompleted ? 'completed' : 'incomplete'}.');
    } else {
      print('Error: Task with ID "$id" not found.');
    }
  }
}