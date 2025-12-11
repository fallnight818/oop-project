import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter_application_1/actors/player.dart';

// Ensure your level class extends World
class Level extends World {
  late final TiledComponent level;

  @override
  Future<void> onLoad() async {
    // Ensure 'level1.tmx' is correctly located in assets/tiles/ in your project
    level = await TiledComponent.load('level_01.tmx', Vector2.all(16));

    add(level);
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    for (final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          final player = Player(
            character: 'Pink Man',
            position: Vector2(spawnPoint.x, spawnPoint.y),
          );
          add(player);
          break;
        default:
      }
      return super.onLoad();
    }
  }
}