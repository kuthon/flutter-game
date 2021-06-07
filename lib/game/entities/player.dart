import 'package:flutter/material.dart';
import 'package:test_game/utils/global_vars.dart';
import 'entity.dart';


class Player extends Entity {
  Player() : super("spaceRocket") {
    x = 0;
    y = 0;
  }

  @override
  Widget build() {
    return Positioned(
        top: y, left: x, child: visible ? sprites.first : SizedBox());
  }

  @override
  void move() {
    x++;
    if (x > GlobalVars.screenWidth) {
      x = 0;
    }
  }

  @override
  void update() {
    move();
  }
}