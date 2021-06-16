import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_game/game/entities/game_bar.dart';
import 'package:test_game/game/scenes/game_scene.dart';
import 'package:test_game/utils/global_vars.dart';
import 'app_scene.dart';

class GameOverScene extends AppScene{

  void _startNewGame(){
    GlobalVars.currentScene = GameScene();
    GlobalVars.isPause = false;
  }

  void _continueGame(){
    GlobalVars.isPause = false;
    GameBar.lives = 3;
    GlobalVars.currentScene = GlobalVars.previousScene;
  }

  @override
  void update(){}

  @override
  Widget buildScene() {
    return WillPopScope(
      onWillPop: () {
        _startNewGame();
        return Future.value(false);
      },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Game over!',
                      style: TextStyle(
                          fontSize: 24
                      ),
                    ),
                    SizedBox(height: 40,),
                    Text(
                      'Your Score: ${GameBar.score}',
                      style: TextStyle(
                          fontSize: 22
                      ),
                    ),
                    SizedBox(height: 20,),
                    RawMaterialButton(
                      child: RichText(
                        text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.subdirectory_arrow_left,
                                  size: 20,
                                ),
                              ),
                              TextSpan(
                                  text: ' Play again',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20
                                  )
                              ),
                            ]
                        ),
                      ),
                      onPressed: () {
                        _startNewGame();
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    RawMaterialButton(
                      child: RichText(
                        text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.ondemand_video,
                                  size: 20,
                                ),
                              ),
                              TextSpan(
                                  text: ' Continue',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20
                                  )
                              ),
                            ]
                        ),
                      ),
                      onPressed: () {
                        _continueGame();
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
    );
  }
}
