import 'package:flutter/material.dart';
import 'package:test_game/game/entities/player.dart';
import 'package:test_game/game/scenes/app_scene.dart';

class GameScene extends AppScene {

  Player _player = Player();

  @override
  Widget buildScene() {
    return Stack(
      children: [
        _player.build()
      ],
    );
  }

  @override
  void update() {
    _player.update();
  }

}