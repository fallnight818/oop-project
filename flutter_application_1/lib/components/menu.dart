import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import '../pixel_Adventure.dart'; // Ensure this points to your Flame game class

// ---------------------------------------------------------------------------
// PIXEL ADVENTURE - UI ENTRY POINT
// ---------------------------------------------------------------------------

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock to landscape for desktop/mobile feel
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainMenu(),
  ));
}

// ---------------------------------------------------------------------------
// 1. MAIN MENU SCREEN
// ---------------------------------------------------------------------------

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const PixelTiledBackground(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const PixelTitle(text: 'Pixel Adventure'),
                const SizedBox(height: 40),
                PixelButton(
                  label: 'START',
                  onPressed: () {
                    // Start directly with Level 1
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const GamePage(levelName: 'Level-01.tmx'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                PixelButton(
                  label: 'EXIT',
                  color: const Color(0xFFE86138),
                  onPressed: () => SystemNavigator.pop(),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 30,
            left: 30,
            child: SettingButton(),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. LEVEL SELECT SCREEN
// ---------------------------------------------------------------------------

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  final List<Map<String, dynamic>> levels = const [
    {'name': 'Level 1', 'file': 'Level-01.tmx', 'locked': false},
    {'name': 'Level 2', 'file': 'Level-02.tmx', 'locked': false},
    {'name': 'Level 3', 'file': 'Level-03.tmx', 'locked': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const PixelTiledBackground(),
          const Positioned(
            top: 30,
            left: 30,
            child: PixelBackButton(),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const PixelTitle(text: 'SELECT LEVEL', fontSize: 40),
                const SizedBox(height: 40),
                SizedBox(
                  width: 600,
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: levels.map((lvl) {
                      return PixelLevelCard(
                        label: lvl['name'],
                        isLocked: lvl['locked'],
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => GamePage(levelName: lvl['file']),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. GAME PAGE WRAPPER
// ---------------------------------------------------------------------------

class GamePage extends StatefulWidget {
  final String levelName;
  const GamePage({super.key, required this.levelName});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late PixelAdventure _game;

  @override
  void initState() {
    super.initState();
    // Logic: Pass levelName to your engine
    // Assuming your PixelAdventure constructor accepts levelName
    _game = PixelAdventure(); 
  }

  // Helper method to simulate Game Logic callback (Win/Loss)
  // In your real Flame game, call these via overlay manually or context
  void onGameOver(bool hasWon) {
    if (hasWon) {
      // Logic for next level or Win screen
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LevelSelectScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: _game),
          Positioned(
            top: 20,
            right: 20,
            child: PixelIconButton(
              assetPath: 'assets/images/Menu/Buttons/Back.png',
              onPressed: () {
                _game.onDetach();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// REUSABLE UI COMPONENTS (PIXEL ART STYLE)
// ---------------------------------------------------------------------------

class PixelTiledBackground extends StatelessWidget {
  const PixelTiledBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF211F30), // Fallback base color
        image: DecorationImage(
          image: AssetImage('assets/images/Menu/background.png'),
          repeat: ImageRepeat.repeat,
          alignment: Alignment.topLeft,
          fit: BoxFit.none,
          filterQuality: FilterQuality.none, // Maintains pixel crispness
        ),
      ),
    );
  }
}

class PixelTitle extends StatelessWidget {
  final String text;
  final double fontSize;

  const PixelTitle({super.key, required this.text, this.fontSize = 60});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: 4,
        shadows: const [
          Shadow(offset: Offset(4, 4), color: Color(0xFFE86138)),
        ],
      ),
    );
  }
}

class PixelButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const PixelButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = const Color(0xFF63C64D),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: const BeveledRectangleBorder(), // Provides sharp pixel edges
          side: const BorderSide(color: Colors.white, width: 2),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class PixelLevelCard extends StatelessWidget {
  final String label;
  final bool isLocked;
  final VoidCallback onPressed;

  const PixelLevelCard({
    super.key,
    required this.label,
    required this.isLocked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked ? null : onPressed,
      child: Opacity(
        opacity: isLocked ? 0.5 : 1.0,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: isLocked ? Colors.grey[900] : const Color(0xFF323C39),
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isLocked ? Icons.lock : Icons.play_arrow,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PixelIconButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;

  const PixelIconButton({super.key, required this.assetPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Transform.scale(
        scale: 1.5,
        child: Image.asset(
          assetPath,
          width: 32,
          height: 32,
          filterQuality: FilterQuality.none,
        ),
      ),
    );
  }
}

class PixelBackButton extends StatelessWidget {
  const PixelBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PixelIconButton(
      assetPath: 'assets/images/Menu/Buttons/Back.png',
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

// ---------------------------------------------------------------------------
// SETTING BUTTON (SOUND LOGIC)
// ---------------------------------------------------------------------------

class SettingButton extends StatefulWidget {
  const SettingButton({super.key});

  @override
  State<SettingButton> createState() => _SettingButtonState();
}

class _SettingButtonState extends State<SettingButton> {
  bool isSoundOn = true;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await FlameAudio.bgm.initialize();
      await FlameAudio.bgm.play('menu_audio.wav', volume: 0.25);
    } catch (e) {
      debugPrint("Audio init error: $e");
    }
  }

  void _toggleSound() {
    setState(() => isSoundOn = !isSoundOn);
    if (isSoundOn) {
      FlameAudio.bgm.resume();
    } else {
      FlameAudio.bgm.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSound,
      child: Transform.scale(
        scale: 2.5,
        child: Image.asset(
          isSoundOn
              ? 'assets/images/Menu/Buttons/SoundOn.png'
              : 'assets/images/Menu/Buttons/no_Sound.png',
          width: 48,
          height: 48,
          filterQuality: FilterQuality.none,
          errorBuilder: (ctx, _, __) => Icon(
            isSoundOn ? Icons.volume_up : Icons.volume_off,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}