import 'dart:async';
import 'package:flame/collisions.dart'; // Required for RectangleHitbox
import 'package:flame/components.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class Spikes extends SpriteAnimationComponent with HasGameRef<PixelAdventure> {
  Spikes({super.position, super.size});

  @override
  FutureOr<void> onLoad() {
    // 1. Add the Hitbox so the player can touch it
    add(RectangleHitbox(
      position: Vector2(0, 8), // Start halfway down (optional, depends on your art)
      size: Vector2(16, 8),    // Make the hitbox cover only the sharp part
    ));

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Traps/Spikes/Idle.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.1,
        textureSize: Vector2.all(16),
      ),
    );
    return super.onLoad();
  }
}