import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final void Function(String playerName) onLogin;
  const LoginScreen({super.key, required this.onLogin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _error;

  void _submit() {
    if (_controller.text.trim().isEmpty) {
      setState(() => _error = 'الرجاء إدخال اسم اللاعب');
    } else {
      widget.onLogin(_controller.text.trim());
    }
  }

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
              Image.asset('assets/zalabya.png', width: 120, height: 120),
              const SizedBox(height: 24),
              const Text('مرحباً بك في محاكي الزلابية!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.brown)),
              const SizedBox(height: 18),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'اسم اللاعب',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  errorText: _error,
                  prefixIcon: const Icon(Icons.person),
                ),
                textAlign: TextAlign.right,
                onSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: _submit,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text('دخول', style: TextStyle(fontSize: 22)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
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
