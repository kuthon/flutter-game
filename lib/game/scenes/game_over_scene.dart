
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_game/game/entities/game_bar.dart';
import 'package:test_game/game/scenes/game_scene.dart';
import 'package:test_game/utils/global_vars.dart';
import 'app_scene.dart';

class GameOverScene extends AppScene{

  void _startNewGame(){
    GlobalVars.currentScene = GameScene();
    GlobalVars.isPause = false;
  }

  void _continueGame() async{
    GlobalVars.rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
    );
    if (GlobalVars.rewardedAd != null && GlobalVars.adIsShowed == false) {
      await GlobalVars.rewardedAd!.show(
          onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
            GlobalVars.isPause = false;
            GameBar.lives = 3;
            GlobalVars.currentScene = GlobalVars.previousScene;
            GlobalVars.adIsShowed = true;
          });
    }
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
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
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
                      if (GlobalVars.rewardedAd != null && GlobalVars.adIsShowed == false)
                        Divider(
                          color: Colors.grey,
                        ),
                      if (GlobalVars.rewardedAd != null && GlobalVars.adIsShowed == false)
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
            ),
          )
    );
  }
}
