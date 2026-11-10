import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayerComponent extends PositionComponent {
  final Paint _paint = Paint()..color = const Color(0xFF00E5FF);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // draw simple retro spaceship
    final path = Path()
      ..moveTo(size.x / 2, 0)   // nose tip
      ..lineTo(size.x, size.y)  // right wing
      ..lineTo(0, size.y)       // left wing
      ..close();

      canvas.drawPath(path, _paint);
  }
}