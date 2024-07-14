import 'package:flutter/material.dart';
import 'package:myapp/features/history/screens/template/bulldozer_template.dart';
import 'package:myapp/features/history/screens/template/bus_template.dart';
import 'package:myapp/features/history/screens/template/dump_truck_template.dart';
import 'package:myapp/features/history/screens/template/excavator_template.dart';
import 'package:myapp/features/history/screens/template/light_vehicle_template.dart';

class HistoryP2hScreen extends StatelessWidget {
  final String idVehicle;
  final String date;
  final String role;
  final bool isValidated;

  const HistoryP2hScreen({
    super.key,
    required this.idVehicle,
    required this.date,
    required this.role,
    required this.isValidated
  });

  Widget _buildTemplate(String idVehicle, String date, String entry) {
    switch (idVehicle) {
      case 'Bulldozer':
        return BulldozerTemplate(date: date, entry: entry, role: role);
      case 'Dump Truck':
        return DumpTruckTemplate(date: date, entry: entry, role: role);
      case 'Excavator':
        return ExcavatorTemplate(date: date, entry: entry, role: role);
      case 'Light Vehicle':
        return LightVehicleTemplate(date: date, entry: entry, role: role);
      case 'Sarana Bus':
        return BusTemplate(date: date, entry: entry, role: role);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History P2H'),
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
            Navigator.pop(context);
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
      body: ListView.builder(
        itemCount: 1, // Just one entry based on your example
        itemBuilder: (context, index) {
          final entry = {
            'idVehicle': idVehicle,
            'date': date,
            'entry': 'Example entry description',
            'role': role
          };

          return _buildTemplate(idVehicle, date, entry['entry']!);
        },
      ),
    );
  }
}
