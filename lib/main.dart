import 'package:audio_service/audio_service.dart';
import 'package:test_game/pages/game_over_page.dart';
import 'package:test_game/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_game/services/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      navigatorKey: NavigationService.instance.navigationKey,
      routes: {
        "gameover":(BuildContext context) => GameOverPage(),
      },
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: AudioServiceWidget(
              child: Container(
                  child: HomePage()
              )
          ),
        ),
      ),
    );
  }
}
