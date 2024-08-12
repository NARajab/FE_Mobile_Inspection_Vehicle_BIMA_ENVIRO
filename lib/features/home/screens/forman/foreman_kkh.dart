import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../history/screens/history_kkh.dart';

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
      'totalJamTidur': '7h 5m',
      'subtitle': 'Fit to work',
      'isValidated': 'true',
      'imageUrl': 'https://ik.imagekit.io/AliRajab03/IMG-1719707258551._H7RYLl8f_.jpg?updatedAt=1719707261329'
    },
    {
      'name': 'Kurniawan',
      'date': '2024-07-05',
      'role': 'foreman',
      'day': 'Tuesday',
      'totalJamTidur': '7h 5m',
      'subtitle': 'Headache',
      'isValidated': 'false',
      'imageUrl': 'https://ik.imagekit.io/AliRajab03/IMG-1717269588897._L1v_b3Xxs.jpeg?updatedAt=1717269592622'
    },
    {
      'name': 'Kusep',
      'date': '2024-07-05',
      'role': 'foreman',
      'day': 'Tuesday',
      'totalJamTidur': '7h 5m',
      'subtitle': 'Tiredness',
      'isValidated': 'true',
      'imageUrl': 'https://ik.imagekit.io/AliRajab03/IMG-1716628280492._vYkSwuJFd.png?updatedAt=1716628284144'
    },
    {
      'name': 'Hermawan',
      'date': '2024-07-05',
      'role': 'foreman',
      'day': 'Tuesday',
      'totalJamTidur': '7h 5m',
      'subtitle': 'Fit to work',
      'isValidated': 'false',
      'imageUrl': 'https://ik.imagekit.io/AliRajab03/IMG-1716042874421._bFugJUAE6f.png?updatedAt=1716042887192'
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
    // Sort data so that items with isValidated == 'false' appear first
    data.sort((a, b) => a['isValidated']!.compareTo(b['isValidated']!));

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
              date: item['date']!,
              totalJamTidur: item['totalJamTidur']!,
              role: item['role']!,
              imageUrl: item['imageUrl']!,
              isValidated: item['isValidated'] == 'true', subtitle: '',
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item['title']!),
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
    );
  }
}
