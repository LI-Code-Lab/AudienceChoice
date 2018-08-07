import 'package:flutter/material.dart';
import 'package:audience_choice/models/colors.dart';
import 'package:audience_choice/views/poll_screen.dart';

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
      body: new Container(
        color: kACPrimaryText,
        padding: EdgeInsets.all(16.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildLogo(),
              new Text("Click to choose your song!", style: new TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500, color: kACBackgroundWhite), textAlign: TextAlign.center),
              new Container(
                width: 300.0,
                height: 50.0,
                margin: EdgeInsets.all(32.0),
                child: new FlatButton(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: (){

                  }, child: new Text("Request", style: new TextStyle(color: kACBackgroundWhite)), color: kACSurfaceGrey,),
              ),
              new Text("Admin", style: new TextStyle(color: kACBlue600, fontSize: 12.0))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(){
    return Container(
      height: 200.0,
      width: 200.0,
      margin: EdgeInsets.all(32.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage('assets/ed_main_logo.png'))
        ),
      ),
    );
  }
}