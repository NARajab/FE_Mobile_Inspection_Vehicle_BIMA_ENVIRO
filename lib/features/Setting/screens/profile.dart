import 'package:flutter/material.dart';
import 'dart:io';
import 'package:myapp/features/Setting/services/settings_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'Loading...';
  String email = 'Loading...';
  String phoneNumber = 'Loading...';
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
          phoneNumber = userData['user']['phoneNumber'] ?? 'No Phone Number';
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
      appBar: AppBar(
        title: const Text('Profile'),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    currentUsername: username,
                    currentEmail: email,
                    currentPhoneNumber: phoneNumber,
                    currentProfileImageUrl: profileImageUrl,
                    currentProfileImageFile: profileImageFile,
                  ),
                ),
              ).then((editedData) {
                if (editedData != null) {
                  setState(() {
                    username = editedData['username'];
                    email = editedData['email'];
                    phoneNumber = editedData['phoneNumber'];
                    profileImageUrl = editedData['profileImageUrl'];
                    profileImageFile = editedData['profileImageFile'];
                  });
                }
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: profileImageFile != null
                  ? FileImage(profileImageFile!)
                  : NetworkImage(profileImageUrl) as ImageProvider,
            ),
            const SizedBox(height: 20),
            Text(
              username,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              email,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              phoneNumber,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
