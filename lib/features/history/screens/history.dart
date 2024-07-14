import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    {'date': '01 April 2024 - Bulldozer', 'subtitle': 'Description for P2H item 1', 'isValidated': 'false'},
    {'date': '02 April 2024 - Dump Truck', 'subtitle': 'Description for P2H item 2', 'isValidated': 'false'},
    {'date': '01 April 2024 - Light Vehicle', 'subtitle': 'Description for P2H item 2', 'isValidated': 'true'},
    {'date': '02 April 2024 - Sarana Bus', 'subtitle': 'Description for P2H item 2', 'isValidated': 'false'},
    {'date': '02 April 2024 - Excavator', 'subtitle': 'Description for P2H item 2', 'isValidated': 'true'},
  ];

  final List<Map<String, String>> kkhHistoryData = [
    {
      'day': 'Monday',
      'date': '10 January 2024',
      'subtitle': 'Fit to work',
      'totalJamTidur': '9h 10m',
      'imageUrl': 'https://ik.imagekit.io/AliRajab03/IMG-1715870568918._KGSHwcx2a.jpg?updatedAt=1715870572864',
      'isValidated': 'true'
    },
    {
      'day': 'Tuesday',
      'date': '11 January 2024',
      'subtitle': 'Sakit Kepala',
      'totalJamTidur': '6h 10m',
      'imageUrl': 'https://ik.imagekit.io/AliRajab03/IMG-1715411463248._y3tmnY5j2.png?updatedAt=1715411473412',
      'isValidated': 'false'
    },
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

    // Sorting the filtered data
    filteredData.sort((a, b) {
      // Parse the dates to DateTime objects
      DateTime dateA = DateFormat('dd MMMM yyyy').parse(a['date']!);
      DateTime dateB = DateFormat('dd MMMM yyyy').parse(b['date']!);

      // Compare dates first (newest first)
      int dateComparison = dateB.compareTo(dateA);
      if (dateComparison != 0) {
        return dateComparison;
      }

      // If dates are the same, compare isValidated (false first)
      bool isValidatedA = a['isValidated'] == 'true';
      bool isValidatedB = b['isValidated'] == 'true';
      return isValidatedA ? 1 : -1; // false (not validated) should come first
    });

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
                  item['subtitle']!,
                  item['date']!,
                  item['driver']!,
                  (item['isValidated'] == 'true') as String,
                );
              },
              child: Card(
                elevation: 3,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['date']!),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: item['isValidated'] == 'true' ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: item['isValidated'] == 'true'
                                  ? Colors.green.withOpacity(0.5)
                                  : Colors.red.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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

    // Sort data berdasarkan tanggal 'day'
    filteredData.sort((a, b) {
      DateTime dateA = DateFormat('dd MMMM yyyy').parse(a['date']!);
      DateTime dateB = DateFormat('dd MMMM yyyy').parse(b['date']!);
      return dateB.compareTo(dateA); // descending order, use dateA.compareTo(dateB) for ascending
    });

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
                    totalJamTidur: historyItem['totalJamTidur']!,
                    role: 'driver',
                    imageUrl: historyItem['imageUrl']!,
                    isValidated: historyItem['isValidated'] == 'true');
              },
              child: Card(
                elevation: 3,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(historyItem['date']!),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: historyItem['isValidated'] == 'true' ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: historyItem['isValidated'] == 'true'
                                  ? Colors.green.withOpacity(0.5)
                                  : Colors.red.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
      BuildContext context,
      String idVehicle,
      String date,
      String role,
      String isValidated
      ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HistoryP2hScreen(idVehicle: idVehicle, date: date, role: role, isValidated: isValidated == 'true',),
      ),
    );
  }

  void navigateToHistoryKkh(
      BuildContext context, {
        required String day,
        required String date,
        required String totalJamTidur,
        required String imageUrl,
        required String role,
        required bool isValidated
      }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryKkhScreen(
          day: day,
          date: date,
          totalJamTidur: totalJamTidur,
          role: role,
          imageUrl: imageUrl,
            isValidated: isValidated
        ),
      ),
    );
  }
}
