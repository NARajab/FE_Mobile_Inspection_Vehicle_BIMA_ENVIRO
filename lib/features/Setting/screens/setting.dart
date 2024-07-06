import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF304FFE),
      //   elevation: 5,
      //   shadowColor: Colors.black,
      //   title: const Text('Setting'),
      //   titleTextStyle: const TextStyle(
      //     color: Colors.white,
      //     fontSize: 20,
      //     fontWeight: FontWeight.w400
      //   ),
      //   toolbarHeight: 45,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios_new),
      //     color: Colors.white,
      //     onPressed: () {
      //       _navigateBack(context);
      //     },
      //   ),
      //   bottom: PreferredSize(
      //     preferredSize: const Size.fromHeight(6),
      //     child: Align(
      //       alignment: Alignment.centerLeft,
      //       child: Container(
      //         width: 69,
      //         height: 3,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildOptionCard(context, 'Profile', 'assets/images/profile.png', () => _onProfileTap(context) ),
            _buildOptionCard(context, 'Change Password', 'assets/images/cp.png', () => _onChangePasswordTap(context) ),
            _buildOptionCard(context, 'Logout', 'assets/images/logout.png', () => _onLogoutTap(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/person.png'),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'John Doe',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'johndoe@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
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
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: <Widget>[
          BasicDialogAction(
            title: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          BasicDialogAction(
            title: const Text("Logout"),
            onPressed: () {
              Navigator.of(context).popUntil(ModalRoute.withName('/'));
            },
          ),
        ],
      ),
    );
  }
}
