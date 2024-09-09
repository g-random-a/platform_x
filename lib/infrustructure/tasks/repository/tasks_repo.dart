import '../../../domain/task/task.dart';
import 'tasks_repo_imports.dart';

class TasksRepository {
  final TasksDataProvider tasksDataProvider;

  TasksRepository({required this.tasksDataProvider});

  Future<bool> submitTask(Task task) async {
    try {
      bool isTasksSent = await tasksDataProvider.submitTask(task);
      return isTasksSent;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> loadTasks() async {
    try {
      List<Task> tasks = await tasksDataProvider.loadTasks();
      return tasks;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> loadMoreTasks(int nextPage) async{
    try {
      List<Task> tasks = await tasksDataProvider.loadMoreTasks(nextPage);
      return tasks;
    } catch (e) {
      rethrow;
    }
  }
}
