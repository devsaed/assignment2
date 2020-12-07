import 'Task.dart';
import 'main.dart';

List task = [
  for (int x = 1; x < 10; x++)
    Task('Task $x', 'sub Title for Task$x', false, bgTask.red),
];
