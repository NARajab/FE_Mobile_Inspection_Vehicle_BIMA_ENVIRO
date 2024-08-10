import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/features/Setting/screens/change_password.dart';
import 'package:myapp/features/Setting/screens/profile.dart';
import 'package:myapp/features/authentication/screens/forgot_password.dart';
import 'package:myapp/features/history/screens/history.dart';
import 'package:myapp/features/home/screens/kkh.dart';
import 'package:myapp/features/home/screens/p2h/timesheet/postscript.dart';
import 'package:myapp/features/home/screens/p2h/pph_ex.dart';
import 'package:myapp/features/home/screens/p2h/timesheet/timesheet.dart';
import 'package:myapp/features/home/screens/p2h/timesheet/location.dart';
import 'package:myapp/features/home/screens/p2h/pph.dart';
import 'package:myapp/features/home/screens/p2h/pph_bl.dart';
import 'package:myapp/features/home/screens/p2h/pph_bs.dart';
import 'package:myapp/features/home/screens/p2h/pph_dt.dart';
import 'package:myapp/features/home/screens/p2h/pph_lv.dart';
import 'features/authentication/screens/first_page.dart';
import 'features/authentication/screens/login_page.dart';
import 'features/authentication/screens/send_email_forgot_password.dart';
import 'features/home/screens/homepage.dart';
import 'features/Setting/screens/setting.dart';
import 'dart:async';

Future main() async {
  await dotenv.load(fileName: ".env");
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
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SafetyScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPassword(token: ''),
        '/reset-password': (context) => const SendEmailForgotPasswordScreen(),
        '/home': (context) => const HomePage(),
        '/history': (context) => const HistoryScreen(),
        '/settings': (context) => const SettingScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/change-password': (context) => const ChangePasswordScreen(),
        '/p2h': (context) => p2hScreen(),
        '/kkh': (context) => const KkhScreen(),
        '/blForm': (context) => p2hBlScreen(id: ModalRoute.of(context)!.settings.arguments as int),
        '/dtForm': (context) => p2hDtScreen(id: ModalRoute.of(context)!.settings.arguments as int),
        '/lvForm': (context) => p2hLvScreen(id: ModalRoute.of(context)!.settings.arguments as int),
        '/bsForm': (context) => p2hBsScreen(id: ModalRoute.of(context)!.settings.arguments as int),
        '/exForm': (context) => p2hExScreen(id: ModalRoute.of(context)!.settings.arguments as int),
        '/location': (context) => const LocationScreen()
        // '/timesheet': (context) => TimesheetScreen(locationId: locationId),
        // '/postscript': (context) => PostscriptScreen(),
      },
    );
  }
}