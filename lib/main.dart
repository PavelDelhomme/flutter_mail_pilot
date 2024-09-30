import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication/login_screen.dart';
import 'mails/list_mails.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userEmail = prefs.getString('user_email');

  runApp(MyApp(initialRoute: userEmail != null ? '/mails': '/'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mail Pilot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Définir les routes pour la navigation
      routes: {
        '/': (context) => LoginScreen(),
        '/mails': (context) => MailListScreen(),
      },
      initialRoute: initialRoute,
    );
  }
}
