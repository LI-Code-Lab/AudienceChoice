import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audience_choice/models/colors.dart';
import 'package:audience_choice/views/feed_cell.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  bool isMostRecent = false;
  List<DocumentReference> _documentReferences = [];

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

  Widget _buildFilterBar(){
    return Container(
      width: 400.0,
      color: kACSurfaceBlack,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new FlatButton(
              onPressed: () {
                _buildFilterPicker();
              },
              child: new Text("Filter", style: new TextStyle(fontSize: 14.0, color: kACBlue600)))
        ],
      ),
    );
  }

  Widget _buildSongList(){
    return new Column(
      children: <Widget>[
        _buildFilterBar(),
        new Flexible(child: _getFeed(isMostRecent)),
        new Divider(height: 1.0)
      ],
    );
//    return new ListView.builder(
//        itemCount: listCount,
//        itemExtent: 85.0,
//        itemBuilder: (context, index) {
//          return new FlatButton(
//            onPressed: null,
//            child: new FeedCell(
//                titles[index], artist[index], comments[index]),
//            padding: new EdgeInsets.all(0.0)
//          );
//        });
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
                    _deleteAllRequests(_documentReferences);
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
              child: _buildTextField("Password"),
            ),
          ],
        ));
  }

  StreamBuilder _getFeed(bool isMostRecent){
    if(!isMostRecent){
      return new StreamBuilder(
          stream: Firestore.instance.collection('feed').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return CircularProgressIndicator();
            return new ListView.builder(
                padding: new EdgeInsets.all(4.0),
                itemCount: snapshot.data.documents.length,
                itemExtent: 115.0,
                itemBuilder: (context, index){
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  DocumentReference dr = ds.reference;
                  _documentReferences.add(dr);
                  return FeedCell("${ds['songTitle']}", "${ds['artist']}", "${ds['comment']}");
                });
          });
    }
    else{
      return new StreamBuilder(
          stream: Firestore.instance.collection('feed').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return CircularProgressIndicator();
            return new ListView.builder(
              reverse: true,
                padding: new EdgeInsets.all(4.0),
                itemCount: snapshot.data.documents.length,
                itemExtent: 115.0,
                itemBuilder: (context, index){
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  DocumentReference dr = ds.reference;
                  _documentReferences.add(dr);
                  return FeedCell("${ds['songTitle']}", "${ds['artist']}", "${ds['comment']}");
                });
          });
    }
  }

  void _deleteAllRequests(List<DocumentReference> references){
    for(var i = 0; i < references.length; i++){
      _deleteRequest(references[i]);
    }
  }

  void _deleteRequest(DocumentReference reference){
    Firestore.instance.runTransaction((transaction) async {
          await transaction.delete(reference).whenComplete((){
            _buildRequestCompletionAlert("Feed has been successfully reset.");
          }).catchError((e) => _buildRequestCompletionAlert(e));
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

  Future<Null> _buildFilterPicker() async{
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoPicker(
            backgroundColor: kACSurfaceGreyLight,
              itemExtent: 25.0,
              onSelectedItemChanged: null, 
              children: <Widget>[
                new Text("Most Recent", style: new TextStyle(fontSize: 18.0, color: kACPrimaryText)),
                new Text("Chronological", style: new TextStyle(fontSize: 18.0, color: kACPrimaryText))
              ]);
        });
  }
}