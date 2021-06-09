import 'package:flutter/cupertino.dart';

abstract class Entity {
  ///current coordinate
  double x = 0;
  double y = 0;

  ///current movement on Touch Screen
  double dx = 0;
  double dy = 0;

  ///Size of Entity
  double width;
  double height;

  final String spriteName;

  bool visible = true;

  List sprites = [];
  int currentSprite = 0;


  Entity({required this.spriteName, required this.width,required this.height, required int numberOfSprites}) {
    for (int i = 1; i < numberOfSprites + 1; i++)
      sprites.add(Image.asset("assets/images/$spriteName$i.png", fit: BoxFit.fill,));
  }

  void animate() {

  }

  void update() {
    animate();
    move();
  }

  void move() {

  }

  Widget build();
}