import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class p2hExScreen extends StatefulWidget {
  const p2hExScreen({super.key, required int id});

  @override
  _p2hScreenState createState() => _p2hScreenState();
}

class _p2hScreenState extends State<p2hExScreen> {
  // Data untuk setiap card inspeksi
  List<List<Map<String, String>>> cardItems = [
    [
      {'item': 'Kondisi Underacarriage', 'kbj' : 'A'}, 
      {'item': 'Kerusakan akibat insiden ***)', 'kbj': 'AA'}, 
      {'item': 'Kebocoran oli gear box / oli PTO', 'kbj': 'AA'}, 
      {'item': 'Level oli swing & kebocoran', 'kbj' : 'AA'}, 
      {'item': 'Level oli hydraulic & kebocoran', 'kbj': 'AA'}, 
      {'item': 'Fuel drain / Buangan air dari tanki BBC', 'kbj': 'A'}, 
      {'item': 'BBC minimum 25% dari Cap. Tangki', 'kbj' : 'A'}, 
      {'item': 'Buang air dalam tanki udara', 'kbj' : 'A'}, 
      {'item': 'Kebersihan accessories safety & Alat', 'kbj': 'A'}, 
      {'item': 'Kebocoran2 bila ada (oli, solar, grease)', 'kbj': 'A'}, 
      {'item': 'Back travel (Big Digger)', 'kbj' : 'A'},  
      {'item': 'Lock pin Bucket', 'kbj' : 'AA'},  
      {'item': 'Lock pin tooth & ketajaman kuku', 'kbj' : 'AA'},  
      {'item': 'Kebersihan aki / battery', 'kbj' : 'A'}
    ],
    [
      {'item':'Air conditioner (AC)', 'kbj': 'A'}, 
      {'item':'Fungsi steering / kemudi', 'kbj':'AA'},
      {'item':'Fungsi seat belt / sabuk pengaman', 'kbj':'AA'}, 
      {'item':'Fungsi semua lampu', 'kbj': 'AA'}, 
      {'item':'Fungsi Rotary lamp', 'kbj':'AA'}, 
      {'item':'Fungsi mirror / spion', 'kbj': 'A'},
      {'item':'Fungsi wiper dan air wiper', 'kbj': 'A'},
      {'item':'Fungsi horn / klakson', 'kbj': 'AA'}, 
      {'item':'Fire Extinguiser / APAR', 'kbj': 'AA'},
      {'item':'Fungsi kontrol panel', 'kbj': 'AA'}, 
      {'item':'Fungsi radio komunikasi', 'kbj': 'AA'}, 
      {'item':'Kebersihan ruang kabin', 'kbj': 'A'},
    ],
    [
      {'item':'Air Radiator', 'kbj': 'AA'}, 
      {'item':'Oil Engine / Oli Mesin', 'kbj': 'AA'}, 
    ],
  ];

  // Judul untuk setiap card inspeksi
  List<String> cardTitles = [
    'Pemeriksaan Keliling Unit',
    'Pemeriksaan di dalam kabin',
    'Pemeriksaan di ruang mesin',
  ];

  List<String> importantNotes = [
    '1. Kode "AA" = Unit tidak bisa di operasikan sebelum ada persetujuan dari forman / sipervisor',
    '2. Kode "A" = Kerusakan yang harus diperbaiki dalam waktu 1 x 1 SHIFT',
    '3. P2H harus diserahkan ke forman / Spv. Diawali shift dan dilengkapi tanda tangan',
    '4. Mengoprasikan alat dengan kerusakan kode "AA" akan dikenakan sangsi sesuai dengan peraturan',
    '5. Opr = Operator',
    '6. KBJ = Kode bahaya setelah penilaian resiko'
  ];

  Map<String, bool> itemChecklist = {};

  TextEditingController textEditingController = TextEditingController();

  TextEditingController modelUnitController = TextEditingController();
  TextEditingController nomorUnitController = TextEditingController();
  TextEditingController shiftController = TextEditingController();
  TextEditingController namaDriverController = TextEditingController();
  TextEditingController hmAwalController = TextEditingController();
  TextEditingController hmAkhirController = TextEditingController();

