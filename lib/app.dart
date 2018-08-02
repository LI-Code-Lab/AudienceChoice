import 'package:flutter/material.dart';
import 'package:audience_choice/views/tap_screen.dart';

class App extends StatefulWidget{
  @override
  State createState() {
    return new AppState();
  }
}

class AppState extends State<App>{
  @override
  Widget build(BuildContext context) {
    return _buildApp();
  }

  Widget _buildApp(){
    return new MaterialApp(
      home: TapScreen(),
    );
  }
}