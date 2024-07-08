import 'package:flutter/material.dart';
import 'package:myapp/features/history/screens/historyP2h.dart';
import 'package:myapp/features/history/screens/historyKkh.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 5,
          shadowColor: Colors.black,
          backgroundColor: const Color(0xFF304FFE),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            dividerHeight: 2,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'P2H'),
              Tab(text: 'KKH'),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: const TabBarView(
            children: [
              P2HHistoryScreen(),
              KKHHistoryScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

// Example of navigating to HistoryP2hScreen
void navigateToHistoryP2h(BuildContext context, String idVehicle, String date) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HistoryP2hScreen(idVehicle: idVehicle, date: date),
    ),
  );
}

class P2HHistoryScreen extends StatelessWidget {
  const P2HHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        GestureDetector(
          onTap: () {
            navigateToHistoryP2h(context, 'Bulldozer', '2024-07-06');
          },
          child: const Card(
            elevation: 3,
            child: ListTile(
              title: Text('01 April 2024 - Bulldozer'),
              subtitle: Text('Description for P2H item 1'),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            navigateToHistoryP2h(context, 'Dump Truck', '2024-07-05');
          },
          child: const Card(
            elevation: 3,
            child: ListTile(
              title: Text('02 April 2024 - Dump Truck'),
              subtitle: Text('Description for P2H item 2'),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            navigateToHistoryP2h(context, 'Light Vehicle', '2024-07-05');
          },
          child: const Card(
            elevation: 3,
            child: ListTile(
              title: Text('02 April 2024 - Light Vehicle'),
              subtitle: Text('Description for P2H item 2'),
            ),
          ),
        ),GestureDetector(
          onTap: () {
            navigateToHistoryP2h(context, 'Sarana Bus', '2024-07-05');
          },
          child: const Card(
            elevation: 3,
            child: ListTile(
              title: Text('02 April 2024 - Sarana Bus'),
              subtitle: Text('Description for P2H item 2'),
            ),
          ),
        ),GestureDetector(
          onTap: () {
            navigateToHistoryP2h(context, 'Excavator', '2024-07-05');
          },
          child: const Card(
            elevation: 3,
            child: ListTile(
              title: Text('02 April 2024 - Excavator'),
              subtitle: Text('Description for P2H item 2'),
            ),
          ),
        ),
      ],
    );
  }
}

class KKHHistoryScreen extends StatelessWidget {
  const KKHHistoryScreen({super.key});

  final List<Map<String, String>> kkhHistoryData = const [
    {'day': 'Monday', 'date': '10 January 2024', 'jamPulangKerja': '18:00', 'jamTidur': '22:00', 'jamBangunTidur': '06:00', 'jamBerangkat': '08:00', 'keluhan': 'Fit to work'},
    {'day': 'Tuesday', 'date': '11 January 2024', 'jamPulangKerja': '17:00', 'jamTidur': '21:00', 'jamBangunTidur': '05:00', 'jamBerangkat': '07:00', 'keluhan': 'Sakit Kepala'},
    // Add more history items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: kkhHistoryData.map((historyItem) {
        return GestureDetector(
          onTap: () {
            navigateToHistoryKkh(
              context,
              day: historyItem['day']!,
              date: historyItem['date']!,
              jamPulangKerja: historyItem['jamPulangKerja']!,
              jamTidur: historyItem['jamTidur']!,
              jamBangunTidur: historyItem['jamBangunTidur']!,
              jamBerangkat: historyItem['jamBerangkat']!,
              keluhan: historyItem['keluhan']!,
            );
          },
          child: Card(
            elevation: 3,
            child: ListTile(
              title: Text(historyItem['date']!),
              subtitle: Text(historyItem['keluhan']!),
            ),
          ),
        );
      }).toList(),
    );
  }
}

void navigateToHistoryKkh(
    BuildContext context, {
      required String day,
      required String date,
      required String jamPulangKerja,
      required String jamTidur,
      required String jamBangunTidur,
      required String jamBerangkat,
      required String keluhan,
    }) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HistoryKkhScreen(
        day: day,
        date: date,
        jamPulangKerja: jamPulangKerja,
        jamTidur: jamTidur,
        jamBangunTidur: jamBangunTidur,
        jamBerangkat: jamBerangkat,
        keluhan: keluhan,
      ),
    ),
  );
}

