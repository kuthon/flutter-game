import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_game/game/scenes/app_scene.dart';
import 'package:test_game/game/scenes/game_scene.dart';

class GlobalVars {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static AppScene currentScene = GameScene();
  static AppScene previousScene = GameScene();
  static bool isPause = false;
  static RewardedAd? rewardedAd;
  static bool adIsShowed = false;
}