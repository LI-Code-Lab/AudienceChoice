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

  final listCount = 1;
  final titles = ["Song Title"];


  @override
  Widget build(BuildContext context) {
    return _buildSongScreen();
  }

  Widget _buildSongScreen(){
    return new Scaffold(
      appBar: _buildAppBar(),
      body: new Center(
        child: _buildSongList()
      ),
    );
  }

  Widget _buildSongList(){
    return Expanded(
      child: new ListView.builder(
          itemCount: listCount,
          itemExtent: 125.0,
          itemBuilder: (context, index) {
            return new FlatButton(
              onPressed: () {
                //navigate to next screen
//                if(index == 0){
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => ServiceFormScreen()));
//                }
//                if(index == 1){
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => EstimateFormScreen()));
//                }
//                if(index == 2){
//                  launch(phoneNumber);
//                }
              },
              child: new SongCell(
                  titles[index] + " " + index.toString()),
              padding: new EdgeInsets.all(0.0),
            );
          }),
    );
  }

  Widget _buildAppBar(){
    return new AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      title: Text('Song List'),
    );
  }
}