import 'package:test_game/utils/global_vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'entity.dart';

class GameBar extends Entity {

  static int score = 0;
  static int lives = 3;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Container(
                height: 40,
                width: 40,
                child: Center(
                  child: Icon(
                    GlobalVars.isPause ?  Icons.play_arrow: Icons.pause,
                    color: Colors.grey.withOpacity(0.9),
                  ),
                ),
              ),
              onTap: () {
                GlobalVars.isPause = !GlobalVars.isPause;
              },
            ),
            Text('Score: $score', style: TextStyle(fontSize: 16, color: Colors.white),),
            Container(
              width: 72,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (int i = 0; i < lives; i++)
                    Icon(Icons.favorite, color: Colors.red,)
                ],
              ),
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