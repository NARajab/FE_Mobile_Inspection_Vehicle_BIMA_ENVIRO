import 'package:flutter/material.dart';
import 'package:myapp/features/authentications/screens/forgot_password.dart';
import 'features/authentications/screens/first_page.dart';
import 'features/authentications/screens/login_page.dart';
import 'features/authentications/screens/send_email_forgot_password.dart';
import 'features/home/screens/homepage.dart';
import 'features/Setting/screens/setting.dart';
import 'package:uni_links2/uni_links.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void _initDeepLinkListener() {
    _sub = linkStream.listen((String? link) {
      if (link != null) {
        _handleDeepLink(link);
      }
    }, onError: (err) {
      print('Failed to receive link: $err');
    });
  }

  void _handleDeepLink(String link) {
    Uri uri = Uri.parse(link);
    if (uri.path == '/reset-password') {
      String? token = uri.queryParameters['token'];
      if (token != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotPassword(token: token),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      routes: {
        '/': (context) => const SafetyScreen(),
        '/login': (context) => LoginScreen(),
        '/forgot-password': (context) => ForgotPassword(token: '',),
        '/reset-password': (context) => SendEmailForgotPasswordScreen(),
        '/home': (context) => const HomePage(),
        '/settings': (context) => const Setting()
      },
    );
  }
}
