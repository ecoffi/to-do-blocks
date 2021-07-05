import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoblocks/Data/MyTask.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:todoblocks/Database/Database.dart';

///Page that contains a task to add new form
class AddNewTaskPage extends StatefulWidget {
  const AddNewTaskPage({Key key}) : super(key: key);

  @override
  _AddNewTaskPageState createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Form Fields
  String _title;
  String _description;
  Priority _priority = Priority.Medium;
  DateTime _start;
  DateTime _end;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Task"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => this._title = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                onSaved: (value) => this._description = value,
              ),
              DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: "Start",
                timeLabelText: "Time",
                onSaved: (value) => this._start = DateTime.tryParse(value),
              ),
              DateTimePicker(
                type: DateTimePickerType.dateTime,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: "End",
                onSaved: (value) => this._end = DateTime.tryParse(value),
              ),
              ElevatedButton(
                  onPressed: () {
                    _saveForm();
                  },
                  child: Text("Add Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      // Create a Task with the information from the form
      MyTask newTask = new MyTask(null, _title, _description, _priority, false, _start, _end);

      //save in db
      final database = Provider.of<Database>(context, listen: false);
      database.insertTask(newTask.getDBTask());
    }
  }
}