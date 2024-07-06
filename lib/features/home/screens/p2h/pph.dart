import 'package:flutter/material.dart';

class p2hScreen extends StatelessWidget {
  // Data untuk setiap item
  final List<Map<String, String>> items = [
    {
      'title': 'Bulldozer',
      'imagePath': 'assets/images/bl.png',
      'route': '/blForm'
    },
    {
      'title': 'Dump Truck',
      'imagePath': 'assets/images/dt.png',
      'route': '/dtForm'
    },
    {
      'title': 'Excavator',
      'imagePath': 'assets/images/ex.png',
      'route' : '/exForm'
    },
    {
      'title': 'Light Vehicle',
      'imagePath': 'assets/images/lv.png',
      'route' : '/lvFrom'
    },
    {
      'title': 'Sarana Bus',
      'imagePath': 'assets/images/bus.png',
      'route' : '/bsForm'
    },
  ];

  p2hScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('P2H'),
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
            _navigateBack(context);
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
      body: GridView.builder(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, items[index]['route']!);
            },
            child: _buildItemCard(items[index]['title']!, items[index]['imagePath']!, 150, 150),
          );
        },
      ),
    );
  }

  Widget _buildItemCard(String title, String imagePath, double width, double height) {
  return SizedBox(
    width: width,
    height: height,
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: width * 0.6,
            height: height * 0.6,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

  void _navigateBack(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }
}

