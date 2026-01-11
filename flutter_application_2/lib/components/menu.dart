import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pixel_adventure.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image if available; fallback to simple color
          Image.asset(
            'assets/images/Menu/background.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.blueGrey[900]),
          ),
          Container(color: Colors.black.withOpacity(0.45)),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pixel Adventure',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 6, color: Colors.black54, offset: Offset(2,2))],
                  ),
                ),
                SizedBox(height: 32),
                _MenuButton(
                  label: 'Start',
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => GamePage())),
                ),
                SizedBox(height: 12),
                _MenuButton(
                  label: 'Exit',
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _MenuButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final PixelAdventure _game;

  @override
  void initState() {
    super.initState();
    _game = PixelAdventure();
  }

  @override
  void dispose() {
    _game.onDetach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: _game),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onPressed: () {
                    // Detach and return to menu
                    try {
                      _game.onDetach();
                    } catch (_) {}
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.exit_to_app),
                  label: Text('Exit'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
