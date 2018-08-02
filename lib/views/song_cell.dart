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
  bool _vote = false;

  SongCellState(this.title);

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: kACFormTextFieldGrey,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Row(
              children: <Widget>[
                Container(
                  width: 300.0,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(title, style: new TextStyle(color: kACPrimaryText, fontSize: 16.0))
                    ],
                  ),
                ),
                Container(
                  width: 50.0,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new CupertinoSwitch(
                        value: _vote,
                        onChanged: (bool value) {
                          setState(() {
                            _vote = value;
                          });
                        },
                        activeColor: kACGreen400,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}