import 'package:audioplayers/audioplayers.dart';
import 'package:test_game/game/entities/game_bar.dart';
import 'package:test_game/game/entities/meteor.dart';
import 'package:test_game/game/entities/player.dart';
import 'package:test_game/game/scenes/game_over_scene.dart';
import 'package:test_game/utils/global_vars.dart';
import 'package:flutter/material.dart';
import 'app_scene.dart';

class GameScene extends AppScene {
  AudioCache _audioCache = AudioCache(
      prefix: "assets/audio/",
      fixedPlayer: AudioPlayer(
        mode: PlayerMode.MEDIA_PLAYER,
      )..setReleaseMode(ReleaseMode.STOP))
    ..loadAll(['gameover.mp3', 'fail.mp3']);

  Player _player = Player();
  List<Meteor> _meteors = [
    Meteor(y: GlobalVars.screenHeight * 1.1),
    Meteor(y: GlobalVars.screenHeight * 1.3),
    Meteor(y: GlobalVars.screenHeight * 1.5),
    Meteor(y: GlobalVars.screenHeight * 1.7),
  ];
  GameBar _gameBar = GameBar();

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
              height: GlobalVars.screenHeight - 80,
              width: GlobalVars.screenWidth,
              child: GestureDetector(
                onPanStart: (details) => _onPan(details),
                onPanUpdate: (details) => _onPan(details),
              ),
            )),
        _gameBar.build(),
      ],
    );
  }

  void _onPan(details) {
    if (GlobalVars.isPause == false) {
      double fromPositionX = _player.x + _player.width / 2;
      double toPositionX = details.globalPosition.dx;
      _player.dx = (toPositionX - fromPositionX);
    }
  }

  @override
  void update() {
    _player.update();
    _gameBar.update();

    for (Meteor _meteor in _meteors) {
      _meteor.update();

      //meteor hit check
      if (_meteor.x > _player.x &&
          _meteor.x < (_player.x + _player.width) &&
          _meteor.y < (_player.y + _player.height) &&
          _meteor.y > _player.y) {
        _meteor.reInit();
        fail();
      } else if ((_meteor.x + _meteor.width) > _player.x &&
          (_meteor.x + _meteor.width) < (_player.x + _player.width) &&
          _meteor.y < (_player.y + _player.height) &&
          _meteor.y > _player.y) {
        _meteor.reInit();
        fail();
      }
    }
  }

  void fail() {
    GameBar.lives--;
    if (GameBar.lives == 0) {
      _audioCache.play('gameover.mp3');
      print('GAME OVER');
      GlobalVars.isPause = true;
      GlobalVars.previousScene = this;
      GlobalVars.currentScene = GameOverScene();
    } else {
      _audioCache.play('fail.mp3');
    }
  }
}
