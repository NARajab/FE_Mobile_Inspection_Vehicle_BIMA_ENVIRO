import 'package:flutter/material.dart';
import 'package:myapp/features/home/screens/p2h/timesheet/timesheet.dart';
import '../../../services/p2h_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:another_flushbar/flushbar.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController pitController = TextEditingController();
  final TextEditingController disposalController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController fuelController = TextEditingController();
  final TextEditingController fuelhmController = TextEditingController();

  Widget _buildTextField(
      TextEditingController controller,
      String labelText, {
        TextInputType keyboardType = TextInputType.text,
        GestureTapCallback? onTap
      }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      keyboardType: keyboardType,
      onTap: onTap,
      readOnly: false,
    );
  }

  Future<void> _submitData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final requestData = {
      'pit': pitController.text,
      'disposal': disposalController.text,
      'location': locationController.text,
      'fuel': fuelController.text,
      'fuelhm': fuelhmController.text,
    };

    try {
      final response = await TimesheetServices().submitLocation(requestData, token);
      final int locationId = response['lokasi']['id'];

      _showSuccessFlushbar();
      _clearFields();

      // Navigate to TimesheetScreen with the new location ID
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TimesheetScreen(locationId: locationId),
        ),
      );
    } catch (e) {
      _showErrorFlushbar(e.toString());
    }
  }

  void _clearFields() {
    pitController.clear();
    disposalController.clear();
    locationController.clear();
    fuelController.clear();
    fuelhmController.clear();
  }

  void _showSuccessFlushbar() {
    Flushbar(
      message: 'Data submitted successfully',
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
    ).show(context);
  }

  void _showErrorFlushbar(String message) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
    ).show(context);
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    pitController.dispose();
    disposalController.dispose();
    locationController.dispose();
    fuelController.dispose();
    fuelhmController.dispose();
    super.dispose();
  }

  void _navigateBack(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/p2h');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timesheet Form'),
        backgroundColor: const Color(0xFF304FFE),
        elevation: 5,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(pitController, 'PIT'),
              _buildTextField(disposalController, 'DISPOSAL'),
              _buildTextField(locationController, 'LOKASI'),
              const SizedBox(height: 25),
              const Text(
                'PENGISIAN FUEL:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              _buildTextField(fuelhmController, 'HM'),
              _buildTextField(fuelController, 'FUEL'),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: _submitData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF304FFE),
                        textStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        foregroundColor: Colors.white,
                        elevation: 5,
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
