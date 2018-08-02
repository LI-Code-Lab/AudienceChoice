import 'package:flutter/material.dart';

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
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text("Click to choose your song!", style: new TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
            new FlatButton(onPressed: (){

            }, child: new Text("Click"))
          ],
        ),
      ),
    );
  }
}