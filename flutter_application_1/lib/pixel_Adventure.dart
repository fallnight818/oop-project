import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter_application_1/levels/level.dart'; // Import your Level class

class PixelAdventure extends FlameGame {
  // 1. Declare the World instance
  @override
  late final World world;

  @override
  Color backgroundColor() => const Color.fromARGB(255, 18, 27, 37);
  late final CameraComponent cam;

  // 2. Initializing World here (or in the constructor)
  // Assuming 'Level' is the component that holds your Tiled map.
  PixelAdventure() : world = Level(); // Create an instance of your Level

  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
    // 2. Load the World (Level)
    add(Level());
    // Wait for all assets to be loaded if needed (e.g., in a separate method)

    // 3. Initialize the CameraComponent
    cam = CameraComponent.withFixedResolution(
      // Pass the initialized 'world' instance to the camera
      world: world,
      width: 640,
      height: 360,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    // 4. Add the CameraComponent and the World component to the Game

    add(world); // Add the World (your Level) first
    add(cam); // Add the Camera

    return super.onLoad();
    // No need for super.onLoad() if the base class's implementation is empty
  }
}
