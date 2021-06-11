import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:test_game/utils/global_vars.dart';
import 'main_loop.dart';


class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  late Isolate _isolateLoop;
  late ReceivePort _receivePort;

  void startIsolate() async{
    _receivePort = ReceivePort();
    _isolateLoop = await Isolate.spawn(mainLoop, _receivePort.sendPort);
    _receivePort.listen((message) {
        GlobalVars.currentScene.update();
        setState(() {});

    });
  }

  @override
  void initState() {
    startIsolate();
    super.initState();
  }

  @override
  void dispose() {
    _receivePort.close();
    _isolateLoop.kill();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GlobalVars.currentScene.buildScene();
  }
}
