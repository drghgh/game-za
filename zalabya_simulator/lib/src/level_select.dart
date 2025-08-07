import 'package:flutter/material.dart';

class LevelSelect extends StatelessWidget {
  final int unlockedLevels;
  final void Function(int) onLevelSelected;
  const LevelSelect({super.key, required this.unlockedLevels, required this.onLevelSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E9C5),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/zalabya.png', width: 32, height: 32),
            const SizedBox(width: 8),
            const Text('اختر المرحلة', style: TextStyle(fontSize: 26)),
          ],
        ),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFF7E0), Color(0xFFF7E9C5), Color(0xFFEFD9A0)],
          ),
        ),
        child: Center(
          child: Wrap(
            spacing: 28,
            runSpacing: 28,
            children: List.generate(6, (i) {
              final unlocked = i < unlockedLevels;
              return Column(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: unlocked ? Colors.orange : Colors.grey[400],
                    child: unlocked
                        ? Text('${i+1}', style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold))
                        : const Icon(Icons.lock, color: Colors.white, size: 32),
                  ),
                  const SizedBox(height: 6),
                  Text(unlocked ? 'مرحلة ${i+1}' : 'مقفولة', style: const TextStyle(fontSize: 18)),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
