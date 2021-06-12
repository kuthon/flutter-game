import 'package:test_game/utils/global_vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'entity.dart';

class GameBar extends Entity {

  late int score;
  late int lives;

  GameBar() : super(numberOfSprites: 0, height: 40, width: GlobalVars.screenWidth, spriteName: ""){
    reInit();
  }

  void reInit(){
    score = 0;
    lives = 3;
  }

  @override
  Widget build() {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        width: width,
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Счёт: $score', style: TextStyle(fontSize: 16, color: Colors.white),),
            Row(
              children: [
                for (int i = 0; i < lives; i++)
                  Icon(Icons.favorite, color: Colors.red,)
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void move();

  @override
  void update(){
    score += 1;
  }

  @override
  void animate();

}