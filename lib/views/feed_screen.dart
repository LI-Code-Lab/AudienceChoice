import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audience_choice/models/colors.dart';
import 'settings_screen.dart';
import 'package:audience_choice/views/feed_cell.dart';
import 'dart:async';

class FeedScreen extends StatefulWidget{
  @override
  State createState() {
    return FeedScreenState();
  }
}

class FeedScreenState extends State<FeedScreen>{

  final TextEditingController _textController = new TextEditingController();
  final listCount = 10;
  final titles = ["Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title", "Song Title"];
  final artist = ["Bon Jovi", "---", "Bon Jovi", "---", "Bon Jovi", "---", "Bon Jovi", "---", "Bon Jovi", "---"];
  final comments = ["---", "adfasdfasdf", "---", "adfasdfaafbqlebfahjbsdflhjabdfsdf", "---", "adfasdfasdf", "---", "adfasdfasdf", "---", "adfasdfasdf" ];
  final activePin = "1111";

  @override
  Widget build(BuildContext context) {
    return _buildPollScreen();
  }

  Widget _buildPollScreen(){
    return new Scaffold(
      appBar: _buildAppBar(),
      body: new Center(
        child: _buildSongList()
      ),
    );
  }

  Widget _buildSongList(){
    return new ListView.builder(
        itemCount: listCount,
        itemExtent: 85.0,
        itemBuilder: (context, index) {
          return new FlatButton(
            onPressed: null,
            child: new FeedCell(
                titles[index], artist[index], comments[index]),
            padding: new EdgeInsets.all(0.0)
          );
        });
  }

  Widget _buildAppBar(){
    return new AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      title: Text('Feed'),
      actions: <Widget>[
        new FlatButton(
          child: new Text("Reset", style: new TextStyle(color: kACBackgroundWhite)),
          onPressed: (){
              _buildResetAlert();
          },)
      ],
    );
  }

  Future<Null> _buildResetAlert() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: new Text("Are you sure?"),
            content: new Column(
              children: <Widget>[
                new Text("This will reset the current song feed back to zero"),
                _buildTextComposer()
              ],
            ),
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
                  if(_textController.text == activePin){
                    Navigator.of(context).pop();
                    _buildSuccessAlert();
                  }
                },
              )
            ],
          );
        });
  }

  Future<Null> _buildSuccessAlert() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: new Text("Reset"),
            content: new Text("The song list has been successfully reset to zero."),
            actions: <Widget>[
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

  Widget _buildTextField(String label) {
    return FlatButton(
      highlightColor: kACBackgroundWhite,
      disabledColor: kACBackgroundWhite,
      child: new Container(
        child: new TextField(
          controller: _textController,
          style: TextStyle(color: kACPrimaryText, fontSize: 14.0)
        ),
      ),
      onPressed: () {

      },
    );
  }

  Widget _buildTextComposer() {
    return new Container(
        color: kACSurfaceGreyLight,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: _buildTextField("Enter pin"),
            ),
          ],
        ));
  }
}