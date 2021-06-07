import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test_game/game/entities/entity.dart';
import 'package:test_game/utils/global_vars.dart';

class Meteor extends Entity {
  double _speed = 1;
  int currentTick = 0;

  Meteor({int? item, int? length})
      : super(spriteName: "meteor", width: 50, height: 50, numberOfSprites: 4) {
    _initMeteor();
    if (item != null && length != null)
      y += (GlobalVars.screenHeight * (item / length));
    currentSprite = Random().nextInt(4);
  }

  void _initMeteor() {
    x = Random().nextDouble() * (GlobalVars.screenWidth - width);
    y = GlobalVars.screenHeight - 0.5 * height;
  }

  @override
  Widget build() {
    return Positioned(
        bottom: y,
        left: x,
        child: visible
            ? Container(
            child: sprites[currentSprite], width: width, height: height)
            : SizedBox.shrink());
  }

  @override
  void move() {
    currentTick++;
    if (currentTick > 180) {
      _speed += 0.25;
      currentTick = 0;
    }
    y -= _speed;

    if (y < 0 - height)
      _initMeteor();
  }

  @override
  void update() {
    move();
  }
}
