import 'package:flutter/material.dart';
import 'package:test_game/game/game_core/game.dart';
import 'package:test_game/utils/global_vars.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  void didChangeDependencies() {
    GlobalVars.screenHeight = MediaQuery.of(context).size.height;
    GlobalVars.screenWidth = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Game(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover
          )
        ),
    );
  }
}
