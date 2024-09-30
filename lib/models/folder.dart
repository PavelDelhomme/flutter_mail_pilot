import 'package:mail_pilot/models/mail.dart';

class Folder {
  final String name;
  final List<Mail> mails;

  Folder({
    required this.name,
    required this.mails,
  });
}