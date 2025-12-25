import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixel_adventure/components/level.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

void main() {
  // Use FlameTester to properly handle the game lifecycle for testing
  final gameTester = FlameTester(PixelAdventure.new);

  group('PixelAdventure', () {
    gameTester.test('loads components', (game) async {
      // The game has been loaded and the onLoad method has been called.
      // Now, we can check if the player and level are present.
      expect(game.children.whereType<Player>().length, 1);
      expect(game.children.whereType<Level>().length, 1);
    });

    // You can add more tests here
  });
}