
import '../../../../application/theme_bloc/bloc/theme_bloc.dart';
import '../../../../application/theme_bloc/state/theme_state.dart';
import '../../../../domain/task/task.dart';
import '../../completeTasks/task_details.dart';
import 'imports.dart';

class CardWidget extends StatelessWidget {
  final Task task;

  const CardWidget(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, _) {
      return InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskPage(),
            ),
          );
        },
        child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              task.taskName,
              style: const TextStyle(
                    color: Color.fromARGB(171, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    task.taskDescription,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  "\$${task.bonus.toString()}",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    task.numberOfQuestion.toString() + ' Questions',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                // Flexible(
                //   child: TextButton(
                //     
                //     // color: const Color.fromARGB(255, 59, 169, 129),
                //     // style: ,
                //     child: const Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Text(
                //           'Start',
                //           style: TextStyle(
                //             color: Colors.greenAccent,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20,
                //           ),
                //         ),
                //         Icon(
                //           Icons.play_arrow,
                //           color: Colors.greenAccent,
                //           size: 40,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
        
              ],
            ),
          ],
        ),
            ),
      );
  });
}
}
