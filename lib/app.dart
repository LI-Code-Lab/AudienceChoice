import 'package:flutter/material.dart';
import 'package:audience_choice/views/tap_screen.dart';
import 'models/colors.dart';

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
      theme: _buildTheme(),
      home: TapScreen(),
    );
  }

  ThemeData _buildTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: kACBlue600,
      accentColor: kACGreen400,
      buttonColor: kACBlue400,
      scaffoldBackgroundColor: kACSurfaceWhite,
      cardColor: kACBackgroundWhite,
      textSelectionColor: kACBlue200,
      errorColor: kACErrorRed,
      hintColor: kACBackgroundWhite,
      buttonTheme: new ButtonThemeData(textTheme: ButtonTextTheme.accent),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
    );
  }

  TextTheme _buildTextTheme(TextTheme base) {
    return base
        .copyWith(
      headline: base.headline.copyWith(
        fontWeight: FontWeight.w500,
      ),
      title: base.title.copyWith(fontSize: 18.0),
      caption: base.caption.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
    ).apply(
      displayColor: Colors.red,
      bodyColor: Colors.white,
    );
  }
}