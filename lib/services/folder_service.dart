import 'dart:convert';
import 'package:http/http.dart' as http;

class FolderService {
  //final String apiUrl = "http://your-api-url/api/folders/";
  final String apiUrl = "http://192.168.1.133:8000/api/folders/";

  Future<List<dynamic>> fetchFolders() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load folders');
    }
  }

  Future<void> createFolder(String name) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode({'name': name}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to create folder");
    }
  }
}