import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mail_pilot/models/mail.dart';

Future<List<Mail>> fetchMails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // URI PC Portable Django : 192.168.1.189
  final response = await http.get(
    Uri.parse('http://192.168.1.189:8000/api/login_with_email/'),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Mail(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      subject: json['subject'],
      body: json['body'],
      dateReceived: DateTime.parse(json['date']),
    )).toList();
  } else {
    throw Exception("Failed to load emails");
  }
}