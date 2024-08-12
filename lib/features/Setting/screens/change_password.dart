import 'package:flutter/material.dart';
import 'package:myapp/features/Setting/services/settings_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:another_flushbar/flushbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final ProfileServices _profileServices = ProfileServices();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> changePassword() async {
    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      _showFlushbar('Error', 'Please fill in all fields.');
      return;
    }

    if (newPassword != confirmPassword) {
      _showFlushbar('Error', 'New password and confirm password do not match.');
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      try {
        await _profileServices.changePassword(
          oldPassword,
          newPassword,
          confirmPassword,
          token,
        );

        // Show success notification and navigate back to the settings screen
        _showFlushbar('Success', 'Password changed successfully.', isSuccess: true);
      } catch (e) {
        _showFlushbar('Error', 'Failed to change password: $e');
      }
    }
  }

  void _showFlushbar(String title, String message, {bool isSuccess = false}) {
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);

    if (isSuccess) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: oldPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Old Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF304FFE),
                  textStyle: const TextStyle(
                    fontSize: 18,
                  ),
                  foregroundColor: Colors.white,
                  elevation: 5,
                ),
                child: const Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
