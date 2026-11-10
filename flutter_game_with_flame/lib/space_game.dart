import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/player.dart';
import 'components/laser.dart';
import 'components/enemy.dart';

class SpaceGame extends FlameGame with PanDetector , HasCollisionDetection {
  late PlayerComponent player;

  double _shootTimer = 0.0;
  final double _shootInterval = 0.35;  // shoots every 0.35 seconds

  double _enemyTimer = 0.0;
  final double _enemyInterval = 1.0;  // spawn a new enemy every 1.0 second
  final Random _random = Random();

  @override
  Color backgroundColor() => Color(0xFF0B0E14);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // spawn player near bottom center
    player = PlayerComponent()
      ..position = Vector2(size.x / 2, size.y - 100)
      ..size = Vector2(50, 50)
      ..anchor = Anchor.center;

    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // auto-fire player lasers
    _shootTimer += dt;
    if (_shootTimer >= _shootInterval) {
      _shootTimer = 0;
      // spawn laser just above the player's nose tip
      add(LaserComponent(position: player.position.clone() + Vector2(0, -30)));
    }

    // spawn enemies periodically at a random X coord across the screen top
    _enemyTimer += dt;
    if (_enemyTimer >= _enemyInterval) {
      _enemyTimer = 0;
      final double randomX = _random.nextDouble() * (size.x - 60) + 30;
      add(EnemyComponent(position: Vector2(randomX, -50)));
    }
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.position += info.delta.global;

    // keep player within screen bounds
    player.position.x = player.position.x.clamp(25, size.x - 25);
    player.position.y = player.position.y.clamp(25, size.y - 25);
  }
}