import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'pixel_adventure.dart';
import 'package:flutter_application_2/components/menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainMenu(),
  ));
}