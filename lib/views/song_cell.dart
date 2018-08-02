import 'package:flutter/material.dart';
import 'package:audience_choice/models/colors.dart';
import 'package:flutter/cupertino.dart';

class SongCell extends StatefulWidget{
  final title;

  SongCell(this.title);

  @override
  State createState() {
    return SongCellState(title);
  }
}

class SongCellState extends State<SongCell> {
  final title;
  bool _vote;

  SongCellState(this.title);

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: kACSurfaceGrey,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Text(title, style: new TextStyle(color: kACPrimaryText, fontSize: 16.0)),
          new CupertinoSwitch(
              value: _vote,
              onChanged: (bool value) {
                setState(() {
                  _vote = value;
                });
              })
        ],
      ),
    );
  }
}