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
      'jamTidur': '22:00',
      'jamBangunTidur': '06:00',
      'subtitle': 'Fit to work',
      'imageUrl': 'https://ik.imagekit.io/AliRajab03/IMG-1719707258551._H7RYLl8f_.jpg?updatedAt=1719707261329'
    },
    {
      'name': 'Kurniawan',
      'date': '2024-07-05',
      'role': 'foreman',
      'day': 'Tuesday',
      'jamTidur': '21:00',
      'jamBangunTidur': '05:00',
      'subtitle': 'Headache',
      'imageUrl': 'https://ik.imagekit.io/AliRajab03/IMG-1717269588897._L1v_b3Xxs.jpeg?updatedAt=1717269592622'
    },
    {
      'name': 'Kusep',
      'date': '2024-07-05',
      'role': 'foreman',
      'day': 'Tuesday',
      'jamTidur': '22:30',
      'jamBangunTidur': '06:30',
      'subtitle': 'Tiredness',
      'imageUrl': 'https://ik.imagekit.io/AliRajab03/IMG-1716628280492._vYkSwuJFd.png?updatedAt=1716628284144'
    },
    {
      'name': 'Hermawan',
      'date': '2024-07-05',
      'role': 'foreman',
      'day': 'Tuesday',
      'jamTidur': '21:45',
      'jamBangunTidur': '05:45',
      'subtitle': 'Fit to work',
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
              jamTidur: item['jamTidur']!,
              jamBangunTidur: item['jamBangunTidur']!,
              role: item['role']!,
              imageUrl: item['imageUrl']!,
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
