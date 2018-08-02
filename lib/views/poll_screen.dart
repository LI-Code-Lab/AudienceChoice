import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audience_choice/models/colors.dart';
import "package:audience_choice/views/poll_cell.dart";

class PollScreen extends StatefulWidget{
  @override
  State createState() {
    return PollScreenState();
  }
}

class PollScreenState extends State<PollScreen>{

  final listCount = 10;
  final titles = ["Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title"];

  @override
  Widget build(BuildContext context) {
    return _buildPollScreen();
  }

  Widget _buildPollScreen(){
    return new Scaffold(
      appBar: _buildAppBar(),
      body: new Center(
        child: _buildSongList(),
      ),
    );
  }

  Widget _buildSongList(){
    return new ListView.builder(
        itemCount: listCount,
        itemExtent: 65.0,
        itemBuilder: (context, index) {
          return new FlatButton(
            onPressed: null,
            child: new PollCell(
                titles[index]),
            padding: new EdgeInsets.all(4.0),
          );
        });
  }

  Widget _buildAppBar(){
    return new AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      title: Text('Poll Results'),
      actions: <Widget>[
        new FlatButton(
          child: new Text("Settings", style: new TextStyle(color: kACBackgroundWhite)),
          onPressed: (){

          },)
      ],
    );
  }
}