import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:todoblocks/Data/MyTask.dart';

///Schedule View for a passed in day & list of tasks
class ScheduleView extends StatefulWidget {
  const ScheduleView(this.title, this.tasks, this.scheduleDate, {Key key}) : super(key: key);
  final String title; //the title for this day
  final List<MyTask> tasks; //list of all tasks
  final DateTime scheduleDate; //date on which this schedule's tasks occur

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  List<TrackSize> rowSizes = [];
  static const rows = 288; //number of 5-minute intervals in a 24 hour day
  TrackSize rowHeight = 3.px; //height of grid row
  static const rowMinutes = 5; //each grid row comprises 5 minutes

  @override
  void initState() {
    super.initState();

    //set up columns for grid
    while (rowSizes.length < rows)
      rowSizes.add(rowHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.title),
        Expanded(
          child: SingleChildScrollView(
            //Single-column grid
            child: Stack(
              children: [
                //background grid
                LayoutGrid(
                  columnSizes: [1.fr],
                  rowSizes: rowSizes,
                  children: buildBackgroundGridRows(),
                ),
                //foreground grid (with tasks)
                LayoutGrid(
                  columnSizes: [1.fr],
                  rowSizes: rowSizes,
                  children: buildForegroundGridRows(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///create the GridPlacement widgets containing the background grid
  List<Widget> buildBackgroundGridRows() {
    List<GridPlacement> gridChildren = []; //list of widgets to add to grid

    //Add empty boxes on the hours to use as a visual grid
    const int intervalsInHour = 12; //number of 5-minute intervals in an hour
    for (int i = 0; i < rows; i+= intervalsInHour) {
      int hour = i ~/ intervalsInHour;
      gridChildren.add(
          GridPlacement(
            rowStart: i,
            rowSpan: intervalsInHour - 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              child: Text(hour.toString() + ":00"),
              width: double.infinity,
              height: double.infinity,
            ),
          )
      );
    }

    return gridChildren;
  }

  ///create the GridPlacement widgets containing tasks scheduled for today
  List<Widget> buildForegroundGridRows() {
    List<GridPlacement> gridChildren = []; //list of widgets to add to grid

    //Add schedule date's tasks to grid

    widget.tasks.forEach((task) {
      //check if task should be placed on schedule
      if (task.hasStartAndEnd() && takesPlaceOnSameDay(task)) {
        //calculate row of task start and number of rows task spans
        int rowStart = ((task.start.hour * 60 + task.start.minute) / rowMinutes).round();
        int rowSpan = (task.getLengthInMinutes() / rowMinutes).round();

        gridChildren.add(
          GridPlacement(
            rowStart: rowStart,
            rowSpan: rowSpan,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(48.0, 0, 0, 0),
              child: Container(
                color: Colors.blue,
                child: Text(task.title),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          )
        );
      }
    });

    return gridChildren;
  }

  ///check whether provided task takes place on the same day as this schedule view
  bool takesPlaceOnSameDay(MyTask task) {
    return
      widget.scheduleDate.day == task.start.day &&
      widget.scheduleDate.month == task.start.month &&
      widget.scheduleDate.year == task.start.year;
  }
}
