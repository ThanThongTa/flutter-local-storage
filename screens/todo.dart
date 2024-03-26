// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ToDos extends StatefulWidget {
  const ToDos({super.key});

  @override
  State<ToDos> createState() => _ToDosState();
}

class _ToDosState extends State<ToDos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo's"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("läuft!"),
      ),
    );
  }
}
