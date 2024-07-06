import 'package:flutter/material.dart';

class ExcavatorTemplate extends StatelessWidget {
  final String date;
  final String entry;

  const ExcavatorTemplate({
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
        leading: const Icon(Icons.build),
        title: const Text('Excavator'),
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
