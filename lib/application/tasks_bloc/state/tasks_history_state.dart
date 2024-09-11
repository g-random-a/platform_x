import 'package:equatable/equatable.dart';
import 'package:platform_x/domain/task/task.dart';

abstract class TasksHistoryState extends Equatable {
  const TasksHistoryState();

  @override
  List<Object?> get props => [];
}

class TasksHistoryInitialState extends TasksHistoryState {}

class TasksHistoryLoadingState extends TasksHistoryState {}

class TasksHistorySuccessState extends TasksHistoryState {
  final List<Task> completedTasks;
  final List<Task> pendingTasks;

  TasksHistorySuccessState({required this.completedTasks, required this.pendingTasks});

  @override
  List<Object?> get props => [completedTasks, pendingTasks];
}

class TasksHistoryFailedState extends TasksHistoryState {}
