import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audience_choice/models/colors.dart';

class SettingsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return _buildSettingsScreen();
  }

  Widget _buildSettingsScreen(){
    return new Scaffold(
      appBar: _buildAppBar(),
      body: _buildSettingsList()
    );
  }
  
  Widget _buildSettingsList(){
    return new Container(
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 16.0),
      color: kACFormTextFieldGrey,
      child: new Row(
        children: <Widget>[
          new Text("Reset Poll Results", style: new TextStyle(fontSize: 16.0, color: kACPrimaryText)),
          new IconButton(
              icon: new Icon(Icons.chevron_right),
              onPressed: () {

              })
        ],
      ),
    );
  }

  Widget _buildAppBar(){
    return new AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      title: Text('Settings')
    );
  }
}