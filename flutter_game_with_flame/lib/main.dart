import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'space_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // create game instance
  final game = SpaceGame();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(game: game),
      ),
    ),
  );
}
