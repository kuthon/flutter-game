import 'package:flutter/material.dart';
import 'package:test_game/game/entities/meteor.dart';
import 'package:test_game/game/entities/player.dart';
import 'package:test_game/game/scenes/app_scene.dart';
import 'package:test_game/utils/global_vars.dart';

class GameScene extends AppScene {
  Player _player = Player();
  List<Meteor> _meteors = [
    Meteor(item: 0, length: 4),
    Meteor(item: 1, length: 4),
    Meteor(item: 2, length: 4),
    Meteor(item: 3, length: 4),
  ];
  late double _startPlayerPosition;

  @override
  Widget buildScene() {
    return Stack(
      children: [
        for (Meteor meteor in _meteors) meteor.build(),
        _player.build(),
        Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: GlobalVars.screenHeight,
              width: GlobalVars.screenWidth,
              child: GestureDetector(
                onPanStart: (details) => _onPanStart(details),
                onPanUpdate: (details) => _onPanUpdate(details),
              ),
            )),
      ],
    );
  }

  void _onPanStart(DragStartDetails details) {
    _startPlayerPosition = details.globalPosition.dx;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double updateGlobalPosition = details.globalPosition.dx;
    if ((updateGlobalPosition - _startPlayerPosition).abs() >= 0) {
      _player.dx = (updateGlobalPosition - _startPlayerPosition);
      _startPlayerPosition = _player.x + _player.width / 2;
    } else {
      _player.dx = 0;
    }
  }

  @override
  void update() {
    _player.update();
    for (Meteor meteor in _meteors) {
      meteor.update();
      if (meteor.x > _player.x &&
          meteor.x < (_player.x + _player.width) &&
          meteor.y < (_player.y + _player.height)) {
        meteor.y += GlobalVars.screenHeight;
        print('GAME OVER');
      }
      if ((meteor.x + meteor.width) > _player.x &&
          (meteor.x + meteor.width) < (_player.x + _player.width) &&
          meteor.y < (_player.y + _player.height)) {
        meteor.y += GlobalVars.screenHeight;
        print('GAME OVER');
      }
    }
  }
}
