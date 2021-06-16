import 'package:audio_service/audio_service.dart';
import 'package:test_game/game/game_core/game.dart';
import 'package:test_game/services/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:test_game/utils/global_vars.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    GlobalVars.screenHeight = MediaQuery.of(context).size.height;
    GlobalVars.screenWidth = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    AudioService.stop();
    AudioService.disconnect();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      AudioService.pause();
    } else {
      if (AudioService.connected)
        AudioService.play();
      else
        AudioService.connect()
            .whenComplete(() => AudioService.start(backgroundTaskEntrypoint: backgroundTaskEntrypoint))
            .whenComplete(() => AudioService.play());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: Future(() async {
      await AudioService.start(
          backgroundTaskEntrypoint: backgroundTaskEntrypoint);
    }), builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container();
      } else {
        AudioService.play();
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover)),
          child: Game(),
        );
      }
    });
  }
}
