import 'package:equatable/equatable.dart';
import 'package:platform_x/domain/task/task.dart';

abstract class TasksHistoryEvent extends Equatable {
  const TasksHistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasksHistoryEvent extends TasksHistoryEvent {
}

class DisposeTasksHistoryEvent extends TasksHistoryEvent {
  const DisposeTasksHistoryEvent();

  @override
  List<Object?> get props => [];
}
