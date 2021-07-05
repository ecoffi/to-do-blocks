import 'package:todoblocks/Database/Database.dart';

enum Priority { Low, Medium, High }

///A single task
class MyTask {
  //Fields

  ///unique identifier for task
  int _id;

  ///name of task
  String _title;

  ///description of task
  String _description;

  ///priority of task
  Priority _priority;

  ///whether this task has been completed or not
  bool _isComplete;

  ///when this task starts
  DateTime _start;

  ///when this task ends
  DateTime _end;

  //Getters and Setters

  int get id => _id;

  String get title => _title;

  String get description => _description;

  bool get isComplete => _isComplete;

  set isComplete(bool value) {
    _isComplete = value;
  }

  DateTime get start => _start;

  DateTime get end => _end;

  //Constructors

  ///A task with no end date
  MyTask.noEndDate(this._id, this._title, this._description, this._priority,
      this._isComplete, this._start);

  ///constructor with all fields
  MyTask(this._id, this._title, this._description, this._priority,
      this._isComplete, this._start, this._end);

  ///create MyTask from database task object
  MyTask.from(Task task) {
    this._id = task.id;
    this._title = task.title;
    this._description = task.description;
    this._priority = task.priority == null ? null : Priority.values[task.priority];
    this._isComplete = task.isComplete;
    this._start = task.start;
    this._end = task.end;
  }

  //Methods

  /// toggle the isComplete status of this task
  void toggleComplete() {
    _isComplete = !_isComplete;
  }

  ///return a copy of this task
  MyTask clone() {
    return new MyTask(this._id, this._title, this._description, this._priority,
        this._isComplete, this._start, this._end);
  }

  ///return a task formatted for the database
  Task getDBTask() {
    return new Task(
      id: _id,
      title: _title,
      description: _description,
      priority: _priority == null ? null : _priority.index,
      isComplete: _isComplete,
      start: _start,
      end: _end
    );
  }

  ///get whether the task has a start and end time, ie is scheduled
  bool hasStartAndEnd() {
    return !(_start == null || _end == null);
  }

  ///get length of task in minutes, 0 if
  int getLengthInMinutes() {
    if (!hasStartAndEnd()) {
      return 0;
    }

    Duration duration = _end.difference(_start);

    return duration.inMinutes;
  }
}
