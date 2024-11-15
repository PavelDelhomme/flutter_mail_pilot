import 'package:flutter/material.dart';
import 'package:mail_pilot/models/mail.dart';

import '../api/api_mail.dart';

class MailListScreen extends StatefulWidget {
  @override
  _MailListScreenState createState() => _MailListScreenState();
}

class _MailListScreenState extends State<MailListScreen> {
  late Future<List<Mail>> futureMails;

  @override
  void initState() {
    super.initState();
    futureMails = fetchMails(); // Récupère les emails au chargement
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mails"),
      ),
      body: FutureBuilder<List<Mail>>(
        future: futureMails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No emails found."));
          } else {
            final mails = snapshot.data!;
            return ListView.builder(
              itemCount: mails.length,
              itemBuilder: (context, index) {
                final mail = mails[index];
                return ListTile(
                  title: Text(mail.subject),
                  subtitle: Text(mail.from),
                );
              },
            );
          }
        },
      ),
    );
  }
}
