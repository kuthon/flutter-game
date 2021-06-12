import 'dart:math';
import 'package:test_game/utils/global_vars.dart';
import 'package:flutter/material.dart';

import 'entity.dart';

class Meteor extends Entity {
  late double _speed;
  late int _currentTick;
  late double _angle;
  late double _dAngle;

  double rate = 1;

  Meteor({int? item, int? length})
      : super(spriteName: "meteor", width: 50, height: 50, numberOfSprites: 4) {
          reInit();
          if (item != null && length != null)
            y += (GlobalVars.screenHeight * (item / length));
          currentSprite = Random().nextInt(4);
  }

  void reInit() {
    x = Random().nextDouble() * (GlobalVars.screenWidth - width);
    y = GlobalVars.screenHeight - 0.5 * height;

    _currentTick = 0;
    _speed = rate * (Random().nextInt(3) + 1);
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

    ///rate increases every 3 seconds
    if (_currentTick > 150) {
      rate += 0.2;
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
