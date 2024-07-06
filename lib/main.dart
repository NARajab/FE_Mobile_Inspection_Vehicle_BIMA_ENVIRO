import 'package:flutter/material.dart';
import 'package:myapp/features/Setting/screens/change_password.dart';
import 'package:myapp/features/Setting/screens/profile.dart';
import 'package:myapp/features/authentication/screens/forgot_password.dart';
import 'package:myapp/features/history/screens/history.dart';
import 'package:myapp/features/home/screens/kkh.dart';
import 'package:myapp/features/home/screens/p2h/excavator/postscript.dart';
import 'package:myapp/features/home/screens/p2h/excavator/pphEx.dart';
import 'package:myapp/features/home/screens/p2h/excavator/timesheet.dart';
import 'package:myapp/features/home/screens/p2h/pph.dart';
import 'package:myapp/features/home/screens/p2h/pphBl.dart';
import 'package:myapp/features/home/screens/p2h/pphBs.dart';
import 'package:myapp/features/home/screens/p2h/pphDt.dart';
import 'package:myapp/features/home/screens/p2h/pphLv.dart';
import 'features/authentication/screens/first_page.dart';
import 'features/authentication/screens/login_page.dart';
import 'features/authentication/screens/send_email_forgot_password.dart';
import 'features/home/screens/homepage.dart';
import 'features/Setting/screens/setting.dart';
import 'package:uni_links2/uni_links.dart';
import 'dart:async';
import 'dart:io';

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
    if (Platform.isAndroid || Platform.isIOS) {
      _initDeepLinkListener();
    }
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
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => ForgotPassword(token: '',),
        '/reset-password': (context) => SendEmailForgotPasswordScreen(),
        '/home': (context) => const HomePage(),
        '/history': (context) => const HistoryScreen(),
        '/settings': (context) => const SettingScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/change-password': (context) => const ChangePasswordScreen(),
        '/p2h': (context) => p2hScreen(),
        '/kkh' : (context) => const KkhScreen(),
        '/blForm' : (context) => const p2hBlScreen(),
        '/dtForm' : (context) => const p2hDtScreen(),
        '/lvFrom' : (context) => const p2hLvScreen(),
        '/bsForm' : (context) => const p2hBsScreen(),
        '/exForm' : (context) => const p2hExScreen(),
        '/timesheet' : (context) => const TimesheetScreen(),
        '/postscript' : (context) => PostscriptScreen()
      },
    );
  }
}