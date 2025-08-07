import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  final VoidCallback onBack;
  final int fryerLevel;
  final int maxCustomers;
  final bool balahUnlocked;
  final bool helperHired;
  final int coins;
  final void Function({int? fryer, int? maxC, bool? balah, bool? helper, int? money}) onUpgrade;
  const ShopScreen({super.key, required this.onBack, required this.fryerLevel, required this.maxCustomers, required this.balahUnlocked, required this.helperHired, required this.coins, required this.onUpgrade});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late int fryerLevel;
  late int maxCustomers;
  late bool balahUnlocked;
  late bool helperHired;
  late int coins;

  @override
  void initState() {
    super.initState();
    fryerLevel = widget.fryerLevel;
    maxCustomers = widget.maxCustomers;
    balahUnlocked = widget.balahUnlocked;
    helperHired = widget.helperHired;
    coins = widget.coins;
  }

  void _buyFryer() {
    if (coins >= 200 && fryerLevel < 3) {
      setState(() {
        coins -= 200;
        fryerLevel++;
      });
      widget.onUpgrade(fryer: fryerLevel, money: coins);
    }
  }

  void _buyCustomers() {
    if (coins >= 150 && maxCustomers < 5) {
      setState(() {
        coins -= 150;
        maxCustomers++;
      });
      widget.onUpgrade(maxC: maxCustomers, money: coins);
    }
  }

  void _unlockBalah() {
    if (coins >= 300 && !balahUnlocked) {
      setState(() {
        coins -= 300;
        balahUnlocked = true;
      });
      widget.onUpgrade(balah: true, money: coins);
    }
  }

  void _hireHelper() {
    if (coins >= 250 && !helperHired) {
      setState(() {
        coins -= 250;
        helperHired = true;
      });
      widget.onUpgrade(helper: true, money: coins);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E9C5),
      appBar: AppBar(
        title: const Text('تطوير المحل', style: TextStyle(fontSize: 26)),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0FFE0), Color(0xFFF7E9C5), Color(0xFFD0F7BA)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.monetization_on, color: Colors.amber, size: 30),
                    const SizedBox(width: 6),
                    Text('رصيدك: $coins جنيه', style: const TextStyle(fontSize: 22, color: Colors.brown)),
                  ],
                ),
                const SizedBox(height: 20),
                _shopCard(
                  title: 'تطوير المقلاة',
                  desc: fryerLevel == 1 ? 'تصبح أسرع ×2' : 'تصبح أسرع ×3',
                  price: 200,
                  bought: fryerLevel >= 3,
                  onBuy: _buyFryer,
                  icon: Icons.local_fire_department,
                  level: fryerLevel,
                  maxLevel: 3,
                ),
                _shopCard(
                  title: 'زيادة الزبائن',
                  desc: 'زيادة عدد الزبائن في الانتظار',
                  price: 150,
                  bought: maxCustomers >= 5,
                  onBuy: _buyCustomers,
                  icon: Icons.people,
                  level: maxCustomers,
                  maxLevel: 5,
                ),
                _shopCard(
                  title: 'فتح بلح الشام',
                  desc: 'إضافة وصفة بلح الشام',
                  price: 300,
                  bought: balahUnlocked,
                  onBuy: _unlockBalah,
                  icon: Icons.cake,
                ),
                _shopCard(
                  title: 'توظيف مساعد',
                  desc: 'يقلل وقت التحضير',
                  price: 250,
                  bought: helperHired,
                  onBuy: _hireHelper,
                  icon: Icons.person,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: widget.onBack,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text('رجوع', style: TextStyle(fontSize: 22)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    elevation: 2,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _shopCard({
    required String title,
    required String desc,
    required int price,
    required bool bought,
    required VoidCallback onBuy,
    required IconData icon,
    int? level,
    int? maxLevel,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 38, color: Colors.green[700]),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(desc, style: const TextStyle(fontSize: 16, color: Colors.brown)),
                  if (level != null && maxLevel != null)
                    Text('المستوى: $level/$maxLevel', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
            bought
                ? const Icon(Icons.check_circle, color: Colors.green, size: 30)
                : ElevatedButton(
                    onPressed: onBuy,
                    child: Text('شراء ($price)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
