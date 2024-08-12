import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/features/home/screens/forman/foreman_validation_p2h.dart';

class ForemanP2h extends StatefulWidget {
  const ForemanP2h({super.key});

  @override
  _ForemanP2hState createState() => _ForemanP2hState();
}

class _ForemanP2hState extends State<ForemanP2h> {
  String filterText = '';
  bool isSearching = false;

  final List<Map<String, dynamic>> data = [
    {'title': '01 April 2024 - Bulldozer', 'subtitle': 'Desta', 'idVehicle': 'Bulldozer', 'date': '2024-07-06', 'role': 'Forman', 'isValidated': false},
    {'title': '01 April 2024 - Dump Truck', 'subtitle': 'Sule', 'idVehicle': 'Dump Truck', 'date': '2024-07-05', 'role': 'Forman', 'isValidated': true},
    {'title': '02 April 2024 - Light Vehicle', 'subtitle': 'Andre', 'idVehicle': 'Light Vehicle', 'date': '2024-07-05', 'role': 'Forman', 'isValidated': false},
    {'title': '02 April 2024 - Sarana Bus', 'subtitle': 'Parto', 'idVehicle': 'Sarana Bus', 'date': '2024-07-05', 'role': 'Forman', 'isValidated': true},
    {'title': '02 April 2024 - Excavator', 'subtitle': 'Aziz Gagap', 'idVehicle': 'Excavator', 'date': '2024-07-05', 'role': 'Forman', 'isValidated': false},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredData = data
        .where((item) =>
    item['title']?.toLowerCase().contains(filterText) ?? false ||
        item['subtitle']?.toLowerCase().contains(filterText) ?? false)
        .toList();

    filteredData.sort((a, b) {
      // Extract and parse the dates from the titles
      DateTime dateA = DateFormat('dd MMMM yyyy').parse(a['title']!.split(' - ')[0]);
      DateTime dateB = DateFormat('dd MMMM yyyy').parse(b['title']!.split(' - ')[0]);

      // Compare dates first (newest first)
      int dateComparison = dateB.compareTo(dateA);
      if (dateComparison != 0) {
        return dateComparison;
      }

      // If dates are the same, compare isValidated (false first)
      bool isValidatedA = a['isValidated'] as bool;
      bool isValidatedB = b['isValidated'] as bool;
      return isValidatedA ? 1 : -1; // false (not validated) should come first
    });

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
        children: filteredData
            .map((item) {
          final int p2hId = item['id'] as int? ?? 0; // Default to 0 or handle it as needed
          final String title = item['title'] ?? 'No Title';
          final String subtitle = item['subtitle'] ?? 'No Subtitle';
          final String idVehicle = item['idVehicle'] ?? 'Unknown Vehicle';
          final String date = item['date'] ?? 'No Date';
          final String role = item['role'] ?? 'Unknown Role';
          final bool isValidated = item['isValidated'] as bool? ?? false;

          return _buildCard(
            context,
            p2hId,
            title,
            subtitle,
            idVehicle,
            date,
            role,
            isValidated,
          );
        }).toList(),
      ),

    );
  }

  Widget _buildCard(BuildContext context, int p2hId, String title, String subtitle, String idVehicle, String date, String role, bool isValidated) {
    return GestureDetector(
      onTap: () {
        navigateToForemanValidationP2h(context, p2hId, idVehicle, date, role);
      },
      child: Card(
        elevation: 3,
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title ?? 'No Title'),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: isValidated ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: isValidated ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Text(subtitle ?? 'No Subtitle'),
        ),
      ),
    );
  }

}

void navigateToForemanValidationP2h(BuildContext context, int p2hId, String idVehicle, String date, String role) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Foremanvalidationp2hScreen(p2hId: p2hId,idVehicle: idVehicle, date: date, role: role),
    ),
  );
}