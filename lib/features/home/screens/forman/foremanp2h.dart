import 'package:flutter/material.dart';
import 'package:myapp/features/home/screens/forman/foremanValidationP2h.dart';

class ForemanP2h extends StatefulWidget {
  const ForemanP2h({super.key});

  @override
  _ForemanP2hState createState() => _ForemanP2hState();
}

class _ForemanP2hState extends State<ForemanP2h> {
  String filterText = '';
  bool isSearching = false;

  final List<Map<String, String>> data = [
    {'title': '01 April 2024 - Bulldozer', 'subtitle': 'Desta', 'idVehicle': 'Bulldozer', 'date': '2024-07-06', 'role': 'foreman'},
    {'title': '02 April 2024 - Dump Truck', 'subtitle': 'Sule', 'idVehicle': 'Dump Truck', 'date': '2024-07-05', 'role': 'foreman'},
    {'title': '02 April 2024 - Light Vehicle', 'subtitle': 'Andre', 'idVehicle': 'Light Vehicle', 'date': '2024-07-05', 'role': 'foreman'},
    {'title': '02 April 2024 - Sarana Bus', 'subtitle': 'Parto', 'idVehicle': 'Sarana Bus', 'date': '2024-07-05', 'role': 'foreman'},
    {'title': '02 April 2024 - Excavator', 'subtitle': 'Aziz Gagap', 'idVehicle': 'Excavator', 'date': '2024-07-05', 'role': 'foreman'},
  ];

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
            : const Text('Validation form P2H'),
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
          item['title']!,
          item['subtitle']!,
          item['idVehicle']!,
          item['date']!,
          item['role']!,
        ))
            .toList(),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String subtitle, String idVehicle, String date, String role) {
    return GestureDetector(
      onTap: () {
        navigateToForemanValidationP2h(context, idVehicle, date, role);
      },
      child: Card(
        elevation: 3,
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}

void navigateToForemanValidationP2h(BuildContext context, String idVehicle, String date, String role) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Foremanvalidationp2hScreen(idVehicle: idVehicle, date: date, role: role),
    ),
  );
}
