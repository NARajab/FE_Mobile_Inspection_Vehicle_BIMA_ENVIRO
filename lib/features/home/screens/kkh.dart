import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class KkhScreen extends StatefulWidget {
  const KkhScreen({super.key});

  @override
  _KkhScreenState createState() => _KkhScreenState();
}

class _KkhScreenState extends State<KkhScreen> {
  final TextEditingController jamTidurController = TextEditingController();
  final TextEditingController jamBangunTidurController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  void clearFields() {
    jamTidurController.clear();
    jamBangunTidurController.clear();
    setState(() {
      _image = null;
    });
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void submitData() {
    // final String jamTidur = jamTidurController.text;
    // final String jamBangunTidur = jamBangunTidurController.text;

    // Here you can add the logic to save the data
    // For example, you can send it to a backend or save it locally

    clearFields();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data submitted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form KKH'),
        backgroundColor: const Color(0xFF304FFE),
        elevation: 5,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
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
            const Text(
              'Masukkan jam tidur dan bangun tidur anda',
              style: TextStyle(
                  fontSize: 16
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: jamTidurController,
              decoration: const InputDecoration(
                labelText: 'Jam Tidur',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: jamBangunTidurController,
              decoration: const InputDecoration(
                labelText: 'Jam Bangun Tidur',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Pilih Gambar'),
            ),
            const SizedBox(height: 10),
            _image == null
                ? const Text('Tidak ada gambar yang dipilih.')
                : Container(
              width: 200, // Set the desired width
              height: 200, // Set the desired height
              child: Image.file(
                _image!,
                fit: BoxFit.cover, // Ensures the image covers the container
              ),
            ),
            const SizedBox(height: 10),
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
