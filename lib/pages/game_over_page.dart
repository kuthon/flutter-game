import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_game/game/entities/game_bar.dart';
import 'package:test_game/game/scenes/game_scene.dart';
import 'package:test_game/services/navigation_service.dart';
import 'package:test_game/utils/global_vars.dart';

class GameOverPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        GameBar.score = 0;
        GlobalVars.currentScene = GameScene();
        GlobalVars.isPause = false;
        NavigationService.instance.goBack();
        return Future.value(false);
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Your Score: ${GameBar.score}'),
              RawMaterialButton(
                child: Icon(
                  Icons.subdirectory_arrow_left,
                  semanticLabel: 'Play Again',
                ),
                onPressed: () {
                  GameBar.score = 0;
                  GlobalVars.currentScene = GameScene();
                  GlobalVars.isPause = false;
                  NavigationService.instance.goBack();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
