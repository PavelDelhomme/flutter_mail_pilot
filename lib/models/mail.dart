class Mail {
  final String id;
  final String from;
  final String to;
  final String subject;
  final String body;
  final DateTime dateReceived;
  final bool isRead;
  final bool isArchived;

  Mail({
    required this.id,
    required this.from,
    required this.to,
    required this.subject,
    required this.body,
    required this.dateReceived,
    this.isRead = false,
    this.isArchived = false,
  });
}