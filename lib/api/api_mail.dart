import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mail_pilot/models/mail.dart';

Future<List<Mail>> fetchMails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('jwt_token'); // Récupérer le token
  if (token == null) {
    throw Exception("Token not found");
  }

  final response = await http.get(
    //Uri.parse('http://127.0.0.1:8000/api/mails/'),
    Uri.parse('http://192.168.1.133:8000/api/mails/'),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    },
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