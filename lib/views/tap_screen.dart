import 'package:flutter/material.dart';
import 'package:audience_choice/models/colors.dart';
import 'package:audience_choice/views/feed_screen.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

class TapScreen extends StatefulWidget{

  @override
  State createState() {
    return new TapScreenState();
  }
}

class TapScreenState extends State<TapScreen>{

  final TextEditingController _textController = new TextEditingController();
  final activePin = "1111";

  @override
  Widget build(BuildContext context) {
    return _buildTapScreen();
  }

  Widget _buildTapScreen(){
    return Scaffold(
      body: new Container(
        color: kACSurfaceBlack,
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
              new FlatButton(
                  onPressed: () {
                    _buildAdminAlert();
                  }, child: new Text("Admin", style: new TextStyle(color: kACBlue600, fontSize: 12.0)))
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

  Future<Null> _buildAdminAlert() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: new Text("Administrator?"),
            content: new Column(
              children: <Widget>[
                new Text("Enter pin to access admin privileges."),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeedScreen()));
                    _textController.clear();
                  }
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
            style: TextStyle(color: kACPrimaryText, fontSize: 18.0)
        ),
      ),
      onPressed: () {

      },
    );
  }

  Widget _buildTextComposer() {
    return new Container(
        color: kACSurfaceGrey,
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