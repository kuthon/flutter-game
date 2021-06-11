import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:test_game/game/game_core/game.dart';
import 'package:test_game/game/game_core/main_loop.dart';
import 'package:test_game/services/audio_service.dart';
import 'package:test_game/utils/global_vars.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void didChangeDependencies() {
    GlobalVars.screenHeight = MediaQuery.of(context).size.height;
    GlobalVars.screenWidth = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    AudioService.start(backgroundTaskEntrypoint: backgroundTaskEntrypoint)
        .whenComplete(() => AudioService.play());
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    AudioService.disconnect();
    stopLoop();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('AppLifecycleState: $state');
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)
              ),
      child: Game(),

    );
  }
}
