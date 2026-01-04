import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import '../components/player.dart';
import '../components/collision_block.dart'; // Import this

class Level extends World {
  late TiledComponent level;
  List<CollisionBlock> collisionBlocks = []; // Store floor blocks here

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('Level-01.tmx', Vector2.all(16));
    add(level);

    // 1. Extract Collision Blocks from Tiled
    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        final block = CollisionBlock(
          position: Vector2(collision.x, collision.y),
          size: Vector2(collision.width, collision.height),
          isPlatform: collision.class_ == 'Platform', 
        );
        collisionBlocks.add(block);
        add(block); // Add to game so player can "see" it
      }
    }

    // 2. Spawn Player and GIVE them the collision list
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        if (spawnPoint.name == 'player') {
          final player = Player(
            position: Vector2(spawnPoint.x, spawnPoint.y),
          );
          
          // IMPORTANT: Pass the floor data to the player
          player.collisionBlocks = collisionBlocks; 
          
          add(player);
        }
      }
    }

    return super.onLoad();
  }
}