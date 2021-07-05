import 'package:todoblocks/Data/MyTask.dart';

///a list of tasks
class TaskList {
  //Fields

  ///the list that stores tasks
  List<MyTask> _taskList;

  //Constructors

  TaskList() {
    _taskList = [];
  }

  //Methods

  ///add task to list
  void add(MyTask task) {
    _taskList.add(task.clone());
  }

  ///remove a task from list
  void remove(MyTask task) {
    MyTask taskToRemove = _taskList.singleWhere((t) => t.id == task.id);
    _taskList.remove(taskToRemove);
  }

  ///return a list of all tasks
  List<MyTask> getAllTasks() {
    //make a new list with clones of all tasks in list
    List<MyTask> taskListCopy = [];
    _taskList.forEach((t) {
      taskListCopy.add(t.clone());
    });

    return taskListCopy;
  }

  ///Replace task in list with modified version
  void modifyTask(MyTask task) {
    MyTask taskToModify = _taskList.singleWhere((t) => t.id == task.id);
    int taskToModifyIndex = _taskList.indexOf(taskToModify);
    _taskList[taskToModifyIndex] = task.clone();
  }

  ///Clear all tasks from list
  void clear() {
    _taskList.clear();
  }
}
