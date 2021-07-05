import 'package:flutter/cupertino.dart';
import 'package:todoblocks/Data/MyTask.dart';
import 'package:todoblocks/Data/TaskInterval.dart';
import 'package:todoblocks/UI/TasksExpansionTile.dart';

///A list containing all tasks
///Filters them into intervals and displays them in separate expansion tiles
class TaskListView extends StatefulWidget {
  const TaskListView(this.tasks, {Key key}) : super(key: key);
  final List<MyTask> tasks;

  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    //Get current date
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    ///List of task intervals
    List<TaskInterval> _taskIntervals = [];

    //get tasks that were due yesterday or earlier
    List<MyTask> overdueTasks = widget.tasks
        .where((task) => task.start != null && task.start.isBefore(today))
        .toList();
    _taskIntervals.add(new TaskInterval("Overdue", true, overdueTasks));

    //get tasks due today
    List<MyTask> todayTasks = widget.tasks.where((task) =>
    task.start != null &&
        (task.start.isAtSameMomentAs(today) || task.start.isAfter(today)) &&
        task.start.isBefore(today.add(new Duration(days: 1)))).toList();
    _taskIntervals.add(new TaskInterval("Today", true, todayTasks));

    //get tasks due after today
    List<MyTask> afterTodayTasks = widget.tasks.where((task) =>
    task.start != null &&
        task.start.isAfter(today.add(new Duration(days: 1)))).toList();
    _taskIntervals.add(new TaskInterval("After Today", false, afterTodayTasks));

    //get tasks without date
    List<MyTask> noDateTasks = widget.tasks.where((task) => task.start == null).toList();
    _taskIntervals.add(new TaskInterval("No Date", false, noDateTasks));

    return ListView(
      shrinkWrap: true,
      children: [
        ..._taskIntervals.map((interval) {
          return TasksExpansionTile(
              interval.title, interval.tasks, interval.isInitiallyExpanded
          );
        }),
      ],
    );
  }
}
