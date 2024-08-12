import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:myapp/features/Setting/services/settings_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String username = 'Loading...';
  String email = 'Loading...';
  String profileImageUrl = 'Loading...';
  File? profileImageFile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      try {
        ProfileServices profileServices = ProfileServices();
        Map<String, dynamic> userData = await profileServices.getUserById(token);

        setState(() {
          username = userData['user']['name'] ?? 'No Name';
          email = userData['user']['Auth']['email'] ?? 'No Email';
          profileImageUrl = userData['user']['imageUrl'] ?? 'No Image';
        });
      } catch (e) {
        // Handle the error appropriately, maybe show an error message
        print('Error loading profile: $e');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildOptionCard(context, 'Profile', 'assets/images/profile.png', () => _onProfileTap(context)),
            _buildOptionCard(context, 'Change Password', 'assets/images/cp.png', () => _onChangePasswordTap(context)),
            _buildOptionCard(context, 'Logout', 'assets/images/logout.png', () => _onLogoutTap(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: profileImageFile != null
                ? FileImage(profileImageFile!)
                : NetworkImage(profileImageUrl) as ImageProvider,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                username ?? 'Loading...',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                email ?? 'Loading...',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context, String title, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset(imagePath, width: 30, height: 30),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateBack(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _onProfileTap(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  void _onChangePasswordTap(BuildContext context) {
    Navigator.pushNamed(context, '/change-password');
  }

  void _onLogoutTap(BuildContext context) {
    Flushbar(
      title: "Logout",
      message: "Are you sure you want to logout?",
      duration: null,
      mainButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _logout(context);
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      isDismissible: true,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      borderRadius: BorderRadius.circular(8),
      backgroundColor: Colors.black,
      icon: const Icon(
        Icons.warning,
        size: 28.0,
        color: Colors.yellow,
      ),
      leftBarIndicatorColor: Colors.yellow,
    ).show(context);
  }


  void _logout(BuildContext context) async {
    // Remove the token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    // Navigate to the login page
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
          (Route<dynamic> route) => false,
    );
  }
}
