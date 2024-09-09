import 'package:bloc/bloc.dart';

import '../../../infrustructure/tasks/repository/tasks_repo.dart';
import '../event/tasks_submission_event.dart';
import '../state/tasks_submission_state.dart';

class TaskSubmissionBloc extends Bloc<TaskSubmissionEvent, TaskSubmissionState> {
  TasksRepository tasksRepository;
  TaskSubmissionBloc({required this.tasksRepository})
      : super(TasksInitialState()) {

    on<SubmitTaskEvent>(onSubmitTasks);
    on<DisposeTaskEvent>((DisposeTaskEvent event, Emitter emit) {
      emit(TasksInitialState());
    });
  }

  onSubmitTasks(SubmitTaskEvent event, Emitter emit) async {
    emit(TasksSubmittingState());
    try {
      bool tasksSent = await tasksRepository.submitTask(event.task);
      if (!tasksSent) throw Exception();
      emit(TasksSubmittedState());
    } catch (e) {
      emit(TasksFailedState());
    }
  }
}
