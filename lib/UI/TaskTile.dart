import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoblocks/Data/MyTask.dart';
import 'package:todoblocks/Database/Database.dart';

///A tile for the task list view that contains a single task
class TaskTile extends StatefulWidget {
  const TaskTile(this.task, {Key key}) : super(key: key);
  final MyTask task;

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return CheckboxListTile(
      title: Text(widget.task.title),
      subtitle: Text((widget.task.start == null ? "" : widget.task.start.toString()) + (widget.task.end == null ? "" : " - " + widget.task.end.toString())),
      value: widget.task.isComplete,
      onChanged: (bool value) {
        setState(() {
          widget.task.isComplete = value;
          database.updateTask(widget.task.getDBTask());
        });
      },
    );
  }
}
