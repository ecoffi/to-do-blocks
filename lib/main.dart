import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoblocks/Database/Database.dart';
import 'package:todoblocks/Pages/MyHomePage.dart';

void main() {
  runApp(MyApp());
}

//Useful tutorial (Make sure to run the build_runner!)
//https://resocoder.com/2019/06/26/moor-room-for-flutter-tables-queries-fluent-sqlite-database/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => Database(),
      child: MaterialApp(
        title: 'ToDo Blocks',
        home: MyHomePage(),
      ),
    );
  }
}
