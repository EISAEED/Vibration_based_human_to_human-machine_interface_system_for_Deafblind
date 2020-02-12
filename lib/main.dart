import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:morse/morse.dart';

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

      final String message = 'welcome';
      String encodedMessage =  new Morse(message).encode();

      List<String> MorsePattern = encodedMessage.split('');

      print(MorsePattern);

      List<int> INTMorsePattern = [];

      for (var i= 0; i < MorsePattern.length; i++)
        {
          if ((MorsePattern[i] == ".") || (MorsePattern[i] == " ."))
          {
            INTMorsePattern.add(200);
          }
          else if ((MorsePattern[i] == "-") || (MorsePattern[i] == " -"))
          {
            INTMorsePattern.add(600);
          }
          if ((MorsePattern[i] == "  ") || (MorsePattern[i] == " "))
          {
            INTMorsePattern.add(600);
          }
        }

      print(INTMorsePattern);

      Vibration.vibrate(pattern: INTMorsePattern);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
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