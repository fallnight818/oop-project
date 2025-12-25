import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'pixel_adventure.dart';

void main() {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Create an instance of your game
  final game = PixelAdventure();
  
  // Run the app using GameWidget
  runApp(
    GameWidget(game: game),
  );
}