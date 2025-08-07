import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  final VoidCallback onStart;
  final VoidCallback onShop;
  final VoidCallback onLevels;
  const MainMenu({super.key, required this.onStart, required this.onShop, required this.onLevels});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E9C5),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFF7E0), Color(0xFFF7E9C5), Color(0xFFEFD9A0)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/zalabya.png', width: 120, height: 120),
              const SizedBox(height: 18),
              Text('محاكي الزلابية', style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: Colors.brown[800], shadows: [Shadow(color: Colors.orange, blurRadius: 6)])),
              const SizedBox(height: 8),
              Text('عيش تجربة الحلويات المصرية!', style: TextStyle(fontSize: 20, color: Colors.brown[400])),
              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: onStart,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text('ابدأ اللعب', style: TextStyle(fontSize: 26)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  elevation: 4,
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: onLevels,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text('المراحل', style: TextStyle(fontSize: 22)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  elevation: 2,
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: onShop,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text('تطوير المحل', style: TextStyle(fontSize: 22)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
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
