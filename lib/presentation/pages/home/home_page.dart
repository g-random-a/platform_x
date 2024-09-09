import 'package:platform_x/application/tasks_bloc/state/tasks_state.dart';
import '../../../application/tasks_bloc/bloc/tasks_bloc.dart';
import '../../../application/tasks_bloc/event/tasks_event.dart';
import 'home_page_imports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<TasksBloc>(context).add(LoadTasksEvent());
          await Future.delayed(const Duration(milliseconds: 200));
        },
        child: BlocConsumer<TasksBloc, TasksState>(
          listener: (context, state) {
            if (state is TasksLoadingSuccessState ) {
              _scrollController.addListener(() {
                if (_scrollController.position.pixels ==
                    _scrollController.position.maxScrollExtent) {;
                    if (context.read<TasksBloc>().state is TasksLoadingSuccessState) {
                      final currentState = context.read<TasksBloc>().state as TasksLoadingSuccessState;
                      if (!currentState.isLoadingMore && currentState.error.isEmpty) {
                        BlocProvider.of<TasksBloc>(context).add(LoadMoreTasksEvent());
                      }
                    }
                }
              });

              if(state.error.isNotEmpty){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error),
                  duration: const Duration(seconds: 2),
                ));
              }
            }

          },
          builder: (context, state) {
            if (state is TasksInitialState) {
              BlocProvider.of<TasksBloc>(context).add(LoadTasksEvent());
              return const Center(child: CircularProgressIndicator(color: Colors.red,));
            } else if (state is TasksLoadingFailedState) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                          'Failed to get tasks, Please check your network and try again'),
                      ElevatedButton(
                          onPressed: () {
                            final recentBloc =
                                BlocProvider.of<TasksBloc>(context);
                            recentBloc.add(LoadTasksEvent());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor),
                          child: Text(
                            'Retry',
                            style: TextStyle(
                                color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .whiteColor),
                          ))
                    ],
                  ),
                ),
              );
            } else if (state is TasksLoadingSuccessState) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.tasks.length + 1,
                      itemBuilder: (context, index) {
                        if(index == state.tasks.length){
                          if (!state.isLoadingMore && state.error.isEmpty) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('No more tasks to load'),
                              ),
                            );
                          } 
                          else if (state.isLoadingMore && state.error.isEmpty) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(color: Colors.blue,),
                              ),
                            );
                          }
                          else if (state.error.isNotEmpty) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                        'Failed to get tasks, Please check your network and try again'),
                                    ElevatedButton(
                                        onPressed: () {
                                          final recentBloc =
                                              BlocProvider.of<TasksBloc>(context);
                                          recentBloc.add(LoadMoreTasksEvent());
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: kPrimaryColor),
                                        child: Text(
                                          'Retry',
                                          style: TextStyle(
                                              color: BlocProvider.of<ThemeBloc>(context)
                                                  .state
                                                  .whiteColor),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }
                        } else if (index < state.tasks.length) {
                          final task = state.tasks[index];
                          return CardWidget(task);
                        }
                        return Container(); 
                      },
                    ),
                  ),
                ],
              );
            } 
             else {
              return const Center(child: CircularProgressIndicator(color: Colors.green,));
            }
          },
        ),
      ),
    );
  }
}
