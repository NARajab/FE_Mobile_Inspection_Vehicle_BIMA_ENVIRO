import 'package:flutter/material.dart';
import 'package:myapp/features/history/screens/historyP2h.dart';
import 'package:myapp/features/history/screens/historyKkh.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String filterText = '';
  bool isSearching = false;

  final List<Map<String, String>> p2hHistoryData = [
    {'date': '01 April 2024 - Bulldozer', 'subtitle': 'Description for P2H item 1'},
    {'date': '02 April 2024 - Dump Truck', 'subtitle': 'Description for P2H item 2'},
    {'date': '02 April 2024 - Light Vehicle', 'subtitle': 'Description for P2H item 2'},
    {'date': '02 April 2024 - Sarana Bus', 'subtitle': 'Description for P2H item 2'},
    {'date': '02 April 2024 - Excavator', 'subtitle': 'Description for P2H item 2'},
  ];

  final List<Map<String, String>> kkhHistoryData = [
    {'day': 'Monday', 'date': '10 January 2024', 'subtitle': 'Fit to work'},
    {'day': 'Tuesday', 'date': '11 January 2024', 'subtitle': 'Sakit Kepala'},
    // Add more history items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isSearching = !isSearching;
            if (!isSearching) {
              filterText = '';
            }
          });
        },
        backgroundColor: const Color(0xFF304FFE),
        child: const Icon(Icons.search, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            shadowColor: Colors.transparent,
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
            child: TabBarView(
              children: [
                _buildP2HTab(),
                _buildKKHTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildP2HTab() {
    List<Map<String, String>> filteredData = p2hHistoryData.where((item) =>
    item['date']!.toLowerCase().contains(filterText) ||
        item['subtitle']!.toLowerCase().contains(filterText)
    ).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isSearching)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  filterText = value.toLowerCase();
                });
              },
            ),
          ),
        Expanded(
          child: filteredData.isEmpty
              ? const Center(child: Text('No results found'))
              : ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            children: filteredData.map((item) => GestureDetector(
              onTap: () {
                navigateToHistoryP2h(
                  context,
                  'Bulldozer',
                  '2024-07-06',
                  'driver',
                );
              },
              child: Card(
                elevation: 3,
                child: ListTile(
                  title: Text(item['date']!),
                  subtitle: Text(item['subtitle']!),
                ),
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }



  Widget _buildKKHTab() {
    List<Map<String, String>> filteredData = kkhHistoryData.where((item) =>
    item['day']!.toLowerCase().contains(filterText) ||
        item['date']!.toLowerCase().contains(filterText) ||
        (item['keluhan'] != null && item['keluhan']!.toLowerCase().contains(filterText))
    ).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isSearching)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  filterText = value.toLowerCase();
                });
              },
            ),
          ),
        Expanded(
          child: filteredData.isEmpty
              ? const Center(child: Text('No results found'))
              : ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            children: filteredData.map((historyItem) => GestureDetector(
              onTap: () {
                navigateToHistoryKkh(
                    context,
                    day: historyItem['day']!,
                    date: historyItem['date']!,
                    jamTidur: '22:00',
                    jamBangunTidur: '06:00',
                    role: 'driver',
                    imageUrl: 'https://ik.imagekit.io/AliRajab03/IMG-1720826221625._Igyktated.jpg?updatedAt=1720826233501'
                );
              },
              child: Card(
                elevation: 3,
                child: ListTile(
                  title: Text(historyItem['date']!),
                  subtitle: Text(historyItem['subtitle']!),
                ),
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }



  void navigateToHistoryP2h(
      BuildContext context, String idVehicle, String date, String role) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HistoryP2hScreen(idVehicle: idVehicle, date: date, role: role),
      ),
    );
  }

  void navigateToHistoryKkh(
      BuildContext context, {
        required String day,
        required String date,
        required String jamTidur,
        required String jamBangunTidur,
        required String imageUrl,
        required String role
      }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryKkhScreen(
          day: day,
          date: date,
          jamTidur: jamTidur,
          jamBangunTidur: jamBangunTidur,
          role: role,
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}
