import 'package:equatable/equatable.dart';

abstract class TaskSubmissionState extends Equatable {
  const TaskSubmissionState();

  @override
  List<Object?> get props => [];
}

class TasksInitialState extends TaskSubmissionState {}

class TasksSubmittingState extends TaskSubmissionState {}

class TasksSubmittedState extends TaskSubmissionState {}

class TasksFailedState extends TaskSubmissionState {}
