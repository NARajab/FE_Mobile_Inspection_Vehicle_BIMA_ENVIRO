import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../history/screens/historyKkh.dart';

class ForemanKkh extends StatefulWidget {
  const ForemanKkh({super.key});

  @override
  _ForemanKkhState createState() => _ForemanKkhState();
}

class _ForemanKkhState extends State<ForemanKkh> {
  String filterText = '';
  bool isSearching = false;

  final List<Map<String, String>> data = [
    {
      'name': 'Asep',
      'date': '2024-07-06',
      'role': 'foreman',
      'day': 'Monday',
      'jamPulangKerja': '18:00',
      'jamTidur': '22:00',
      'jamBangunTidur': '06:00',
      'jamBerangkat': '07:00',
      'subtitle': 'Fit to work',
    },
    {
      'name': 'Kurniawan',
      'date': '2024-07-05',
      'role': 'foreman',
      'day': 'Tuesday',
      'jamPulangKerja': '17:00',
      'jamTidur': '21:00',
      'jamBangunTidur': '05:00',
      'jamBerangkat': '06:00',
      'subtitle': 'Headache',
    },
    {
      'name': 'Kusep',
      'date': '2024-07-05',
      'role': 'foreman',
      'day': 'Tuesday',
      'jamPulangKerja': '17:30',
      'jamTidur': '22:30',
      'jamBangunTidur': '06:30',
      'jamBerangkat': '07:30',
      'subtitle': 'Tiredness',
    },
    {
      'name': 'Hermawan',
      'date': '2024-07-05',
      'role': 'foreman',
      'day': 'Tuesday',
      'jamPulangKerja': '17:45',
      'jamTidur': '21:45',
      'jamBangunTidur': '05:45',
      'jamBerangkat': '06:45',
      'subtitle': 'Fit to work',
    },
  ];

  @override
  void initState() {
    super.initState();
    _updateTitles();
  }

  void _updateTitles() {
    for (var item in data) {
      final date = DateTime.parse(item['date']!);
      final formattedDate = DateFormat('dd MMMM yyyy').format(date);
      item['title'] = '$formattedDate - ${item['name']}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              filterText = value.toLowerCase();
            });
          },
        )
            : const Text('Validation form KKH'),
        backgroundColor: const Color(0xFF304FFE),
        elevation: 5,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
        toolbarHeight: 55,
        leading: IconButton(
          icon: Icon(isSearching ? Icons.clear : Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () {
            if (isSearching) {
              setState(() {
                isSearching = false;
                filterText = '';
              });
            } else {
              Navigator.pop(context);
            }
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  filterText = '';
                }
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: data
            .where((item) =>
        item['title']!.toLowerCase().contains(filterText) ||
            item['subtitle']!.toLowerCase().contains(filterText))
            .map((item) => _buildCard(
          context,
          item,
        ))
            .toList(),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistoryKkhScreen(
              day: item['day']!,
              date: item['date']!,
              jamPulangKerja: item['jamPulangKerja']!,
              jamTidur: item['jamTidur']!,
              jamBangunTidur: item['jamBangunTidur']!,
              jamBerangkat: item['jamBerangkat']!,
              keluhan: item['subtitle']!,
              role: item['role']!,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: ListTile(
          title: Text(item['title']!),
          subtitle: Text(item['subtitle']!),
        ),
      ),
    );
  }
}
