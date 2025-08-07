import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CustomerOrder {
  final int id;
  final int count;
  final String sauce;
  int patience; // seconds left
  CustomerOrder({required this.id, required this.count, required this.sauce, this.patience = 20});
}

class GameplayScreen extends StatefulWidget {
  final int level;
  final void Function(int score) onLevelComplete;
  final VoidCallback onMenu;
  final int fryerLevel;
  final int maxCustomers;
  final bool balahUnlocked;
  final bool helperHired;
  const GameplayScreen({super.key, required this.level, required this.onLevelComplete, required this.onMenu, required this.fryerLevel, required this.maxCustomers, required this.balahUnlocked, required this.helperHired});

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  Widget _sauceIcon(String s) {
    if (s == 'عسل') return const Icon(Icons.water_drop, color: Colors.amber, size: 20);
    if (s == 'شوكولاتة') return const Icon(Icons.cake, color: Colors.brown, size: 20);
    if (s == 'سكر بودرة') return const Icon(Icons.snowing, color: Colors.grey, size: 20);
    return const Icon(Icons.circle, size: 20);
  }

  late List<String> sauces;
  late int maxCustomers;
  int score = 0;
  int served = 0;
  int target = 6;
  int timeLeft = 60;
  int zalabyaReady = 0;
  String? selectedSauce;
  List<CustomerOrder> queue = [];
  Timer? timer;
  Timer? customerTimer;
  int nextId = 1;
  bool frying = false;
  bool mixing = false;
  bool finished = false;

  @override
  void initState() {
    super.initState();
    // إعداد الصوصات
    sauces = ['عسل', 'شوكولاتة', 'سكر بودرة'];
    if (widget.balahUnlocked && !sauces.contains('بلح الشام')) {
      sauces.add('بلح الشام');
    }
    maxCustomers = widget.maxCustomers;
    _startGame();
  }

  void _startGame() {
    score = 0;
    served = 0;
    timeLeft = 60;
    zalabyaReady = 0;
    selectedSauce = null;
    queue.clear();
    nextId = 1;
    frying = false;
    mixing = false;
    finished = false;
    _addCustomer();
    timer?.cancel();
    customerTimer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), _tick);
    customerTimer = Timer.periodic(const Duration(seconds: 4), (_) => _addCustomer());
  }

  void _tick(Timer t) {
    setState(() {
      timeLeft--;
      for (var c in queue) {
        c.patience--;
      }
      queue.removeWhere((c) => c.patience <= 0);
      if (timeLeft <= 0 || served >= target) {
        finished = true;
        timer?.cancel();
        customerTimer?.cancel();
        Future.delayed(const Duration(milliseconds: 700), () {
          widget.onLevelComplete(score);
        });
      }
    });
  }

  void _addCustomer() {
    if (queue.length < maxCustomers && !finished) {
      final rand = Random();
      queue.add(CustomerOrder(
        id: nextId++,
        count: rand.nextInt(3) + 2,
        sauce: sauces[rand.nextInt(sauces.length)],
        patience: 15 + Random().nextInt(10),
      ));
      setState(() {});
    }
  } // maxCustomers الآن ديناميكي من التطويرات

  void _mixDough() {
    if (!mixing && !frying) {
      mixing = true;
      int mixTime = widget.helperHired ? 1 : 2;
      int fryTime;
      if (widget.fryerLevel == 1) {
        fryTime = 3;
      } else if (widget.fryerLevel == 2) {
        fryTime = 2;
      } else {
        fryTime = 1;
      }
      Future.delayed(Duration(seconds: mixTime), () {
        setState(() {
          mixing = false;
          frying = true;
        });
        Future.delayed(Duration(seconds: fryTime), () {
          setState(() {
            frying = false;
            zalabyaReady++;
          });
        });
      });
      setState(() {});
    }
  }

  void _addSauce(String sauce) {
    if (zalabyaReady > 0) {
      setState(() {
        selectedSauce = sauce;
      });
    }
  }

  void _serveCustomer(CustomerOrder order) {
    if (zalabyaReady >= order.count && selectedSauce == order.sauce) {
      setState(() {
        zalabyaReady -= order.count;
        score += order.count * 10;
        served++;
        queue.remove(order);
        selectedSauce = null;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    customerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E9C5),
      appBar: AppBar(
        title: Text('مرحلة ${widget.level}'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(icon: const Icon(Icons.home), onPressed: widget.onMenu),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('الوقت: $timeLeft', style: const TextStyle(fontSize: 20)),
                Text('النقاط: $score', style: const TextStyle(fontSize: 20)),
                Text('تم: $served/$target', style: const TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // قائمة الزبائن
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('الزبائن:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        ...queue.map((c) => Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              color: c.patience < 6
                                  ? Colors.red[100]
                                  : c.patience < 12
                                      ? Colors.yellow[100]
                                      : Colors.white,
                              child: ListTile(
                                leading: Image.asset('assets/zalabya.png', width: 32, height: 32),
                                title: Text('يطلب ${c.count} زلابية مع ${c.sauce}', style: const TextStyle(fontSize: 18)),
                                subtitle: Text('الصبر: ${c.patience} ث'),
                                trailing: ElevatedButton(
                                  onPressed: () => _serveCustomer(c),
                                  child: const Text('تقديم'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: (zalabyaReady >= c.count && selectedSauce == c.sauce)
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  // منطقة التحضير
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('تحضير الزلابية', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: (!mixing && !frying) ? _mixDough : null,
                          child: CircleAvatar(
                            radius: 38,
                            backgroundColor: mixing
                                ? Colors.yellow[200]
                                : frying
                                    ? Colors.orange[300]
                                    : Colors.orange,
                            child: mixing
                                ? const Icon(Icons.sync, size: 40, color: Colors.brown)
                                : frying
                                    ? const Icon(Icons.local_fire_department, size: 40, color: Colors.red)
                                    : Image.asset('assets/zalabya.png', width: 45, height: 45, fit: BoxFit.contain),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          mixing
                              ? 'يتم خلط العجين...'
                              : frying
                                  ? 'يتم القلي...'
                                  : 'اضغط لتحضير الزلابية',
                          style: const TextStyle(fontSize: 16, color: Colors.brown),
                        ),
                        const SizedBox(height: 10),
                        if (zalabyaReady > 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(zalabyaReady, (i) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2),
                                  child: Image.asset('assets/zalabya.png', width: 28, height: 28),
                                )),
                          ),
                        Text('كمية زلابية جاهزة: $zalabyaReady', style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 12),
                        const Text('اختر الصوص:', style: TextStyle(fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: sauces.map((s) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: ChoiceChip(
                                  avatar: _sauceIcon(s),
                                  label: Text(s),
                                  selected: selectedSauce == s,
                                  onSelected: (v) => _addSauce(s),
                                  selectedColor: Colors.brown[200],
                                ),
                              )).toList(),
                        ),
                        const SizedBox(height: 14),
                        Text(selectedSauce != null ? 'الصوص المختار: $selectedSauce' : '', style: const TextStyle(fontSize: 18)),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
