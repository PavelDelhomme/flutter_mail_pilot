import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_mail.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.189:8000/api/token/'), // Endpoint JWT
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Stocker le JWT
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', data['access']);

        // Configure les paramètres IMAP de l'utilisateur
        await configureIMAP(emailController.text, passwordController.text, data['access']);

        // Navigue vers la page des emails
        Navigator.pushReplacementNamed(context, '/mails');
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Login Failed"),
            content: Text("Invalid credentials."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Login Error"),
          content: Text("An error occurred: $e"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            ElevatedButton(
              onPressed: login,
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
