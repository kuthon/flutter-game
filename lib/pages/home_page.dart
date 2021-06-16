import 'package:audioplayers/audioplayers.dart';
import 'package:test_game/game/game_core/game.dart';
import 'package:flutter/material.dart';
import 'package:test_game/utils/global_vars.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  AudioCache cache = AudioCache(prefix: 'assets/audio/');
  AudioPlayer player = AudioPlayer(playerId: 'background');
  late final String url;

  Future<void> loadAudio() async{
    url = (await cache.load('background.mp3')).path;
    await player.setUrl(url);
    await player.setReleaseMode(ReleaseMode.STOP);
  }

  void startAudio() async{
    await player.resume();
    player.onPlayerCompletion.listen((_) {
      player.resume();
    });
  }

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
    player.dispose();
    cache.clearAll();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      player.pause();
    } else {
      player.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: Future(() async {
      await loadAudio();
    }), builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container();
      } else {
        startAudio();
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
