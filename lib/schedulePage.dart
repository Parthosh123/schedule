import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'task_data.dart';

var data;
List<String> value = ["please select something"];

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _validate = false;
  TextEditingController _controller = TextEditingController();
  String newTaskTitle;
  String dropdownValue;
  bool status = false;
  int selected = 2;
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);


  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  Future getData()async{
    print("geting data");
    http.Response response= await http.get(Uri.parse('http://192.168.1.18:8000/key'));
    if(response.statusCode==200) {
      var data = jsonDecode(response.body);
      // print(data);

      return data;
    }
  }

  storeTheData() async{

    print('im storing data');
    var data = await getData();
    // data = await jsonDecode(data);
    // print(data[9]);
    for(int i =0;i>=0;i++) {
      if(i != (data.length)){
        // print(data[i]);
        setState(() {
          value.add(data[i]);
        });


      }

      else if(i == (data.length)){
        // print("length of i = $i");
        // print('inside the else if');
        value.remove(value[0]);
        break;
      }
      print("value ======================== $value");
    }
  }
  @override
  void initState() {
    print('initializing it');
    storeTheData();
    super.initState();
    _controller = TextEditingController();

  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                    decoration: InputDecoration(
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    ),
                  ),
                )
              ],
            ),
            DropdownButton(
              // dropdownColor: Colors.purple,
              hint: Text("Select any one devices"),
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(
                fontSize: 12.0,
                  color: Colors.deepPurple
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items:value
                  .map((value1) {
                return DropdownMenuItem<String>(
                  value: value1,
                  child: Text(value1),
                );
              })
                  .toList(),
            ),
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
                    child: Text(_time.format(context),),
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
                          .addTask(newTaskTitle,dropdownValue,_time.format(context),status,selected);
                      Navigator.pop(context);



                      setState(() {
                        _controller.text.isEmpty ? _validate = true : _validate = false;
                      });
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