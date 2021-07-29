import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'task_data.dart';

var data;
List val = [""];

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  TextEditingController _controller;
  String newTaskTitle;
  String dropdownValue;
  bool status = false;
  int selected = 1;
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  AnimationController animationController;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  Future<dynamic> getData() async {
    print("geting data and program is inside get data() funtion!!!!!!!");
    http.Response response =
        await http.get(Uri.parse('http://192.168.1.18:8000/key'));
    // print("");
    // print("got data from local server and stored inside the respose variable");
    data = json.decode(response.body);
    // print("the value of data[1] = ${data[1]}");
    // print(" iam going to enter set state");
    setState(() {
      print("iam inside set state");
      print("  ");
      // data.forEach((key, value) {
      //   val.add(key);
      // });
      List val1 = [""];
      for (int i = 0; i >= 0; i++) {
        print("length of data = ${data.length}");

        if (i != (data.length)) {
          // print("iam above the val ");
          // print("data [i] = ${data[i]}");
          // print("data[i] data type = ${data.runtimeType}");
          val1.add(data[i]);
          return val1;
        }


        else if (i == (data.length)) {
          print('inside of else if');
          break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    // selected = 0;
  }

  // setSelectedRadio(int value) {
  //   setState(() {
  //     selected = value;
  //   });
  // }

  @override
  void dispose() {
    _controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var getValue = getData();
    print(getValue);
    // getData();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Name ',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                Text(
                  ':',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                Container(
                  width: 150.0,
                  child: TextField(
                    controller: _controller,
                    onChanged: (newText) {
                      newTaskTitle = newText;
                    },
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Device ',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                Text(
                  ':',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                Container(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['$val']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            FlatButton(
                onPressed: () {
                  print("geting data by pressing a button");
                  getData();
                },
                child: Text("get datat")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'state ',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                Text(
                  ':',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                Container(
                  child: CustomSwitch(
                      activeColor: Colors.pinkAccent,
                      value: status,
                      onChanged: (value) {
                        print("VALUE : $value");
                        setState(() {
                          status = value;
                        });
                      }),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Time ',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                Text(
                  ':',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: _time,
                        onChange: onTimeChanged,
                        minuteInterval: MinuteInterval.FIVE,
                        disableHour: false,
                        disableMinute: false,
                        minMinute: 7,
                        maxMinute: 56,
                        // Optional onChange to receive value as DateTime
                        onChangeDateTime: (DateTime dateTime) {
                          print(dateTime);
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Text(" 12:00 "),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Repeat ',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                Text(
                  ':',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: selected,
                      toggleable: true,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        selected = value;
                      },
                    ),
                    Text('24 Hrs'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Radio(
                      value: 2,
                      groupValue: selected,
                      toggleable: true,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          selected = value;
                        });
                      },
                    ),
                    Text('Don\'t repeat'),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 20.0),
                    )),
                SizedBox(
                  width: 20.0,
                ),
                TextButton(
                    onPressed: () {
                      Provider.of<TaskData>(context, listen: false)
                          .addTask(newTaskTitle);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 20.0),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
