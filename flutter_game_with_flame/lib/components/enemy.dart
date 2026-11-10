import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_with_flame/space_game.dart';
import 'package:flutter_game_with_flame/components/laser.dart';

class EnemyComponent extends PositionComponent with HasGameRef<SpaceGame>, CollisionCallbacks {
  final Paint _paint = Paint()..color = const Color(0xFFFF5252);
  final double speed = 200.0;  //pixels per second downward

  EnemyComponent({required Vector2 position}) {
    this.position = position;
    size = Vector2(40, 40);
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    //  move straight down towards the player
    position.y += speed * dt;

    // remove enemy if it passes the bottom of the screen to save memory
    if (position.y > game.size.y + 50) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is LaserComponent) {
      removeFromParent(); // Destroy the enemy
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // draw a simple red square for the enemy ship
    canvas.drawRect(size.toRect(), _paint);
  }
}