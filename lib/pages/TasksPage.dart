// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../services.dart/chartsBuilder.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent.shade100,
      body: Column(children: [
        Stack(
            children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 140, 0, 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(children: const [
                Text(
                  "Your Habits",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Use this to be inspired",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ]),
            ),
          )
        ]),
        SizedBox(
          height: 513,
          child: ListView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(

                child: LineChartSample1(),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(

                child: LineChartSample2(),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(

                child: LineChartSample3(),
              )
            ],
          ),
        )
      ]),
    );
  }
}
