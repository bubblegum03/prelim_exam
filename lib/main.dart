import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'providers/global_provider.dart';
import 'services/task_service.dart';

void main() {
  final container = ProviderContainer();
  final taskService = container.read(taskServiceProvider);

  while (true) {
    print('\nTask Management System');
    print('1. Add Task');
    print('2. Delete Task');
    print('3. List Tasks');
    print('4. Mark as complete');
    print('5. Exit');
    stdout.write('Choose an option: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        _addTask(taskService);
        break;
      case '2':
        _deleteTask(taskService);
        break;
      case '3':
        _listTasks(taskService);
        break;
      case '4':
        _toggleTaskCompletion(taskService);
        break;
      case '5':
        print('Exiting the application...');
        return;
      default:
        print('Invalid choice. Please try again.');
    }
  }
}

// Function to add a task
void _addTask(TaskService taskService) {
  stdout.write('Enter task ID: ');
  String? id = stdin.readLineSync();

  stdout.write('Enter task name: ');
  String? name = stdin.readLineSync();

  if (id != null && name != null) {
    taskService.addTask(id: id, name: name);
  } else {
    print('Error: Task ID and name cannot be empty.');
  }
}

// Function to delete a task
void _deleteTask(TaskService taskService) {
  stdout.write('Enter task ID to delete: ');
  String? inputId = stdin.readLineSync();

  if (inputId != null) {
    taskService.deleteTask(inputId);
  } else {
    print('Error: Task ID cannot be null or empty.');
  }
}

// Function to list all tasks
void _listTasks(TaskService taskService) {
  final tasks = taskService.getTasks();
  
  if (tasks.isEmpty) {
    print('No tasks found.');
    return;
  }

  for (var task in tasks) {
    print('ID: ${task.id}, Name: ${task.name}, Completed: ${task.isCompleted}');
  }
}

// Function to toggle the completion status of a task
void _toggleTaskCompletion(TaskService taskService) {
  stdout.write('Enter task ID to toggle completion status: ');
  String? inputId = stdin.readLineSync();

  if (inputId != null) {
    taskService.toggleTaskCompletion(inputId);
  } else {
    print('Error: Task ID cannot be null or empty.');
  }
}