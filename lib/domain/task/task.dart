import 'package:platform_x/domain/task/questions.dart';

class Task {
  String taskId;
  String taskName;
  String taskDescription;
  int numberOfQuestion;
  int bonus;
  DateTime? date;
  List<Question>? questions = [];

  static final List<String> hospitalFields = [
    'taskId',
    'taskName',
    'taskDescription',
    'numberOfQuestion',
    'bonus',
  ];

  Task({
    required this.taskId,
    required this.taskName,
    required this.taskDescription,
    required this.numberOfQuestion,
    required this.bonus,
    this.date,
    this.questions,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['taskId'],
      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      numberOfQuestion: json['numberOfQuestion'],
      bonus: json['bonus'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    // json['feedbackId'] = feedbackId;
    json['taskId'] = taskId;
    json['taskName'] = taskName;
    json['taskDescription'] = taskDescription;
    json['numberOfQuestion'] = numberOfQuestion;
    json['bonus'] = bonus;
    return json;
  }

  @override
  String toString() {
    return "task: $taskName";
  }
}
