import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audience_choice/models/colors.dart';
import 'package:audience_choice/views/feed_screen.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class TapScreen extends StatefulWidget{

  @override
  State createState() {
    return new TapScreenState();
  }
}

class TapScreenState extends State<TapScreen>{

  File _logoImage;

  final TextEditingController _adminController = new TextEditingController();

  final TextEditingController _songTitleController = new TextEditingController();
  final TextEditingController _artistController = new TextEditingController();
  final TextEditingController _commentController = new TextEditingController();

  final activePin = "080118";

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
                    _buildRequestAlert();
                  }, child: new Text("Request", style: new TextStyle(color: kACBackgroundWhite)), color: kACSurfaceGrey,),
              ),
              new FlatButton(
                  onPressed: () {
                    _buildAdminAlert();
                  }, child: new Text(".", style: new TextStyle(color: kACBackgroundWhite, fontSize: 12.0)))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(){
    return Container(
      height: 250.0,
      width: 250.0,
      margin: EdgeInsets.all(32.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: new DecorationImage(
              image: _logoImage == null ? new AssetImage('assets/ed_main_logo.png') : new FileImage(_logoImage)
          )
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
                new Text("Enter password to access admin privileges."),
                _buildAdminTextComposer()
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
                  if(_adminController.text == activePin){
                  _buildAdminActionsAlert();
                    _adminController.clear();
                  }
                },
              )
            ],
          );
        });
  }

  Future<Null> _buildAdminActionsAlert() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: new Text("Administrator?"),
            content: new Column(
              children: <Widget>[
                new Text("Admin access success. What would you like to do?"),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SHOW FEED', style: new TextStyle(color: kACPrimaryText)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FeedScreen()));
                },
              ),
              new FlatButton(
                child: new Text('UPDATE LOGO', style: new TextStyle(color: kACPrimaryText)),
                onPressed: () {
                  _buildLogoRequest();
                },
              ),
              new FlatButton(
                child: new Text('Cancel', style: new TextStyle(color: kACPrimaryText)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return FlatButton(
      highlightColor: kACBackgroundWhite,
      disabledColor: kACBackgroundWhite,
      child: new Container(
        child: new TextField(
            decoration: new InputDecoration.collapsed(
                hintText: label
            ),
            controller: controller,
            style: TextStyle(color: kACPrimaryText, fontSize: 14.0)
        ),
      ),
      onPressed: () {

      },
    );
  }

  Widget _buildAdminTextComposer() {
    return new Container(
        color: kACSurfaceGreyLight,
        margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: _buildTextField("Password", _adminController),
            ),
          ],
        ));
  }

  Future<Null> _buildRequestAlert() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: new Text("Request Song?"),
            content: new Column(
              children: <Widget>[
                new Text("Enter a song title, artist or both! You can also leave a comment."),
                _buildSongTextComposer(),
                new Text("and/or"),
                _buildArtistTextComposer(),
                new Text("Comment"),
                _buildCommentTextComposer()
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Cancel', style: new TextStyle(color: kACPrimaryText)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _clearRequestFields();
                },
              ),
              new FlatButton(
                child: new Text('Submit', style: new TextStyle(color: kACPrimaryText)),
                onPressed: () {
                  if(_songTitleController.text.isEmpty && _artistController.text.isEmpty){
                    _buildRequestFailedAlert();
                  }
                  else{
                    Navigator.of(context).pop();
                    _postRequest(_songTitleController.text, _artistController.text, _commentController.text);
                  }
                },
              )
            ],
          );
        });
  }

  Widget _buildSongTextComposer() {
    return new Container(
        color: kACSurfaceGreyLight,
        margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: _buildTextField("Song Title: ", _songTitleController)
            ),
          ],
        ));
  }

  Widget _buildArtistTextComposer() {
    return new Container(
        color: kACSurfaceGreyLight,
        margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
                child: _buildTextField("Artist Name: ", _artistController)
            ),
          ],
        ));
  }

  Widget _buildCommentTextComposer() {
    return new Container(
        color: kACSurfaceGreyLight,
        margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
        child: SizedBox(
          height: 100.0,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Flexible(
                  child: _buildTextField("Ex: For my friend John ", _commentController)
              ),
            ],
          ),
        ));
  }

  Future<Null> _buildRequestFailedAlert() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: new Text("Failed to Submit"),
            content: new Text("To request a song you must include a song title and/or artist name."),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK', style: new TextStyle(color: kACPrimaryText)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _buildRequestAlert();
                },
              )
            ],
          );
        });
  }

  Future<Null> _buildRequestCompletionAlert(String message) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: new Text("Request"),
            content: new Text(message),
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

  void _postRequest(String title, String artist, String comment){
    Firestore.instance
        .collection("feed")
        .document()
        .setData(_buildNewRequest(title, artist, comment))
        .whenComplete(() {
          _buildRequestCompletionAlert("Request submitted successfully");
          _clearRequestFields();
    }).catchError((e) => _buildRequestCompletionAlert(e));
  }

  Map<String, String> _buildNewRequest(String title, String artist, String comment) {
    Map<String, String> data = <String, String>{
      "songTitle": title,
      "artist": artist,
      "comment": comment
    };
    return data;
  }

  void _clearRequestFields(){
    _commentController.clear();
    _artistController.clear();
    _songTitleController.clear();
  }

  Future _buildLogoRequest() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _logoImage = image;
    });
  }
}