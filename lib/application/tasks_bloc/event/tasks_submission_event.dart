import 'package:equatable/equatable.dart';
import 'package:platform_x/domain/task/task.dart';

abstract class TaskSubmissionEvent extends Equatable {
  const TaskSubmissionEvent();

  @override
  List<Object?> get props => [];
}

class SubmitTaskEvent extends TaskSubmissionEvent {
  final Task task;

  const SubmitTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class DisposeTaskEvent extends TaskSubmissionEvent {
  const DisposeTaskEvent();

  @override
  List<Object?> get props => [];
}
