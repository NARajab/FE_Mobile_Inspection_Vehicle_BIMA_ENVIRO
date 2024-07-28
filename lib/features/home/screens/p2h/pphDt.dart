import 'package:flutter/material.dart';
import '../../services/p2h_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:another_flushbar/flushbar.dart';

class p2hDtScreen extends StatefulWidget {
  final int id;

  const p2hDtScreen({super.key, required this.id});

  @override
  _p2hScreenState createState() => _p2hScreenState();
}

class _p2hScreenState extends State<p2hDtScreen> {
  List<List<Map<String, String>>> cardItems = [
    [
      {'item': 'Ban & Baut roda', 'field': 'bdbr', 'kbj': 'AA'},
      {'item': 'Kerusakan akibat insiden ***)', 'field': 'kai', 'kbj': 'AA'},
      {'item': 'Kebocoran oli transmisi', 'field': 'kot', 'kbj': 'AA'},
      {'item': 'Semua oli Hydraulic Dump', 'field': 'sohd', 'kbj': 'AA'},
      {'item': 'Fuel drain / Buang air dari tanki BBC', 'field': 'fd', 'kbj': 'A'},
      {'item': 'BBC minimum 25% dari Cap. Tangki', 'field': 'bbcmin', 'kbj': 'A'},
      {'item': 'Buang air dalam tanki udara', 'field': 'badtu', 'kbj': 'A'},
      {'item': 'Kebersihan accessories safety', 'field': 'kas', 'kbj': 'A'},
      {'item': 'Tail Gate', 'field': 'tg', 'kbj': 'AA'},
      {'item': 'Alarm mundur', 'field': 'ba', 'kbj': 'AA'},
      {'item': 'Ganjal 2', 'field': 'g2', 'kbj': 'A'},
      {'item': 'Safety cone (simpan diluar kabin) 2', 'field': 'sc', 'kbj': 'AA'},
      {'item': 'Kebersihan aki / battery', 'field': 'ka', 'kbj': 'A'}
    ],
    [
      {'item': 'Air conditioner (AC)', 'field': 'ac', 'kbj': 'A'},
      {'item': 'Fungsi brake / rem', 'field': 'fb', 'kbj': 'AA'},
      {'item': 'Fungsi steering / kemudi', 'field': 'fs', 'kbj': 'AA'},
      {'item': 'Fungsi seat belt / sabuk pengaman', 'field': 'fsb', 'kbj': 'AA'},
      {'item': 'Fungsi semua lampu', 'field': 'fsl', 'kbj': 'AA'},
      {'item': 'Fungsi Rotary lamp', 'field': 'frl', 'kbj': 'AA'},
      {'item': 'Fungsi mirror / spion', 'field': 'fm', 'kbj': 'AA'},
      {'item': 'Fungsi wiper dan air wiper', 'field': 'fwdaw', 'kbj': 'AA'},
      {'item': 'Fungsi horn / klakson', 'field': 'fh', 'kbj': 'AA'},
      {'item': 'Fire Extinguiser / APAR', 'field': 'feapar', 'kbj': 'AA'},
      {'item': 'Fungsi kontrol panel', 'field': 'fkp', 'kbj': 'AA'},
      {'item': 'Fungsi tuas dump', 'field': 'ftd', 'kbj': 'A'},
      {'item': 'Fungsi radio komunikasi', 'field': 'frk', 'kbj': 'AA'},
      {'item': 'Kebersihan ruang kabin', 'field': 'krk', 'kbj': 'A'},
    ],
    [
      {'item': 'Air Radiator', 'field': 'ar', 'kbj': 'AA'},
      {'item': 'Oil Engine / Oli Mesin', 'field': 'oe', 'kbj': 'AA'},
    ],
  ];

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
  TextEditingController kmAwalController = TextEditingController();
  TextEditingController kmAkhirController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var items in cardItems) {
      for (var item in items) {
        itemChecklist[item['field'] ?? ''] = false;
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
    kmAwalController.dispose();
    kmAkhirController.dispose();
    super.dispose();
  }

  Future<void> submitData() async {
    Map<String, int> checklistData = {};
    itemChecklist.forEach((key, value) {
      checklistData[key] = value ? 1 : 0;
    });

    Map<String, String> inputData = {
      'modelu': modelUnitController.text.trim(),
      'nou': nomorUnitController.text.trim(),
      'shift': shiftController.text.trim(),
      'namaDriver': namaDriverController.text.trim(),
      'earlyhm': hmAwalController.text.trim(),
      'endhm': hmAkhirController.text.trim(),
      'kmAwal': kmAwalController.text.trim(),
      'kmAkhir': kmAkhirController.text.trim(),
      'notes': textEditingController.text.trim(),
    };

    Map<String, dynamic> requestData = {
      ...checklistData,
      ...inputData,
      'idVehicle': widget.id
    };

    print('Request Data: $requestData'); // Debug statement

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('Token: $token'); // Debug statement

    if (token != null) {
      FormServices formServices = FormServices();
      try {
        await formServices.submitP2hDt(requestData, token);
        Flushbar(
          title: 'Success',
          message: 'Data submitted successfully!',
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
        ).show(context);

        // Clear the form after successful submission
        textEditingController.clear();
        modelUnitController.clear();
        nomorUnitController.clear();
        shiftController.clear();
        namaDriverController.clear();
        hmAwalController.clear();
        hmAkhirController.clear();
        kmAwalController.clear();
        kmAkhirController.clear();
        itemChecklist.updateAll((key, value) => false);

      } catch (error) {
        print('Submission Error: $error'); // Debug statement
        Flushbar(
          title: 'Error',
          message: 'Failed to submit data: $error',
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ).show(context);
      }
    } else {
      Flushbar(
        title: 'Error',
        message: 'Token not found',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Dump Truck'),
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
              margin: const EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text('ID Kendaraan: ${widget.id}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: modelUnitController,
                      decoration: const InputDecoration(
                        labelText: 'Model Unit',
                      ),
                    ),
                    TextFormField(
                      controller: nomorUnitController,
                      decoration: const InputDecoration(
                        labelText: 'Nomor Unit',
                      ),
                    ),
                    TextFormField(
                      controller: shiftController,
                      decoration: const InputDecoration(
                        labelText: 'Shift',
                      ),
                    ),
                    TextFormField(
                      controller: namaDriverController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Driver',
                      ),
                    ),
                    TextFormField(
                      controller: hmAwalController,
                      decoration: const InputDecoration(
                        labelText: 'HM Awal',
                      ),
                    ),
                    TextFormField(
                      controller: hmAkhirController,
                      decoration: const InputDecoration(
                        labelText: 'HM Akhir',
                      ),
                    ),
                    TextFormField(
                      controller: kmAwalController,
                      decoration: const InputDecoration(
                        labelText: 'KM Awal',
                      ),
                    ),
                    TextFormField(
                      controller: kmAkhirController,
                      decoration: const InputDecoration(
                        labelText: 'KM Akhir',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cardItems.length,
              itemBuilder: (context, index) {
                return buildChecklistCard(cardTitles[index], cardItems[index]);
              },
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: importantNotes.map((note) {
                  return Text(
                    note,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  );
                }).toList(),
              ),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Catatan Penting:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: textEditingController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan catatan penting...',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ElevatedButton(
                onPressed: submitData,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChecklistCard(String title, List<Map<String, String>> items) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                String field = items[index]['field'] ?? '';
                String kbj = items[index]['kbj'] ?? '';
                return ListTile(
                  leading: Container(
                    width: 30, // adjust width as needed
                    alignment: Alignment.center,
                    child: Text(
                      kbj,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  title: Text(items[index]['item'] ?? ''),
                  trailing: Checkbox(
                    value: itemChecklist[field] ?? false,
                    onChanged: (bool? value) {
                      setState(() {
                        itemChecklist[field] = value ?? false;
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }





  void _navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
