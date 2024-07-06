import 'package:flutter/material.dart';

class BusTemplate extends StatelessWidget {
  final String date;
  final String entry;

  const BusTemplate({
    Key? key,
    required this.date,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: const Icon(Icons.directions_bus),
        title: const Text('Bus'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date),
            Text(entry),
          ],
        ),
        onTap: () {
          // Implement onTap action if needed
        },
      ),
    );
  }
}
