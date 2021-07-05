import 'package:todoblocks/Data/MyTask.dart';

///An interval containing tasks that take place during a specific span of time
class TaskInterval {
  //Fields

  ///the name of the time interval
  String _title;

  ///is this interval expanded by default?
  bool _isInitiallyExpanded;

  ///list of tasks in interval
  List<MyTask> _tasks;

  //Getters and Setters

  String get title => _title;

  bool get isInitiallyExpanded => _isInitiallyExpanded;

  List<MyTask> get tasks => _tasks;

  //Constructors

  TaskInterval(this._title, this._isInitiallyExpanded, this._tasks);
}