  TextEditingController pitController = TextEditingController();
  TextEditingController disposalController = TextEditingController();
  TextEditingController lokasiController = TextEditingController();
  TextEditingController hmController = TextEditingController();
  TextEditingController fuelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var items in cardItems) {
      for (var item in items) {
        itemChecklist[item['item'] ?? ''] = false;
      }
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    modelUnitController.dispose();
    nomorUnitController.dispose();
    shiftController.dispose();
    namaDriverController.dispose();
    hmAwalController.dispose();
    hmAkhirController.dispose();
    pitController.dispose();
    disposalController.dispose();
    lokasiController.dispose();
    hmController.dispose();
    fuelController.dispose();
    super.dispose();
  }

  void submitData() async {
    // Kumpulkan data checklist
    Map<String, bool> checklistData = {};
    itemChecklist.forEach((key, value) {
      checklistData[key] = value;
    });

    // Kumpulkan data inputan wajib dan tambahan
    Map<String, String> inputData = {
      'modelu': modelUnitController.text.trim(),
      'nou': nomorUnitController.text.trim(),
      'shift': shiftController.text.trim(),
      'namaDriver': namaDriverController.text.trim(),
      'earlyhm': hmAwalController.text.trim(),
      'endhm': hmAkhirController.text.trim(),
      'pit': pitController.text.trim(),
      'disposal': disposalController.text.trim(),
      'notes': textEditingController.text.trim(),
    };

    // Gabungkan semua data
    Map<String, dynamic> requestData = {
      ...checklistData,
      ...inputData,
    };

    // Kirim permintaan HTTP POST
    final response = await http.post(
      Uri.parse('https://your-backend-url.com/api/endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      // Berhasil
      print('Data submitted successfully');
    } else {
      // Gagal
      print('Failed to submit data');
    }

    // Reset input teks setelah submit
    textEditingController.clear();
    modelUnitController.clear();
    nomorUnitController.clear();
    shiftController.clear();
    namaDriverController.clear();
    hmAwalController.clear();
    hmAkhirController.clear();
    pitController.clear();
    disposalController.clear();

    Navigator.pushReplacementNamed(context, '/timesheet');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Excavator'),
        backgroundColor: const Color(0xFF304FFE),
        elevation: 5,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400
        ),
        toolbarHeight: 45,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () {
            _navigateBack(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 69,
              height: 3,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.only(top: 20, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Data Kendaraan',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      controller: shiftController,
                      decoration: const InputDecoration(
                        labelText: 'Shift',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      controller: namaDriverController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Operator',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      controller: hmAwalController,
                      decoration: const InputDecoration(
                        labelText: 'HM Awal',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      controller: hmAkhirController,
                      decoration: const InputDecoration(
                        labelText: 'HM Akhir',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      controller: modelUnitController,
                      decoration: const InputDecoration(
                        labelText: 'Model Unit',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      controller: nomorUnitController,
                      decoration: const InputDecoration(
                        labelText: 'Nomor Unit',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1, color: Colors.grey),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int index = 0; index < cardItems.length; index++)
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            cardTitles[index],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cardItems[index].length,
                          itemBuilder: (context, itemIndex) {
                            final item = cardItems[index][itemIndex];
                            return ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(item['item']!),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(item['kbj']!, textAlign: TextAlign.center),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Checkbox(
                                      value: itemChecklist[item['item']] ?? false,
                                      onChanged: (value) {
                                        setState(() {
                                          itemChecklist[item['item']!] = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TextField(
                            // controller: textEditingController,
                            maxLines: null, // Allow multiple lines
                            decoration: InputDecoration(
                              labelText: 'Masukkan KBJ & Catatan / Temuan',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Catatan Penting',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6, 
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(importantNotes[index]),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(top: 20, left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'LOCATION',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller: shiftController,
                          decoration: const InputDecoration(
                            labelText: 'PIT',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller: namaDriverController,
                          decoration: const InputDecoration(
                            labelText: 'DISPOSAL',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller: hmAwalController,
                          decoration: const InputDecoration(
                            labelText: 'LOKASI',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'PENGISIAN FUEL',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller: hmAkhirController,
                          decoration: const InputDecoration(
                            labelText: 'HM',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller: modelUnitController,
                          decoration: const InputDecoration(
                            labelText: 'FUEL',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _navigateTs(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF304FFE),
                          textStyle: const TextStyle(
                            fontSize: 18,
                          ),
                          foregroundColor: Colors.white,
                          elevation: 5,
                        ),
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateBack(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/p2h');
  }
  void _navigateTs(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/timesheet');
  }
}
