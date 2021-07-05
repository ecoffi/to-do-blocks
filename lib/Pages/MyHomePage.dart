import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoblocks/Data/MyTask.dart';
import 'package:todoblocks/Data/TaskList.dart';
import 'package:todoblocks/Database/Database.dart';
import 'package:todoblocks/UI/ScheduleView.dart';
import 'package:todoblocks/UI/TaskListView.dart';

import 'AddNewTaskPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TaskList _taskList = new TaskList();

  void _goToAddTaskPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddNewTaskPage(),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo Blocks'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildTaskList(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddTaskPage,
        tooltip: 'New Task',
        child: Icon(Icons.add),
      ),
    );
  }

  StreamBuilder<List<Task>> _buildTaskList(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder(
      stream: database.watchTaskEntries(),
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        final tasks = snapshot.data ?? [];

        //clear task list and replace tasks
        _taskList.clear();
        tasks.forEach((element) {
          _taskList.add(MyTask.from(element));
        });

        return Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(child: TaskListView(_taskList.getAllTasks())),
                ],
              ),
            ),
            Expanded(
                child: Row(
                  //the schedule views for the days to display
                  children: [
                    Expanded(child: ScheduleView("Today", _taskList.getAllTasks(), DateTime.now())),
                    Expanded(child: ScheduleView("Tomorrow", _taskList.getAllTasks(), DateTime.now().add(Duration(days: 1)))),
                  ],
                )
            ),
          ],
        );
      },
    );
  }
}