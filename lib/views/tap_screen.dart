import 'package:flutter/material.dart';
import 'package:audience_choice/models/colors.dart';
import "song_screen.dart";

class TapScreen extends StatefulWidget{

  @override
  State createState() {
    return new TapScreenState();
  }
}

class TapScreenState extends State<TapScreen>{
  @override
  Widget build(BuildContext context) {
    return _buildTapScreen();
  }

  Widget _buildTapScreen(){
    return Scaffold(
      appBar: _buildAppBar(),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text("Click to choose your song!", style: new TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500, color: kACBlue600), textAlign: TextAlign.center),
              new FlatButton(onPressed: (){
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SongScreen()));
              }, child: new Text("Click"), color: kACBlue600,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(){
    return new AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      title: Text('Audience Choice'),
    );
  }
}