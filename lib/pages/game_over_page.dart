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
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/gameover.png'),
                  fit: BoxFit.cover)),
          width: double.infinity,
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
                      'Your Score: ${GameBar.score}',
                    style: TextStyle(
                      fontSize: 24
                    ),
                  ),
                  SizedBox(height: 40,),
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
                      GameBar.score = 0;
                      GameBar.lives = 3;
                      GlobalVars.currentScene = GameScene();
                      GlobalVars.isPause = false;
                      NavigationService.instance.goBack();
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
                      GameBar.lives = 3;
                      GlobalVars.isPause = false;
                      NavigationService.instance.goBack();
                    },
                  ),
                ],
              ),
        ),
            ],
          ),
      ),
      ),
    );
  }
}
