import 'package:flutter/material.dart';
import 'package:test_game/game_core/main_loop.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () => mainLoop(),
                 child: Text('START')
              ),
              TextButton(
                onPressed: () => stopLoop(),
                 child: Text('STOP')
              ),
              TextButton(
                onPressed: () => print('print'),
                 child: Text('PRINT')
              ),
            ],
        )
      )
    );
  }
}
