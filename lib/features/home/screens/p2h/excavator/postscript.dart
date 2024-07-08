import 'package:flutter/material.dart';

class PostscriptScreen extends StatelessWidget {
  final TextEditingController postscriptController = TextEditingController();
  final TextEditingController stopOperasiJamController = TextEditingController();

  PostscriptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Postscript Screen'),
        backgroundColor: const Color(0xFF304FFE),
        elevation: 5,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
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
            const Text(
              'Catatan Lain (Diisi Keterangan Tambahan Terkait Dengan Aktifitas Unik)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: postscriptController,
              decoration: const InputDecoration(
                labelText: 'Tambahkan keterangan tambahan...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 20),
            const Text(
              'Stop Operasi Jam',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                _selectTime(context, stopOperasiJamController);
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: stopOperasiJamController,
                  decoration: const InputDecoration(
                    labelText: 'Jam Stop Operasi',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement submit logic here
                String postscript = postscriptController.text;
                // Process or submit the postscript data as needed
                print('Submitted postscript: $postscript');
                // Example: Navigator.pop(context); // Navigate back or perform action
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
    );
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text = picked.format(context);
    }
  }
}
