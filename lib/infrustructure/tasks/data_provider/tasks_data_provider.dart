import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/task/task.dart';
import 'tasks_data_provider_imports.dart';

class TasksDataProvider extends DataProvider {
  final Dio dio;

  TasksDataProvider({required this.dio});

  Future<bool> submitTask(Task feedback) async {
    try {
      FormData formData = FormData.fromMap(feedback.toJson());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        throw Exception("notLogged In");
      }
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['cookie'] = 'session=$token';

      Response response = await dio.post("$baseUrl/submit_task/", data: formData);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Error while sending feedback.");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> loadTasks() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        throw Exception("notLogged In");
      }
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['cookie'] = 'session=$token';
      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.get("$baseUrl/agent/get-forms");

      print("-----------------");
      print("@response == ${response}");

      if (response.statusCode != 200) {
        throw Exception("Error while loading tasks.");
      }


      List<Task> tasks = [];

      List forms = response.data['forms'];
      
      for (var form in forms) {
        Task task = Task(
          taskId: form['id'].toString(),
          taskName: form['formName'],
          taskDescription: form['formDescription'],
          numberOfQuestion: form['numberOfQuestion'],
          bonus: 0,
        );
        
        tasks.add(task);
      }
      
      return tasks;

    } catch (e) {
      rethrow;
    }

  }

  Future<List<Task>> loadMoreTasks(int nextPage) async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? token = prefs.getString('token');
      // if (token == null) {
      //   throw Exception("notLogged In");
      // }
      // dio.options.headers['content-Type'] = 'application/json';
      // dio.options.headers['cookie'] = 'session=$token';

      // Response response = await dio.get("$baseUrl/load_more_tasks/");

      // if (response.statusCode == 200) {
      //   List<Task> tasks = (response.data as List).map((e) => Task.fromJson(e)).toList();
      //   return tasks;
      // } else {
      //   throw Exception("Error while loading more tasks.");
      // }
      await Future.delayed(const Duration(milliseconds: 5000));
      throw Exception("Error while loading more tasks.");
      return 
      [
        new Task(taskId: "taskId", taskName: "start", taskDescription: "taskDescription", numberOfQuestion: 255, bonus: 25),
        new Task(taskId: "taskId", taskName: "taskName", taskDescription: "taskDescription", numberOfQuestion: 255, bonus: 25),
        new Task(taskId: "taskId", taskName: "taskName", taskDescription: "taskDescription", numberOfQuestion: 255, bonus: 25),
        new Task(taskId: "taskId", taskName: "taskName", taskDescription: "taskDescription", numberOfQuestion: 255, bonus: 25),
        new Task(taskId: "taskId", taskName: "taskName", taskDescription: "taskDescription", numberOfQuestion: 255, bonus: 25),
        new Task(taskId: "taskId", taskName: "taskName", taskDescription: "taskDescription", numberOfQuestion: 255, bonus: 25),
        new Task(taskId: "taskId", taskName: "done", taskDescription: "taskDescription", numberOfQuestion: 255, bonus: 25),
      ];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<List<Task>>> loadTasksHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        throw Exception("notLogged In");
      }
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['cookie'] = 'session=$token';

      Response response = await dio.get("$baseUrl/agent/get-task-history");

      if (response.statusCode == 200) {
        List<Task> completedTasks = [];
        List<Task> pendingTasks = [];

        List tasks = response.data['acceptedTasks'];
        for (var task in tasks) {
          Task newTask = Task(
            taskId: task['form']['id'].toString(),
            taskName: task['form']['formName'],
            taskDescription: task['form']['formDescription'],
            numberOfQuestion: 0,
            bonus: 0,
          );

          completedTasks.add(newTask);
        }
        List tasksPending = response.data['acceptedTasks'];
        for (var task in tasksPending) {
          Task newTask = Task(
            taskId: task['form']['id'].toString(),
            taskName: task['form']['formName'],
            taskDescription: task['form']['formDescription'],
            numberOfQuestion: 0,
            bonus: 0,
            date: task['updatedAt'] != null ? DateTime.parse(task['updatedAt']) : null,
          );
        
            pendingTasks.add(newTask);
          }

        return [completedTasks, pendingTasks];
        
      } else {
        throw Exception("Error while loading tasks history.");
      }
    } catch (e) {
      rethrow;
    }
  }
}
