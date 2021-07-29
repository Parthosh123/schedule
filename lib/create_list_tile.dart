import 'package:flutter/material.dart';

class ListTilePage extends StatelessWidget {

  ListTilePage({this.title,this.subTitle,this.status,this.time,this.count});

  final String title;
  final String subTitle;
  final bool status;
  final String time;
  final int count;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(count.toString()),
      title: Text(title),
      subtitle: Row(
        children: [
          Text(subTitle),
          Text(time),
        ],
      ),


    );
  }
}

