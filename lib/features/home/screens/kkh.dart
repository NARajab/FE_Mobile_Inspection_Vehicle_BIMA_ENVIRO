import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:myapp/features/home/services/kkh_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KkhScreen extends StatefulWidget {
  const KkhScreen({super.key});

  @override
  _KkhScreenState createState() => _KkhScreenState();
}

class _KkhScreenState extends State<KkhScreen> {
  final TextEditingController jamController = TextEditingController();
  final TextEditingController menitController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final KkhServices _kkhServices = KkhServices();

  void clearFields() {
    jamController.clear();
    menitController.clear();
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

  Future<void> submitData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token not found. Please log in again.')),
      );
      return;
    }
    try {
      String totalJamTidur = '${jamController.text} Jam ${menitController.text} Menit';

      await _kkhServices.submitKkhData(
        totalJamTidur,
        _image,
        token
      );

      clearFields();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data submitted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
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
              'Masukkan jumlah jam tidur anda',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: jamController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jam',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: menitController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Menit',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Pilih Gambar'),
            ),
            const SizedBox(height: 10),
            _image == null
                ? const Text('Tidak ada gambar yang dipilih.')
                : SizedBox(
              width: 200,
              height: 200,
              child: Image.file(
                _image!,
                fit: BoxFit.cover,
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
