import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoblocks/Data/MyTask.dart';
import 'package:todoblocks/UI/TaskTile.dart';

///Collapsible tile containing a list of task tiles
class TasksExpansionTile extends StatefulWidget {
  const TasksExpansionTile(this.title, this.tasks, this.isInitiallyExpanded, {Key key})
      : super(key: key);
  final String title;
  final List<MyTask> tasks;
  final bool isInitiallyExpanded;

  @override
  _TasksExpansionTileState createState() => _TasksExpansionTileState();
}

class _TasksExpansionTileState extends State<TasksExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.title),
      initiallyExpanded: widget.isInitiallyExpanded,
      children: [
        ...widget.tasks.map((t) {
          return TaskTile(t);
        }),
      ],
    );
  }
}
