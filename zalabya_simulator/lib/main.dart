import 'package:flutter/material.dart';
import 'src/main_menu.dart';
import 'src/level_select.dart';
import 'src/gameplay.dart';
import 'src/shop.dart';
import 'src/results.dart';
import 'src/login_screen.dart';
import 'src/pre_game_screen.dart';

void main() {
  runApp(const ZalabyaApp());
}

class ZalabyaApp extends StatefulWidget {
  const ZalabyaApp({super.key});

  @override
  State<ZalabyaApp> createState() => _ZalabyaAppState();
}

class _ZalabyaAppState extends State<ZalabyaApp> {
  String _screen = 'login';
  int _unlockedLevels = 3; // الديمو: أول 3 مراحل فقط
  int _currentLevel = 1;
  int _lastScore = 0;
  String? playerName;
  bool _pendingGame = false;

  // متغيرات تطويرات المحل
  int fryerLevel = 1;
  int maxCustomers = 3;
  bool balahUnlocked = false;
  bool helperHired = false;
  int coins = 500;

  void updateShop({int? fryer, int? maxC, bool? balah, bool? helper, int? money}) {
    setState(() {
      if (fryer != null) fryerLevel = fryer;
      if (maxC != null) maxCustomers = maxC;
      if (balah != null) balahUnlocked = balah;
      if (helper != null) helperHired = helper;
      if (money != null) coins = money;
    });
  }

  void _goToMenu() => setState(() => _screen = 'menu');
  void _goToLevels() => setState(() => _screen = 'levels');
  void _goToShop() => setState(() => _screen = 'shop');
  void _goToLogin() => setState(() => _screen = 'login');
  void _goToPreGame([int? level]) {
    setState(() {
      _currentLevel = level ?? 1;
      _pendingGame = true;
      _screen = 'pre_game';
    });
  }
  void _startGame() {
    setState(() {
      _screen = 'game';
      _pendingGame = false;
    });
  }
  void _showResults(int score) {
    setState(() {
      _lastScore = score;
      _screen = 'results';
    });
  }
  void _nextLevel() {
    if (_currentLevel < _unlockedLevels) {
      _goToPreGame(_currentLevel + 1);
    } else {
      _goToMenu();
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_screen) {
      case 'login':
        return LoginScreen(onLogin: (name) {
          setState(() {
            playerName = name;
            _screen = 'menu';
          });
        });
      case 'menu':
        return MainMenu(
          onStart: () => _goToPreGame(),
          onShop: _goToShop,
          onLevels: _goToLevels,
        );
      case 'levels':
        return LevelSelect(
          unlockedLevels: _unlockedLevels,
          onLevelSelected: (level) => _goToPreGame(level),
        );
      case 'pre_game':
        return PreGameScreen(
          playerName: playerName ?? '',
          onStartGame: _startGame,
          onBack: _goToMenu,
        );
      case 'game':
        return GameplayScreen(
          level: _currentLevel,
          onLevelComplete: _showResults,
          onMenu: _goToMenu,
          fryerLevel: fryerLevel,
          maxCustomers: maxCustomers,
          balahUnlocked: balahUnlocked,
          helperHired: helperHired,
        );
      case 'shop':
        return ShopScreen(
          onBack: _goToMenu,
          fryerLevel: fryerLevel,
          maxCustomers: maxCustomers,
          balahUnlocked: balahUnlocked,
          helperHired: helperHired,
          coins: coins,
          onUpgrade: updateShop,
        );
      case 'results':
        return ResultsScreen(
          score: _lastScore,
          onNext: _nextLevel,
          onMenu: _goToMenu,
        );
      default:
        return const Scaffold(body: Center(child: Text('خطأ!')));
    }
  }
}
