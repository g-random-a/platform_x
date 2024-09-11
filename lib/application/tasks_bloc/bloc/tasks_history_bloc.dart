import 'package:bloc/bloc.dart';
import 'package:platform_x/infrustructure/tasks/repository/tasks_repo.dart';

import '../../../domain/task/task.dart';
import '../event/tasks_history_event.dart';
import '../state/tasks_history_state.dart';

class TasksHistoryBloc extends Bloc<TasksHistoryEvent, TasksHistoryState> {
  TasksRepository tasksRepository;
  TasksHistoryBloc({required this.tasksRepository})
      : super(TasksHistoryInitialState()) {

    on<LoadTasksHistoryEvent>(LoadTasks);
    on<DisposeTasksHistoryEvent>((DisposeTasksHistoryEvent event, Emitter emit) {
      emit(TasksHistoryInitialState());
    });
  }

  LoadTasks(LoadTasksHistoryEvent event, Emitter emit) async {
    
    emit(TasksHistoryLoadingState());

    try {
      List<List<Task>> tasks = await tasksRepository.loadTasksHistory();
      emit(TasksHistorySuccessState(completedTasks: tasks[0], pendingTasks: tasks[1]));
    } catch (e) {
      emit(TasksHistoryFailedState());
    }
  }


}
