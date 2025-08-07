import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final int score;
  final VoidCallback onNext;
  final VoidCallback onMenu;
  const ResultsScreen({super.key, required this.score, required this.onNext, required this.onMenu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E9C5),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFF7E0), Color(0xFFF7E9C5), Color(0xFFFFE0B2)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/zalabya.png', width: 100, height: 100),
              const SizedBox(height: 18),
              Text('النتيجة', style: TextStyle(fontSize: 40, color: Colors.brown[800], fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.orange, blurRadius: 6)])),
              const SizedBox(height: 18),
              Text('ربحت $score جنيه', style: TextStyle(fontSize: 32, color: Colors.orange[900], fontWeight: FontWeight.bold)),
              const SizedBox(height: 38),
              ElevatedButton(
                onPressed: onNext,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text('التالي', style: TextStyle(fontSize: 24)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  elevation: 3,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onMenu,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text('القائمة الرئيسية', style: TextStyle(fontSize: 22)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  elevation: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
