import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class MyAppBar extends StatefulWidget {
  MyAppBar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {


  void _incrementCounter() {
    setState(() async {

      if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
      }

      if (await Vibration.hasAmplitudeControl()) {
      Vibration.vibrate(amplitude: 128);
      }

      Vibration.vibrate(duration: 1000);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[IconButton(icon: Icon(Icons.menu), tooltip: 'Navigation menu', onPressed: _incrementCounter,),],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(theme: ThemeData(primarySwatch: Colors.blue,),
      home: Scaffold(body: Center(child: MyAppBar(),)
      )
    );
  }
}

void main()
{
  runApp(MaterialApp(title: 'My app', home: MyScaffold(),));
}