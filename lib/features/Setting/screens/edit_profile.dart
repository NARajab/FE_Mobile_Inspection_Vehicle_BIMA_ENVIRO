import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

  void saveChanges() {
    Map<String, dynamic> editedData = {
      'username': usernameController.text,
      'email': emailController.text,
      'phoneNumber': phoneNumberController.text,
      'profileImageUrl': newProfileImageUrl,
      'profileImageFile': newProfileImage,
    };
    Navigator.pop(context, editedData);
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
}
