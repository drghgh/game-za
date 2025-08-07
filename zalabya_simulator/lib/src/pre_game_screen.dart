import 'package:flutter/material.dart';

class PreGameScreen extends StatelessWidget {
  final String playerName;
  final VoidCallback onStartGame;
  final VoidCallback onBack;
  const PreGameScreen({super.key, required this.playerName, required this.onStartGame, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E9C5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/zalabya.png', width: 100, height: 100),
              const SizedBox(height: 20),
              Text('جاهز يا $playerName؟', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.brown)),
              const SizedBox(height: 18),
              const Text('اضغط "ابدأ اللعب" للانطلاق في مغامرة الزلابية!', style: TextStyle(fontSize: 18, color: Colors.brown)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: onStartGame,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                  child: Text('ابدأ اللعب', style: TextStyle(fontSize: 22)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  elevation: 2,
                ),
              ),
              const SizedBox(height: 18),
              TextButton(
                onPressed: onBack,
                child: const Text('رجوع', style: TextStyle(fontSize: 18, color: Colors.brown)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
