import 'package:flutter/material.dart';
import 'package:audience_choice/models/colors.dart';
import 'package:flutter/cupertino.dart';

class PollCell extends StatefulWidget{
  final title;

  PollCell(this.title);

  @override
  State createState() {
    return PollCellState(title);
  }
}

class PollCellState extends State<PollCell>{

  final title;

  PollCellState(this.title);

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
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(title, style: new TextStyle(color: kACPrimaryText, fontSize: 16.0))
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Text("0", style: new TextStyle(color: kACPrimaryText, fontSize: 16.0))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}