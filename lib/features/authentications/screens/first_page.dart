import 'package:flutter/material.dart';
import 'login_page.dart';

class SafetyScreen extends StatefulWidget {
  const SafetyScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SafetyScreenState createState() => _SafetyScreenState();
}

class _SafetyScreenState extends State<SafetyScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          SafetyPage(
            imagePath: 'assets/first.png',
            title: 'Welcome To Inspection Vehicle',
            onNext: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          SafetyPage(
            imagePath: 'assets/second.png',
            title: 'Safety is Most Important',
            onNext: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          const SignInPage(),
        ],
      ),
    );
  }
}

class SafetyPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onNext;

  const SafetyPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(imagePath, height: 300),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            IconButton(
              onPressed: onNext,
              icon: const Icon(Icons.arrow_forward),
              iconSize: 38, // Sesuaikan ukuran ikon sesuai kebutuhan
              tooltip: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Ubah warna latar belakang sesuai keinginan
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/signin.png', height: 300),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => LoginScreen()),
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => LoginScreen(),
                      transitionsBuilder: (_, anim, __, child){
                        return FadeTransition(
                          opacity: anim,
                          child: child
                          );
                        }, 
                        transitionDuration: const Duration(milliseconds: 600),
                      )
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF050C9C), // Ubah warna tombol sesuai keinginan
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Ubah radius border sesuai keinginan
                  ),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 18),
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}

