import 'package:flutter/material.dart';
import 'package:audience_choice/models/colors.dart';
import 'package:flutter/cupertino.dart';

class FeedCell extends StatelessWidget{

  final title;
  final artist;
  final comment;

  FeedCell(this.title, this.artist, this.comment);

  @override
  Widget build(BuildContext context) {
    return _buildFeedCell();
  }

  Widget _buildFeedCell(){
    return Card(
      child: new Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Text(title, style: new TextStyle(fontSize: 16.0, color: kACPrimaryText)),
            new Text(artist, style: new TextStyle(fontSize: 14.0, color: kACPrimaryText)),
            new Text(comment, style: new TextStyle(fontSize: 12.0, color: kACPrimaryText))
          ],
        ),
      ),
    );
  }
}