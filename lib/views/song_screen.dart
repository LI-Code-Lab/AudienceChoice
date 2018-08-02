import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audience_choice/models/colors.dart';
import 'song_cell.dart';

class SongScreen extends StatefulWidget{
  @override
  State createState() {
    return SongScreenState();
  }
}

class SongScreenState extends State<SongScreen>{

  bool isActive = false;
  final listCount = 10;
  final titles = ["Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title"];

  @override
  Widget build(BuildContext context) {
    return _buildSongScreen();
  }

  Widget _buildSongScreen(){
    return new Scaffold(
      appBar: _buildAppBar(),
      body: new Center(
        child: new Column(
          children: <Widget>[
            _buildSongList(),
            _buildRequestButton()
          ],
        )
      ),
    );
  }

  Widget _buildSongList(){
    return Expanded(
      child: new ListView.builder(
          itemCount: listCount,
          itemExtent: 65.0,
          itemBuilder: (context, index) {
            return new FlatButton(
              onPressed: null,
              child: new SongCell(
                  titles[index] + " " + index.toString()),
              padding: new EdgeInsets.all(0.0),
            );
          }),
    );
  }

  Widget _buildRequestButton(){
    return Container(
      width: 500.0,
      child: MaterialButton(
        padding: EdgeInsets.all(16.0),
        child: new Text("Request", style: new TextStyle(fontSize: 16.0, color: kACBackgroundWhite)),
        color: kACBlue600,
        onPressed: (){
          _buildRequestAlert();
        },
      ),
    );
  }

  Widget _buildAppBar(){
    return new AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      title: Text('Song List'),
    );
  }

  Future<Null> _buildRequestAlert() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: new Text("Are you sure?"),
            content: new Text("This will submit the songs you selected from the list."),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Cancel', style: new TextStyle(color: kACPrimaryText)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('OK', style: new TextStyle(color: kACPrimaryText)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}