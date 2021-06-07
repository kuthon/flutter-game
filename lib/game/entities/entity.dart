import 'package:flutter/cupertino.dart';

abstract class Entity {
  double x = 0;
  double y = 0;
  final String spriteName;
  bool visible = true;
  List sprites = [];


  Entity(this.spriteName) {
      sprites.add(Image.asset("assets/$spriteName.png"));
  }
  void _animate() {

  }

  void update() {
    _animate();
    move();
  }

  void move();

  Widget build();
}