import 'package:flutter/material.dart';
import 'package:schedule/schedulePage.dart';
import 'package:schedule/task_view.dart';
import 'package:provider/provider.dart';
import 'task_data.dart';

void main() {
  runApp(
    Home(),
  );
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TaskData(),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/' : (context)=>MyApp(),
            '/first':(context)=>SchedulePage(),
          },
          debugShowCheckedModeBanner: false,
          // home: MyApp(),
        ),
    );
  }
}
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scheduling'),
//         actions: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15.0),
//             child: Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     // Navigator.push(context,
//                     //     MaterialPageRoute(builder: (context) => SchedulePage()));
//                     Navigator.pushNamed(context, '/first');
//                   },
//                   icon: Icon(
//                     Icons.add,
//                     size: 40.0,
//                   ),
//                 ),
//                 TextButton(onPressed: (){
//                   Navigator.pop(context);
//                   // Navigator.pushNamed(context, '/');
//                 }, child: Text("done",style: TextStyle(color: Colors.white),)),
//               ],
//             ),
//
//           )
//         ],
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(30.0),
//             topLeft: Radius.circular(30.0),
//           ),
//           color: Colors.white,
//         ),
//         child: TaskView(),
//       ),
//     );
//   }
// }

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // int _counter = 0;
  // bool _isButtonDisabled;
  //
  // @override
  // void initState() {
  //   _isButtonDisabled = false;
  // }
  //
  // void _incrementCounter() {
  //   setState(() {
  //     _isButtonDisabled = true;
  //     _counter++;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduling'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SchedulePage()));
                    // Navigator.pushNamed(context, '/first');
                    // Navigator.popAndPushNamed(context, '/first');
                   // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SchedulePage()), (route) => true);
                  },
                  icon: Icon(
                    Icons.add,
                    size: 40.0,
                  ),
                ),
              ],
            ),

          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
          color: Colors.white,
        ),
        child: TaskView(),
      ),
    );
  }
}
