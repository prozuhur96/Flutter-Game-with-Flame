import 'package:flame/collisions.dart'; //
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../space_game.dart';
import 'enemy.dart';

class LaserComponent extends PositionComponent with HasGameRef<SpaceGame>, CollisionCallbacks {
  final Paint _paint = Paint()..color = const Color(0xFFFFD700);
  final double speed = 600.0;

  LaserComponent({required Vector2 position}) {
    this.position = position;
    size = Vector2(4, 16);
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox()); // add hitbox tracking
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y -= speed * dt;

    if (position.y < 0) {
      removeFromParent();
    }
  }

  // handle what happens when laser touches an enemy
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is EnemyComponent) {
      removeFromParent(); // destroy the laser
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paint);
  }
}