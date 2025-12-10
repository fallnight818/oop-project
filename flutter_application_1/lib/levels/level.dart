import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

// Ensure your level class extends World
class Level extends World {
  late final TiledComponent level;

  @override
  Future<void> onLoad() async {
    // Ensure 'level1.tmx' is correctly located in assets/tiles/ in your project
    level = await TiledComponent.load('level_01.tmx', Vector2.all(16));
    add(level);

    return super.onLoad();
  }
}