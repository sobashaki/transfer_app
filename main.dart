import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const TransferApp());
}

class TransferApp extends StatelessWidget {
  const TransferApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: TransferPage(),
      ),
    );
  }
}

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSavedPin(); // استرجاع الرقم السري المحفوظ عند بدء التطبيق
  }

  // دالة لجلب الرقم السري المحفوظ مسبقاً
  Future<void> loadSavedPin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      pinController.text = prefs.getString('saved_pin') ?? '';
    });
  }

  // دالة لحفظ الرقم السري
  Future<void> savePin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_pin', pin);
  }

  final List<Map<String, dynamic>> prices = [
    {"base": "1.92", "taxed": "2 ل.س"},
    {"base": "2.88", "taxed": "3 ل.س"},
    {"base": "3.84", "taxed": "4 ل.س"},
    {"base": "4.80", "taxed": "5 ل.س"},
    {"base": "5.76", "taxed": "6 ل.س"},
    {"base": "9.61", "taxed": "10 ل.س"},
    {"base": "20.19", "taxed": "21 ل.س"},
    {"base": "23.07", "taxed": "24 ل.س"},
    {"base": "24.03", "taxed": "25 ل.س"},
    {"base": "25.96", "taxed": "27 ل.س"},
    {"base": "30.76", "taxed": "32 ل.س"},
    {"base": "40.38", "taxed": "42 ل.س"},
    {"base": "45.19", "taxed": "47 ل.س"},
    {"base": "48.07", "taxed": "50 ل.س"},
    {"base": "52.88", "taxed": "55 ل.س"},
    {"base": "62.5", "taxed": "65 ل.س"},
    {"base": "68.26", "taxed": "71 ل.س"},
    {"base": "72.11", "taxed": "75 ل.س"},
    {"base": "77.88", "taxed": "81 ل.س"},
    {"base": "81.73", "taxed": "85 ل.س"},
    {"base": "86.53", "taxed": "90 ل.س"},
    {"base": "96.15", "taxed": "100 ل.س"},
    {"base": "100.96", "taxed": "105 ل.س"},
    {"base": "105.76", "taxed": "110 ل.س"},
    {"base": "115.38", "taxed": "120 ل.س"},
    {"base": "125", "taxed": "130 ل.س"},
    {"base": "130.76", "taxed": "136 ل.س"},
    {"base": "144.23", "taxed": "150 ل.س"},
    {"base": "160.57", "taxed": "167 ل.س"},
    {"base": "163.46", "taxed": "170 ل.س"},
    {"base": "173.07", "taxed": "180 ل.س"},
    {"base": "183.65", "taxed": "191 ل.س"},
    {"base": "192.30", "taxed": "200 ل.س"},
    {"base": "211.53", "taxed": "220 ل.س"},
    {"base": "240.38", "taxed": "250 ل.س"},
    {"base": "288.46", "taxed": "300 ل.س"},
    {"base": "317.30", "taxed": "330 ل.س"},
    {"base": "370.19", "taxed": "385 ل.س"},
    {"base": "432.69", "taxed": "450 ل.س"},
    {"base": "480.76", "taxed": "500 ل.س"},
    {"base": "576.92", "taxed": "600 ل.س"},
    {"base": "625.00", "taxed": "625.00 ل.س"},
    {"base": "650", "taxed": "650 ل.س"},
    {"base": "721.15", "taxed": "721.15 ل.س"},
    {"base": "750", "taxed": "750 ل.س"},
    {"base": "769.23", "taxed": "769.23 ل.س"},
    {"base": "800", "taxed": "800 ل.س"},
    {"base": "951.92", "taxed": "951.92 ل.س"},
    {"base": "990", "taxed": "990 ل.س"},
    {"base": "1057.69", "taxed": "1057.69 ل.س"},
    {"base": "1,100", "taxed": "1,100 ل.س"},
    {"base": "1250.00", "taxed": "1250.00 ل.س"},
    {"base": "1,300", "taxed": "1,300 ل.س"},
    {"base": "1923.07", "taxed": "1923.07 ل.س"},
    {"base": "2,000", "taxed": "2,000 ل.س"},
    {"base": "2115.38", "taxed": "2115.38 ل.س"},
    {"base": "2,200", "taxed": "2,200 ل.س"},
    {"base": "2403.84", "taxed": "2403.84 ل.س"},
    {"base": "2,500", "taxed": "2,500 ل.س"},
    {"base": "3846.15", "taxed": "3846.15 ل.س"},
    {"base": "4,000", "taxed": "4,000 ل.س"}
  ];

  Map<String, dynamic>? selectedAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تطبيق تحويل الرصيد', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(Icons.send_to_mobile, size: 70, color: Colors.teal),
                      const SizedBox(height: 10),
                      const Text(
                        'اختر فئة التعبئة المطلوبة',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'رقم هاتف الزبون',
                          prefixIcon: const Icon(Icons.phone_android, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<Map<String, dynamic>>(
                        decoration: InputDecoration(
                          labelText: 'فئة التعبئة (السعر بعد الضرائب)',
                          prefixIcon: const Icon(Icons.account_balance_wallet, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        isExpanded: true,
                        hint: const Text('اضغط لاختيار الفئة...'),
                        menuMaxHeight: 350,
                        items: prices.map((item) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: item,
                            child: Text(
                              'فئة التعبئة: ${item["base"]}  |  بعد الضرائب: ${item["taxed"]}',
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedAmount = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: pinController,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        onChanged: (value) {
                          savePin(value); // حفظ الرقم تلقائياً بمجرد الكتابة
                        },
                        decoration: InputDecoration(
                          labelText: 'الرقم السري (رمز التحويل - محفوظ تلقائياً)',
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 35),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          if (phoneController.text.isEmpty || selectedAmount == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('الرجاء إدخال رقم الزبون واختيار الفئة!', textAlign: TextAlign.right),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                            return;
                          }

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              title: const Text('تأكيد العملية', textAlign: TextAlign.center, style: TextStyle(color: Colors.teal)),
                              content: Text(
                                'سيتم تحويل فئة التعبئة: ${selectedAmount!["base"]}\nإلى الرقم: ${phoneController.text}\n\nالسعر بعد إضافة الضرائب: ${selectedAmount!["taxed"]}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16, height: 1.5),
                              ),
                              actionsAlignment: MainAxisAlignment.spaceAround,
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('إلغاء', style: TextStyle(color: Colors.grey, fontSize: 16)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('تم إرسال أمر التحويل بنجاح!', textAlign: TextAlign.right),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  },
                                  child: const Text('تأكيد التحويل', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text(
                          'تنفيذ التحويل',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
