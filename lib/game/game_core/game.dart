import 'dart:isolate';
import 'package:test_game/utils/global_vars.dart';
import 'package:flutter/material.dart';
import 'main_loop.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with WidgetsBindingObserver {

  AppLifecycleState _state = AppLifecycleState.resumed;
  late Isolate _isolateLoop;
  late ReceivePort _receivePort;

  void startIsolate() async{
    _receivePort = ReceivePort();
    _isolateLoop = await Isolate.spawn(mainLoop, _receivePort.sendPort);
    _receivePort.listen((message) {
        if (_state == AppLifecycleState.resumed && GlobalVars.isPause == false) {
          GlobalVars.currentScene.update();
        }
        setState(() {});
    });
  }

  @override
  void initState() {
    startIsolate();
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _state = state;
  }

  @override
  void dispose() {
    _receivePort.close();
    _isolateLoop.kill();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GlobalVars.currentScene.buildScene();
  }
}
