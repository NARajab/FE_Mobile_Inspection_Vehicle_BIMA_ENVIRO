import 'package:flutter/material.dart';
import 'package:myapp/features/history/screens/historyP2h.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: const [
        Card(
          elevation: 3,
          child: ListTile(
            title: Text('01 April 2024'),
            subtitle: Text('Description for KKH item 1'),
          ),
        ),
        Card(
          elevation: 3,
          child: ListTile(
            title: Text('02 April 2024'),
            subtitle: Text('Description for KKH item 2'),
          ),
        ),
        // Add more Card widgets for additional history items
      ],
    );
  }
}
