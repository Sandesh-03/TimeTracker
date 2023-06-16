

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:time_tracker/constants.dart';
import '../main.dart';
import '../services.dart/lists.dart';
import 'package:timezone/timezone.dart' as tz;


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void showNotification(String title,String desc) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        title,
        desc,
        priority: Priority.max,
        importance: Importance.max
    );

    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails
    );

    DateTime scheduleDate = DateTime.now().add(Duration(seconds: 5));

    await notificationsPlugin.zonedSchedule(
        0,
       title,
        desc,
        tz.TZDateTime.from(scheduleDate, tz.local),
        notiDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: "notification-payload"
    );
  }




  TimeOfDay _timeOfDay = TimeOfDay(hour: 8, minute: 30);


  // show time picker method
  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    void addToTasksList(String TaskName, String TaskDescription) {
      TasksList.add([false, TaskName, TaskDescription, Icon(Icons.abc)]);

    }

    void removeTask(index){
      setState(() {
        TasksList.removeAt(index);
        TasksList.length --;
      });

    }
    void addTask(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController habitNameController = TextEditingController();
            TextEditingController habitDescriptionController =
                TextEditingController();
            return AlertDialog(
              title: Text("Add a Task"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: habitNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Task Title"),
                  ),
                  TextFormField(
                    controller: habitDescriptionController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: "Task Description"),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kNButtonColor),
                        surfaceTintColor:
                            MaterialStateProperty.all(kNButtonColor)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kNButtonColor),
                        surfaceTintColor:
                            MaterialStateProperty.all(kNButtonColor)),
                    onPressed: () {
                      setState(() {
                        addToTasksList(habitNameController.text,
                            habitDescriptionController.text);
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Save"))
              ],
            );
          });
    }

    return Scaffold(

      backgroundColor: Colors.purpleAccent.shade100,
      appBar: AppBar(
        title: Text("Time Table"),
        centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),

        )
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
          ),
          child: ListView(
              padding: EdgeInsets.zero, children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(
                    "Hey $Kname!",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "You have ${TasksList.length - counter} habits left for today",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ]),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30), topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Keep Going!",
                            style: TextStyle(color: Colors.grey[600], fontSize: 16),
                          ),
                          Text("${((counter / TasksList.length) * 100).round()}%",
                              style:
                                  TextStyle(color: Colors.grey[600], fontSize: 16))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                            minHeight: 12,
                            color: Colors.deepPurpleAccent,
                            backgroundColor: Color.fromARGB(255, 192, 170, 250),
                            value: (counter / TasksList.length)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Divider(),
                    ),
                    SizedBox(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: TasksList.length,
                        itemBuilder: (context, int index) {
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  borderRadius: BorderRadius.circular(10),
                                  backgroundColor: Colors.deepPurple.shade100,
                                  onPressed: ((context) async{

                                    showNotification(TasksList[index][1], TasksList[index][2],);

                                  }),
                                  icon: Icons.alarm,
                                ),
                                SlidableAction(
                                  borderRadius: BorderRadius.circular(10),
                                  backgroundColor: Colors.deepPurple.shade100,
                                  onPressed: ((context) async {
                                    removeTask(index);
                                  }),
                                  icon: Icons.delete,
                                )
                              ],
                            ),
                            child: ListTile(
                                title: Text(TasksList[index][1]),
                                subtitle: Text(TasksList[index][2]),
                                trailing: TasksList[index][3],
                                leading: Checkbox(
                                  value: TasksList[index][0],
                                  onChanged: ((value) {
                                    setState(() {
                                      if (value == false) {
                                        counter -= 1;
                                        if (kDebugMode) {
                                          print(counter.toString());
                                        }
                                        TasksList[index][0] = value;
                                      } else {
                                        counter += 1;
                                      }
                                      if (kDebugMode) {
                                        print(counter.toString());
                                      }
                                      TasksList[index][0] = value;
                                    });
                                  }),
                                )),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.purple,
        onPressed: (() {
          addTask(context);
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}
