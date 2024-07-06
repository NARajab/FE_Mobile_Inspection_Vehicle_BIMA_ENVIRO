import 'package:flutter/material.dart';

class KkhScreen extends StatefulWidget {
  const KkhScreen({super.key});

  @override
  _KkhScreenState createState() => _KkhScreenState();
}

class _KkhScreenState extends State<KkhScreen> {
  // Controllers for input fields
  final TextEditingController jamPulangKerjaController = TextEditingController();
  final TextEditingController jamTidurController = TextEditingController();
  final TextEditingController jamBangunTidurController = TextEditingController();
  final TextEditingController jamBerangkatKerjaController = TextEditingController();
  final TextEditingController keluhanFisikMentalController = TextEditingController();

  // Function to clear all input fields
  void clearFields() {
    jamPulangKerjaController.clear();
    jamTidurController.clear();
    jamBangunTidurController.clear();
    jamBerangkatKerjaController.clear();
    keluhanFisikMentalController.clear();
  }

  // Function to submit data
  void submitData() {
    final String jamPulangKerja = jamPulangKerjaController.text;
    final String jamTidur = jamTidurController.text;
    final String jamBangunTidur = jamBangunTidurController.text;
    final String jamBerangkatKerja = jamBerangkatKerjaController.text;
    final String keluhanFisikMental = keluhanFisikMentalController.text;

    // Here you can add the logic to save the data
    // For example, you can send it to a backend or save it locally

    // Clear the input fields after submission
    clearFields();

    // Show a snackbar or dialog to indicate success
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data submitted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KKH'),
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
            Navigator.pop(context);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: jamPulangKerjaController,
              decoration: const InputDecoration(
                labelText: 'Jam Pulang Kerja',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: jamTidurController,
              decoration: const InputDecoration(
                labelText: 'Jam Tidur',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: jamBangunTidurController,
              decoration: const InputDecoration(
                labelText: 'Jam Bangun Tidur',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: jamBerangkatKerjaController,
              decoration: const InputDecoration(
                labelText: 'Jam Berangkat Kerja',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: keluhanFisikMentalController,
              decoration: const InputDecoration(
                labelText: 'Keluhan Fisik / Mental',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitData,
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
    );
  }
}
