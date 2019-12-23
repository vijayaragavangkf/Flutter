import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body:
      TextField(
        decoration: InputDecoration(
          hintText: "Username",
          isDense: true,
          contentPadding: EdgeInsets
              .symmetric( //You can also use EdgeInsets.only
            horizontal: 0.0, //Change this
            vertical: 0.0, //Change this
          ),
        ),
      ),
    );
  }
}