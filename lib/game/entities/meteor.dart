import 'dart:math';
import 'package:test_game/utils/global_vars.dart';
import 'package:flutter/material.dart';
import 'entity.dart';

class Meteor extends Entity {
  late double _speed;

  late double _angle;
  late double _dAngle;

  int _currentTick = 0;
  double tempo = 1;

  Meteor({double? y, double? x}) : super(spriteName: "meteor", width: 50, height: 50, numberOfSprites: 4) {
          currentSprite = Random().nextInt(4);
          reInit();
          if (y != null)
            this.y = y;
          if (x != null)
            this.x = x;
  }

  void reInit() {
    x = Random().nextDouble() * (GlobalVars.screenWidth - width);
    y = GlobalVars.screenHeight - 0.5 * height;

    _speed = tempo * (Random().nextInt(3) + 1);
    _dAngle = (_speed / 200);
    _angle = Random().nextDouble();
  }

  @override
  Widget build() {
    return Positioned(
        bottom: y,
        left: x,
        child: visible
            ? Transform.rotate(
                angle: 3.14 * _angle,
                child: Container(
                    child: sprites[currentSprite],
                    width: width,
                    height: height
                )
          )
            : SizedBox.shrink());
  }

  @override
  void animate() {
    _angle += _dAngle;
  }

  @override
  void move() {
    _currentTick++;

    /// [tempo] increases every 2 seconds
    if (_currentTick > 100) {
      tempo += 0.05;
      _currentTick = 0;
    }

    y -= _speed;

    if (y < 0 - height)
      reInit();

  }

  @override
  void update() {
    move();
    animate();
  }

}
