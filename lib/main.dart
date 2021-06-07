import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_game/utils/global_vars.dart';
import 'game/game_core/game.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void didChangeDependencies() {
    GlobalVars.screenHeight = MediaQuery.of(context).size.height;
    GlobalVars.screenWidth = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        debugShowCheckedModeBanner: false,
          home: SafeArea(
            child: Scaffold(
              body: Game(),
            ),
          )
    );
  }
}
