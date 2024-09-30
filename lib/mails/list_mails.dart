import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MailListScreen extends StatefulWidget {
  @override
  _MailListScreenState createState() => _MailListScreenState();
}

class _MailListScreenState extends State<MailListScreen> {
  List<dynamic> mails = [];

  @override
  void initState() {
    super.initState();
    fetchMails();
  }

  Future<void> fetchMails() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/mails/'));
    if (response.statusCode == 200) {
      setState(() {
        mails = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load mails');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mails"),
      ),
      body: ListView.builder(
        itemCount: mails.length,
        itemBuilder: (context, index) {
          final mail = mails[index];
          return ListTile(
            title: Text(mail['subject']),
            subtitle: Text(mail['sender']),
          );
        },
      ),
    );
  }
}