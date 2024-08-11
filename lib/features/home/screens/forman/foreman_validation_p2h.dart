import 'package:flutter/material.dart';
import '../../../history/screens/template/bulldozer_template.dart';
import '../../../history/screens/template/bus_template.dart';
import '../../../history/screens/template/dump_truck_template.dart';
import '../../../history/screens/template/excavator_template.dart';
import '../../../history/screens/template/light_vehicle_template.dart';

class Foremanvalidationp2hScreen extends StatelessWidget{
  final int p2hId;
  final String idVehicle;
  final String date;
  final String role;

  const Foremanvalidationp2hScreen({
    super.key,
    required this.p2hId,
    required this.idVehicle,
    required this.date,
    required this.role
  });

  Widget _buildTemplate(int p2hId, String role){
    switch (idVehicle) {
      case 'Bulldozer':
        return BulldozerTemplate(p2hId: p2hId);
      case 'Dump Truck':
        return DumpTruckTemplate(p2hId: p2hId);
      case 'Excavator':
        return ExcavatorTemplate(p2hId: p2hId);
      case 'Light Vehicle':
        return LightVehicleTemplate(p2hId: p2hId);
      case 'Sarana Bus':
        return BusTemplate(p2hId: p2hId);
      default:
        return Container();
    }
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validation form P2H'),
        backgroundColor:  const Color(0xFF304FFE),
        elevation: 5,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w400
        ),
        toolbarHeight: 45,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: (){
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
            )
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index){
          final entry = {
            'idVehicle': idVehicle,
            'date': date,
            'entry': 'Example entry description'
          };
          return _buildTemplate(p2hId, 'foreman');
        }
      ),
    );
  }
}