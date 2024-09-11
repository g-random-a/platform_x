import 'package:flutter/material.dart';
import 'package:platform_x/application/tasks_bloc/bloc/tasks_bloc.dart';
import 'package:platform_x/application/tasks_bloc/state/tasks_state.dart';
import 'package:platform_x/lib.dart';

class StatPage extends StatefulWidget {
  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  int _selectedPage = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks Management', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FinanceCard(
              total: "\$100",
              withdrawn: "\$20",
              available: "\$80",
            ),
            SizedBox(height: 20),
            ToggleSwitch(
              selectedPage: _selectedPage,
              onToggle: (int index) {
                setState(() {
                  _selectedPage = index;
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedPage = index;
                  });
                },
                children: [
                  CompletedTasksPage(),
                  PendingTasksPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FinanceCard extends StatelessWidget {
  final String total;
  final String withdrawn;
  final String available;

  const FinanceCard({
    Key? key,
    required this.total,
    required this.withdrawn,
    required this.available,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      total,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Withdrawn:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      withdrawn,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      available,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ToggleSwitch extends StatelessWidget {
  final int selectedPage;
  final Function(int) onToggle;

  const ToggleSwitch({
    Key? key,
    required this.selectedPage,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          _buildToggleItem('Completed', 0),
          _buildToggleItem('Pending', 1),
        ],
      ),
    );
  }

  Expanded _buildToggleItem(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onToggle(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: selectedPage == index ? Colors.blueAccent : Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selectedPage == index ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Color barColor;
  final String taskName;
  final String taskDetail;
  final String taskStatus;
  final String taskTime;
  final String amount;

  const TaskCard({
    Key? key,
    required this.barColor,
    required this.taskName,
    required this.taskDetail,
    required this.taskStatus,
    required this.taskTime,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.white,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 10,
                color: barColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskName,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            taskDetail,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                        amount,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle, color: barColor, size: 16),
                              Text(
                            " ${taskStatus}",
                            style: TextStyle(
                              fontSize: 13,
                              color: barColor,
                            ),
                          ),
                            ]
                          ),
                          Text(
                            taskTime,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompletedTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if(state is TasksLoadingSuccessState){
          return ListView.builder(
          itemCount: state.tasks.length,
          itemBuilder: (context, index) {
            final task = state.tasks[index];
            return TaskCard(
              barColor: Color.fromARGB(255, 46, 185, 118),
              taskName: task.taskName,
              taskDetail: task.taskDescription,
              taskStatus: "Completed",
              taskTime: DateTime.now().toString(),
              amount: task.bonus.toString(),
            );
          },
        );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        
        }
      }
    );
  }
}

class PendingTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if(state is TasksLoadingSuccessState){
          return ListView.builder(
          itemCount: state.tasks.length,
          itemBuilder: (context, index) {
            final task = state.tasks[index];
            return TaskCard(
              barColor: Color.fromARGB(255, 255, 185, 46),
              taskName: task.taskName,
              taskDetail: task.taskDescription,
              taskStatus: "Pending",
              taskTime: DateTime.now().toString(),
              amount: task.bonus.toString(),
            );
          },
        );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        
        }
      }
    );
  }
}