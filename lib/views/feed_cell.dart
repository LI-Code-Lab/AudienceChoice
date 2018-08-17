import 'package:flutter/material.dart';
import 'package:audience_choice/models/colors.dart';
import 'package:flutter/cupertino.dart';

class FeedCell extends StatelessWidget{

  String title;
  String artist;
  String comment;

  FeedCell(this.title, this.artist, this.comment);

  @override
  Widget build(BuildContext context) {
    return _buildFeedCell();
  }

  Widget _buildFeedCell(){
    _formatNullFields();
    return Card(
      child: new Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
                margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                child: new Text("Title: " + title, style: new TextStyle(fontSize: 18.0, color: kACPrimaryText, fontWeight: FontWeight.bold))),
            new Container(
                margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                child: new Text("Artist: " + artist, style: new TextStyle(fontSize: 14.0, color: kACPrimaryText, fontWeight: FontWeight.bold))),
            new Text("Comment: " + comment, style: new TextStyle(fontSize: 12.0, color: kACPrimaryText, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }

  void _formatNullFields(){
    if(title.length == 0){
      title = '---';
    }
    if(artist.length == 0){
      artist = '---';
    }
    if(comment.length == 0){
      comment = '---';
    }
  }
}