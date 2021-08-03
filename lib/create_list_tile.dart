import 'package:flutter/material.dart';

class ListTilePage extends StatelessWidget {

  ListTilePage({this.title,this.subTitle,this.status,this.time,this.count,this.repeat});

  final String title;
  final String subTitle;
  final bool status;
  final String time;
  final int count;
  final int repeat;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(count.toString()),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          (repeat == 2)? Text("Don\'t repeat"):Text("EveryDay"),

        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(subTitle,style: TextStyle(fontSize: 9.0),),
          Text(time,style: TextStyle(fontSize: 12.0),),
        ],
      ),
      trailing: status ? Text("ON"):Text("OFF"),
    );
  }
}

