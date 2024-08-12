import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/features/Setting/services/settings_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentUsername;
  final String currentEmail;
  final String currentPhoneNumber;
  final String currentProfileImageUrl;
  final File? currentProfileImageFile;

  const EditProfileScreen({
    super.key,
    required this.currentUsername,
    required this.currentEmail,
    required this.currentPhoneNumber,
    required this.currentProfileImageUrl,
    required this.currentProfileImageFile,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String? newProfileImageUrl;
  File? newProfileImage;

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.currentUsername;
    emailController.text = widget.currentEmail;
    phoneNumberController.text = widget.currentPhoneNumber;
    newProfileImageUrl = widget.currentProfileImageUrl;
    newProfileImage = widget.currentProfileImageFile;
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        newProfileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> saveChanges() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      ProfileServices profileServices = ProfileServices();
      try {
        await profileServices.updateProfile(
          token,
          usernameController.text,
          emailController.text,
          phoneNumberController.text,
          newProfileImage,
        );

        // Show success notification
        _showFlushbar('Success', 'Profile updated successfully.', isSuccess: true);

        // Delay the navigation slightly to allow the Flushbar to finish its animation
        await Future.delayed(const Duration(milliseconds: 2000));

        // Return the edited data to the previous screen
        Map<String, dynamic> editedData = {
          'username': usernameController.text,
          'email': emailController.text,
          'phoneNumber': phoneNumberController.text,
          'profileImageUrl': widget.currentProfileImageUrl,
          'profileImageFile': newProfileImage,
        };
      } catch (e) {
        // Show error notification
        _showFlushbar('Error', 'Failed to update profile: $e');
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
        backgroundColor: const Color(0xFF304FFE),
        title: const Text('Edit Profile'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: newProfileImage != null
                    ? FileImage(newProfileImage!)
                    : NetworkImage(newProfileImageUrl!) as ImageProvider,
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF304FFE),
                textStyle: const TextStyle(
                  fontSize: 18,
                ),
                foregroundColor: Colors.white,
                elevation: 5,
              ),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
  void _navigateBack(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/profile');
  }
}
