import 'package:flutter/material.dart';

class HistoryKkhScreen extends StatelessWidget {
  final String day;
  final String date;
  final String jamPulangKerja;
  final String jamTidur;
  final String jamBangunTidur;
  final String jamBerangkat;
  final String keluhan;
  final String role;

  const HistoryKkhScreen({
    super.key,
    required this.day,
    required this.date,
    required this.jamPulangKerja,
    required this.jamTidur,
    required this.jamBangunTidur,
    required this.jamBerangkat,
    required this.keluhan,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History KKH'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHistoryCard(
                context,
                day: day,
                date: date,
                jamPulangKerja: jamPulangKerja,
                jamTidur: jamTidur,
                jamBangunTidur: jamBangunTidur,
                jamBerangkat: jamBerangkat,
                keluhan: keluhan,
                role: role,
              ),
              // Add more _buildHistoryCard widgets here as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(
      BuildContext context, {
        required String day,
        required String date,
        required String jamPulangKerja,
        required String jamTidur,
        required String jamBangunTidur,
        required String jamBerangkat,
        required String keluhan,
        required String role,
      }) {
    final totalTidur = _calculateTotalTidur(jamTidur, jamBangunTidur);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$day, $date',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Jam Pulang Kerja:', jamPulangKerja),
            const SizedBox(height: 8),
            _buildDetailRow('Jam Tidur:', jamTidur),
            _buildDetailRow('Jam Bangun Tidur:', jamBangunTidur),
            _buildDetailRow('Total Tidur:', totalTidur),
            const SizedBox(height: 8),
            _buildDetailRow('Jam Berangkat:', jamBerangkat),
            const SizedBox(height: 8),
            _buildDetailRow('Keluhan Fisik / Mental:', keluhan),
            if (role == 'foreman') // Add button if the role is foreman
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        // function submit
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF304FFE),
                        textStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        foregroundColor: Colors.white,
                        elevation: 5,
                      ),
                      child: const Text('Validation'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _calculateTotalTidur(String jamTidur, String jamBangunTidur) {
    final format = RegExp(r'(\d{2}):(\d{2})');

    final tidurMatch = format.firstMatch(jamTidur);
    final bangunMatch = format.firstMatch(jamBangunTidur);

    if (tidurMatch == null || bangunMatch == null) {
      return 'Invalid time format';
    }

    final tidurHour = int.parse(tidurMatch.group(1)!);
    final tidurMinute = int.parse(tidurMatch.group(2)!);

    final bangunHour = int.parse(bangunMatch.group(1)!);
    final bangunMinute = int.parse(bangunMatch.group(2)!);

    final tidur = DateTime(2024, 1, 1, tidurHour, tidurMinute);
    final bangun = DateTime(2024, 1, 2, bangunHour, bangunMinute); // Assume sleep over midnight

    final duration = bangun.difference(tidur);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    return '${hours}h ${minutes}m';
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }
}
